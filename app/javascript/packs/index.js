import ReactOnRails from 'react-on-rails';

import Dashboard from '../bundles/Dashboard/components/Dashboard';
import TopUsers from '../bundles/Dashboard/components/TopUsers';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  Dashboard,
  TopUsers
});
