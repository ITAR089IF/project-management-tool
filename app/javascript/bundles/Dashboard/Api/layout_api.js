import axios from 'axios';

export const load_layout = (object) => {
  axios.get('http://localhost:3000/api/dashboard/load')
  .then(response => object.setState(response.data))
  .catch(error => console.error('Error:', error));
}

export const save_layout = (layout) => {
  axios.put(
    'http://localhost:3000/api/dashboard/save',
    { layout }
  ).catch(error => console.log(error));
}
