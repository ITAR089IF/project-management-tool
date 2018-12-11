import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import { ComposedChart, Line, Area, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';
import "./tasks-info-card.scss";

const data = [{name: '12/12', Uncompleted: 15, 'Due soon': 8, Outdated: 4},
              {name: '12/13', Uncompleted: 18, 'Due soon': 9, Outdated: 6},
              {name: '12/14', Uncompleted: 16, 'Due soon': 1, Outdated: 5},
              {name: '12/15', Uncompleted: 14, 'Due soon': 12, Outdated: 2},
              {name: '12/16', Uncompleted: 15, 'Due soon': 1, Outdated: 1},
              {name: '12/17', Uncompleted: 10, 'Due soon': 2, Outdated: 0},
              {name: '12/18', Uncompleted: 14, 'Due soon': 6, Outdated: 5}];

class TasksInfoCard extends React.Component {
  render() {
    return (
      <SameDataComposedChart />
    )
  }
}

class SameDataComposedChart extends React.Component {
	render () {
  	return (
      <ComposedChart width={600} height={400} data={data}
        margin={{top: 20, right: 20, bottom: 20, left: 20}}>
        <CartesianGrid stroke='#777'/>
        <XAxis dataKey="name"/>
        <YAxis />
        <Tooltip/>
        <Legend/>
        <Bar dataKey='Uncompleted' barSize={20} fill='#413ea0'/>
        <Line type='monotone' dataKey='Due soon' stroke='#ff7300'/>
        <Line type='monotone' dataKey='Outdated' stroke='#ff4306'/>
      </ComposedChart>
    );
  }
}

export default TasksInfoCard;
