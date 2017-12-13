import "../app/Stylesheets.elm";
import Elm from "../app/Main.elm";
import connectFirebase from "./firebase";

const getFlags = () => {
  const currentUser =
    Object.keys(localStorage)
      .filter(key => key.match(/firebase:authUser/))
      .map(key => JSON.parse(localStorage.getItem(key)))
      .map(user => ({ id: user.uid }))[0] || null;

  const profile = JSON.parse(localStorage.getItem("profile"));

  return {
    currentUser: currentUser,
    profile: profile
  };
};

const rootNode = document.getElementById("app");
rootNode.innerHTML = "";

const app = Elm.Main.embed(rootNode, getFlags());

connectFirebase(app.ports);
