import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import "./top-workspaces-card.scss";

import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';

const data = [
      {name: 'Workspace1', uncompleted_tasks: 8, completed_tasks: 5},
      {name: 'Workspace2', uncompleted_tasks: 0, completed_tasks: 8},
      {name: 'Workspace3', uncompleted_tasks: 4, completed_tasks: 9},
      {name: 'Workspace4', uncompleted_tasks: 10, completed_tasks: 7},
      {name: 'Workspace5', uncompleted_tasks: 4, completed_tasks: 4},
];
class TopWorkspacesCard extends React.Component {
  render() {
    return (
        <StackedBarChart />
    )
  }
}
 class StackedBarChart extends React.Component {
	render () {
  	return (
      <BarChart width={600} height={300} data={data}
          margin={{top: 20, right: 30, left: 20, bottom: 5}}>
        <CartesianGrid strokeDasharray="3 3"/>
        <XAxis dataKey="name"/>
        <YAxis/>
        <Tooltip/>
        <Legend />
        <Bar dataKey="completed_tasks" stackId="a" fill="#2bb712" />
        <Bar dataKey="uncompleted_tasks" stackId="a" fill="#f44242" />
      </BarChart>
    );
  }
}

export default TopWorkspacesCard;
