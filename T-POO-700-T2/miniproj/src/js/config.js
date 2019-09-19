import axios from 'axios';
import VueCookies from 'vue-cookies'



//=================================================================
// constant
//=================================================================
const TM_URL = "http://localhost:4000/api/";
export {TM_URL}

const COKKIE_TOKEN_NAME = 'TimeManager_TM_TOKEN';
const HEADER_TOKEN = 'Authorization';

//=================================================================
// functions
//=================================================================

//#############################################################

function get_cookie_token() {
  var iskey = window.$cookies.isKey(COKKIE_TOKEN_NAME);

  if(iskey)
    axios.defaults.headers.common[HEADER_TOKEN] = window.$cookies.get(COKKIE_TOKEN_NAME);;

  return iskey;
}
export {get_cookie_token};


//#############################################################

function set_token(token) {
  var tok = 'Bearer ' + token

  VueCookies.set(COKKIE_TOKEN_NAME, tok, '30d');
  axios.defaults.headers.common[HEADER_TOKEN] = tok;
}
export {set_token};
