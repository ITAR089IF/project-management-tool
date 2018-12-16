import ReactOnRails from 'react-on-rails';

import Dashboard from '../bundles/Dashboard/components/Dashboard';
import UserInfoCard from '../bundles/Dashboard/components/UserInfoCard';
import TopUsersCard from '../bundles/Dashboard/components/TopUsersCard';
import TasksInfoCard from '../bundles/Dashboard/components/TasksInfoCard';

ReactOnRails.register({
  Dashboard,
  UserInfoCard,
  TopUsersCard,
  TasksInfoCard
});
