import VueCookies from 'vue-cookies'
import axios from 'axios';

//=================================================================
// constant
//=================================================================

const COOKIE_TOKEN_NAME = 'TimeManager_TM_TOKEN';
const HEADER_TOKEN = 'Authorization';

var TM_TOKEN = "";
export {TM_TOKEN}

//=================================================================
// functions
//=================================================================

//#############################################################

function get_cookie_token() {
  var iskey = is_token();

  if(iskey) {
    TM_TOKEN = window.$cookies.get(COOKIE_TOKEN_NAME);
    axios.defaults.headers.common[HEADER_TOKEN] = TM_TOKEN;
  }
  console.info(TM_TOKEN);

  return iskey;
}
export {get_cookie_token};


//#############################################################

function is_token() {
  return window.$cookies.isKey(COOKIE_TOKEN_NAME);
}
export {is_token};

//#############################################################

function set_token(token) {
  TM_TOKEN = 'Bearer ' + token;

  VueCookies.set(COOKIE_TOKEN_NAME, TM_TOKEN, '30d');
  axios.defaults.headers.common[HEADER_TOKEN] = TM_TOKEN;
}
export {set_token};
