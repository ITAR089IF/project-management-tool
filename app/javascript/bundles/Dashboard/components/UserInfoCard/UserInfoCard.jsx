import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import "./user-info-card.scss";
import {ComposedChart, Bar, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend} from 'recharts';

const data = [
  {name: 'Monday', created: 90, assigned: 80, completed: 10},
  {name: 'Tuesday', created: 68, assigned: 97, completed: 15},
  {name: 'Wednesday', created: 97, assigned: 98, completed: 9},
  {name: 'Thursday', created: 180, assigned: 120, completed: 28},
  {name: 'Friday', created: 120, assigned: 108, completed: 10},
  {name: 'Saturday', created: 140, assigned: 80, completed: 17},
  {name: 'Sunday', created: 140, assigned: 80, completed: 27},
];

class UserInfoCard extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <UserInfoChart />
      </div>
    )
  }
}

class UserInfoChart extends React.Component {
  render () {
    return (
      <ComposedChart width={700} height={300} data={data}
          margin={{top: 20, right: 30, left: 20, bottom: 5}}>
        <XAxis dataKey="name" stroke="#000"/>
        <YAxis  orientation="left" stroke="#000"/>
        <CartesianGrid strokeDasharray="3 3"/>
        <Tooltip/>
        <Legend />
        <Bar dataKey='created' barSize={20} fill='#8884d8'/>
        <Bar dataKey='assigned' barSize={20} fill='#82ca9d'/>
        <Line type="monotone" dataKey="completed" stroke="#ff7300" />
      </ComposedChart>
    );
  }
}
 export default UserInfoCard;