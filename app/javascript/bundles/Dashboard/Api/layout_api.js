import axios from 'axios';

axios.defaults.baseURL = 'http://localhost:3000';

export const load_layout = (object) => {
  axios.get('/api/dashboard/load')
  .then(response => object.setState(response.data))
  .catch(error => console.error('Error:', error));
}

export const save_layout = (layout) => {
  axios.put(
    '/api/dashboard/save',
    { layout }
  ).catch(error => console.log(error));
}
