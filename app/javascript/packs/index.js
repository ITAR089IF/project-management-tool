import ReactOnRails from 'react-on-rails';

import Dashboard from '../bundles/Dashboard/components/Dashboard';
import UserInfoCard from '../bundles/Dashboard/components/UserInfoCard';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  Dashboard,
  UserInfoCard
});
