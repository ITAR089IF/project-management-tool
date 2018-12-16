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

export const get_init_user_info = () => {
  return axios.get(`/account/user-info`)
    .then(response => { return response.data; })
    .then(data => { return data; })
    .catch(error => console.log(error));
}