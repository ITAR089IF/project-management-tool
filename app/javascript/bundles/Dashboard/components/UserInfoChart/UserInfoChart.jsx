import React from "react";
import PropTypes from "prop-types";
import "./user-info-chart.scss";

import {ResponsiveContainer, ComposedChart, Bar, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend} from 'recharts';

class UserInfoChart extends React.Component {
  render () {
    return (
      <ResponsiveContainer>
      <ComposedChart data={this.props.data}>
        <XAxis dataKey="date" stroke="#000"/>
        <YAxis orientation="left" stroke="#000"/>
        <CartesianGrid strokeDasharray="3 3"/>
        <Tooltip />
        <Legend />
        <Bar dataKey='created' barSize={20} fill='#8884d8'/>
        <Bar dataKey='assigned' barSize={20} fill='#82ca9d'/>
        <Line type="monotone" dataKey="completed" stroke="#ff7300" />
      </ComposedChart>
      </ResponsiveContainer>
    );
  }
}

export default UserInfoChart;