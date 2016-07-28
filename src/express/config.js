export const OKTA_CONFIG = {
  'OKTA_REDIRECT_URI': process.env.OKTA_REDIRECT_URI || 'http://localhost:8080/login/callback',
  'OKTA_CLIENT_ID': process.env.OKTA_CLIENT_ID,
  'OKTA_BASE_URL': process.env.OKTA_BASE_URL || 'https://thoughtworks.oktapreview.com',
  'OKTA_PUBLIC_KEYS': process.env.OKTA_PUBLIC_KEYS
};

export const SERVER_CONFIG = {
  'SESSION_SECRET': process.env.SESSION_SECRET
};
