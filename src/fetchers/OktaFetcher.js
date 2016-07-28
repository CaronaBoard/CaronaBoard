import {OKTA_CONFIG} from '../express/config';

export default class OktaFetcher {

  constructor(requestPromise) {
    this.requestPromise = requestPromise;
  }

  getPublicKeys() {
    const requestOptions = {
      method: 'GET',
      uri: `${OKTA_CONFIG.OKTA_BASE_URL}/oauth2/v1/keys`,
      json: true
    };
    return this.requestPromise(requestOptions);
  }

}
