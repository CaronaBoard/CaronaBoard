import { error, success } from "./helpers";
import { getProfile } from "./profile";

export default (firebase, ports) => {
  const { database, auth } = firebase;

  ports.groupsList.subscribe(() =>
    database()
      .ref("groups")
      .once("value")
      .then(groups => ports.groupsListResponse.send(success(groups.val())))
      .catch(err => ports.groupsListResponse.send(error(err.message)))
  );

  ports.joinRequestsList.subscribe(request =>
    database()
      .ref("joinGroupRequests/" + request.groupId)
      .once("value")
      .then(joinGroupRequests =>
        ports.joinRequestsListResponse.send({
          groupId: request.groupId,
          response: success(joinGroupRequests.val())
        })
      )
      .catch(err =>
        ports.joinRequestsListResponse.send({
          groupId: request.groupId,
          response: error(err.message)
        })
      )
  );

  ports.createJoinGroupRequest.subscribe(joinGroupRequest =>
    getProfile(firebase, ports)
      .then(profile =>
        database()
          .ref(
            "joinGroupRequests/" +
              joinGroupRequest.groupId +
              "/" +
              auth().currentUser.uid
          )
          .set({ profile: profile.val() })
      )
      .then(() =>
        ports.createJoinGroupRequestResponse.send({
          groupId: joinGroupRequest.groupId,
          response: success(true)
        })
      )
      .catch(err =>
        ports.createJoinGroupRequestResponse.send({
          groupId: joinGroupRequest.groupId,
          response: error(err.message)
        })
      )
  );

  const removeJoinRequest = joinRequestResponse =>
    database()
      .ref(
        "joinGroupRequests/" +
          joinRequestResponse.groupId +
          "/" +
          joinRequestResponse.userId
      )
      .remove()
      .then(() =>
        ports.respondJoinRequestResponse.send({
          groupId: joinRequestResponse.groupId,
          userId: joinRequestResponse.userId,

          response: success(true)
        })
      )
      .catch(err =>
        ports.respondJoinRequestResponse.send({
          groupId: joinRequestResponse.groupId,
          userId: joinRequestResponse.userId,

          response: error(err.message)
        })
      );

  ports.respondJoinRequest.subscribe(joinRequestResponse => {
    if (joinRequestResponse.accepted) {
      database()
        .ref(
          "groups/" +
            joinRequestResponse.groupId +
            "/members/" +
            joinRequestResponse.userId
        )
        .set({ admin: false })
        .then(() => removeJoinRequest(joinRequestResponse))
        .catch(err =>
          ports.respondJoinRequestResponse.send({
            groupId: joinRequestResponse.groupId,
            userId: joinRequestResponse.userId,
            response: error(err.message)
          })
        );
    } else {
      removeJoinRequest(joinRequestResponse);
    }
  });

  ports.createGroup.subscribe(newGroup =>
    database()
      .ref("groups")
      .push({
        name: newGroup.name,
        members: {
          [auth().currentUser.uid]: { admin: true }
        }
      })
      .then(() => ports.createGroupResponse.send(success(true)))
      .catch(err => ports.createGroupResponse.send(error(err.message)))
  );
};
