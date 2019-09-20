import axios from 'axios';
import VueCookies from 'vue-cookies'



//=================================================================
// constant
//=================================================================
const TM_URL = "http://localhost:4000/api/";
export {TM_URL}

var TM_TOKEN = "";
export {TM_TOKEN}

const COKKIE_TOKEN_NAME = 'TimeManager_TM_TOKEN';
const HEADER_TOKEN = 'Authorization';

//=================================================================
// functions
//=================================================================

//#############################################################

function get_cookie_token() {
  var iskey = window.$cookies.isKey(COKKIE_TOKEN_NAME);

  if(iskey) {
    TM_TOKEN = window.$cookies.get(COKKIE_TOKEN_NAME);
    axios.defaults.headers.common[HEADER_TOKEN] = TM_TOKEN;
  }
  console.info(TM_TOKEN);

  return iskey;
}
export {get_cookie_token};


//#############################################################

function set_token(token) {
  TM_TOKEN = 'Bearer ' + token;

  VueCookies.set(COKKIE_TOKEN_NAME, TM_TOKEN, '30d');
  axios.defaults.headers.common[HEADER_TOKEN] = TM_TOKEN;
}
export {set_token};
