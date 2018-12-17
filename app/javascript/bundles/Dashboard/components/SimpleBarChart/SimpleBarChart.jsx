import React from "react";
import PropTypes from "prop-types";
import {ResponsiveContainer, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, LabelList, Legend} from 'recharts';
import "./simple-bar-chart.scss";


class SimpleBarChart extends React.Component {
  render () {
  	return (
      <ResponsiveContainer>
      	<BarChart  data={this.props.data}>
          <CartesianGrid strokeDasharray="3 3"/>
          <XAxis dataKey="name"/>
          <YAxis/>
          <Tooltip/>
          <Legend />
          <Bar dataKey="completed" fill="#8884d8" minPointSize={5} />
        </BarChart>
      </ResponsiveContainer>
    );
  }
}

export default SimpleBarChart;
