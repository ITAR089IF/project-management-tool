import axios from 'axios';

export const load_layout = () => {
  return axios.get('/api/dashboard/load')
    .then(response => { return response.data; })
    .then(data => { return data; })
    .catch(error => console.log(error));
}

export const save_layout = (layout) => {
  axios.put(
    '/api/dashboard/save',
    { layout }
  ).catch(error => console.log(error));
}

export const get_init_top_users = () => {
  return axios.get(`/account/top-users`)
    .then(response => { return response.data; })
    .then(data => { return data; })
    .catch(error => console.log(error));
}
 export const get_top_users  = (url) => {
  return axios.get(url)
    .then(response => { return response.data; })
    .then(data => { return data; })
    .catch(error => console.log(error));
}
