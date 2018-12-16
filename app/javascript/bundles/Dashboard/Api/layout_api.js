import axios from 'axios';

export const load_layout = () => {
  return axios.get('/api/dashboard/load')
  .then(response => { return response.data; })
  .then(data => { return data; })
  .catch(error => console.error('Error:', error));
}

export const save_layout = (layout) => {
  axios.put(
    '/api/dashboard/save',
    { layout }
  ).catch(error => console.log(error));
}

export const get_init_tasks_info = () => {
  return axios.get(`/account/tasks-info`)
    .then(response => { return response.data; })
    .then(data => { return data; })
    .catch(error => console.log(error));
}

export const get_tasks_info  = (url) => {
  return axios.get(url)
    .then(response => { return response.data; })
    .then(data => { return data; })
    .catch(error => console.log(error));
}
