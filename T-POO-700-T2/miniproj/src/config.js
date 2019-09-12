import axios from 'axios';

//=================================================================
// constant
//=================================================================
var TM_URL = "http://localhost:4000/api/";
export {TM_URL}

/*
//=================================================================
// functions
//=================================================================

//#############################################################
function get_request_serv(url) {
  // get information from the api
  var ret;
  console.log('CONFIG - get_request_serv(' + TM_URL + url + ')')
  axios.get(TM_URL + url).then ((response) => {
    ret = response.data;
    console.log(response.data);
  })
  console.log(ret);
  return ret;
}
export {get_request_serv}

//#############################################################
function post_request_serv(url, json_params = {}) {
  // get information from the api
  console.log('CONFIG - post_request_serv(' + TM_URL + url + ') | parmams ' + JSON.stringify(json_params));
  axios.post(TM_URL + url,json_params)
  .then ((response) => {
    return treatResponse(response);
  });

  return false;
}
export {post_request_serv}
/*
async function get_request_serv(url) {
  var response;
  try {
    const r = await axios.get(TM_URL + url);
    response = r;
    console.log(response);
  } catch (error) {
    console.error(error);
  }
  return response;
}
export {get_request_serv}

//#############################################################
function put_request_serv(url, json_params) {
  // get information from the api
  console.log('CONFIG - put_request_serv(' + TM_URL + url + ') | parmas ' + json_params)
  axios.get(TM_URL + url, JSON.stringify(eval("(" + json_params + ")"))).then ((response) => {
    return treatResponse(response);
  })

  return false;
}

//#############################################################
function delete_request_serv(url) {
  // get information from the api
  console.log('CONFIG - delete_request_serv(' + TM_URL + url + ')')
  axios.delete(TM_URL + url).then ((response) => {
    return treatResponse(reponse);
  })

  return false;
}

//#############################################################
function treatResponse(response) {
  if(response.status == 200)
    return response.data;

  return false
}
*/
