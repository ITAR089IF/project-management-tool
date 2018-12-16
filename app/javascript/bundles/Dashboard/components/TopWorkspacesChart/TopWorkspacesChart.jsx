import React from "react";
import PropTypes from "prop-types";
import "./top-workspaces-chart.scss";

import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

class TopWorkspacesChart extends React.Component {
	render () {
  	return (
      <ResponsiveContainer>
        <BarChart width={700} height={300} data={this.props.data}
            margin={{top: 20, right: 30, left: 20, bottom: 5}}>
          <CartesianGrid strokeDasharray="3 3"/>
          <XAxis dataKey="name"/>
          <YAxis/>
          <Tooltip/>
          <Legend />
          <Bar dataKey="completed" stackId="a" fill="#2bb712" />
          <Bar dataKey="uncompleted" stackId="a" fill="#f44242" />
        </BarChart>
      </ResponsiveContainer>
    );
  }
}

export default TopWorkspacesChart;
