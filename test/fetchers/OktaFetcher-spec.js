import OktaFetcher from '../../src/fetchers/OktaFetcher';
import {OKTA_CONFIG} from '../../src/express/config';
import sinon from 'sinon';
import {expect} from 'chai';

describe('OktaFetcher', () => {
  let requestPromiseSpy;
  let oktaFetcher;

  beforeEach(() => {
    requestPromiseSpy = sinon.spy();
    oktaFetcher = new OktaFetcher(requestPromiseSpy);
  });

  it('should get Okta Configuration', () => {
    const expectedOptions = {
       method: 'GET',
       uri: `${OKTA_CONFIG.OKTA_BASE_URL}/oauth2/v1/keys`,
       json: true
     };
    oktaFetcher.getPublicKeys();
    expect(requestPromiseSpy.calledWith(expectedOptions)).to.be.true;
  });

});
