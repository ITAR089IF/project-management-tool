import ReactOnRails from 'react-on-rails';

import Dashboard from '../bundles/Dashboard/components/Dashboard';
import TopWorkspacesCard from '../bundles/Dashboard/components/TopWorkspacesCard';
import UserInfoCard from '../bundles/Dashboard/components/UserInfoCard';
import TasksInfoCard from '../bundles/Dashboard/components/TasksInfoCard';

ReactOnRails.register({
  Dashboard,
  TopWorkspacesCard,
  UserInfoCard,
  TasksInfoCard
});
