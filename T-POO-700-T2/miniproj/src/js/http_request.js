import axios from 'axios';
import  {
          TM_URL
        } from "./config.js";

//#############################################################

function get_request_serv(url, rep_function) {
  // get information from the api
  console.log('CONFIG - get_request_serv(' + TM_URL + url + ')')
  axios.get(TM_URL + url).then ((response) => {
    rep_function(treatResponse(response), response);
  })
}
export {get_request_serv}


//#############################################################

function post_request_serv(url, json_params = {}, rep_function) {
  // get information from the api
  console.log('CONFIG - post_request_serv(' + TM_URL + url + ') | parmams ' + JSON.stringify(json_params));
  axios.post(TM_URL + url,json_params)
  .then ((response) => {
    rep_function(treatResponse(response), response);
  });
}
export {post_request_serv}


//#############################################################

function put_request_serv(url, json_params = {}, rep_function) {
  // get information from the api
  console.log('CONFIG - put_request_serv(' + TM_URL + url + ') | parmas ' + json_params)
  axios.put(TM_URL + url, json_params)
  .then((response) => {
    rep_function(treatResponse(response), response);
  });
}


//#############################################################

function delete_request_serv(url, rep_function) {
  // get information from the api
  console.log('CONFIG - delete_request_serv(' + TM_URL + url + ')')
  axios.delete(TM_URL + url).then ((response) => {
    rep_function(treatResponse(response), reponse);
  });
}


//#############################################################

function treatResponse(response) {
  if(response.status == 200)
    return response.data;

  return false
}
