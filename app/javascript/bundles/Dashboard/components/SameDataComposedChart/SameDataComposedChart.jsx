import React from "react";
import PropTypes from "prop-types";
import { ResponsiveContainer, ComposedChart, Line, Area, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';
import "./same-data-composed-chart.scss";

class SameDataComposedChart extends React.Component {
	render () {
  	return (
			<ResponsiveContainer>
	      <ComposedChart data={this.props.data} >
	        <CartesianGrid stroke='#777'/>
	        <XAxis dataKey="name"/>
	        <YAxis/>
	        <Tooltip/>
	        <Legend/>
	        <Bar dataKey='uncompleted' fill='#413ea0'/>
	        <Line type='monotone' dataKey='due soon' stroke='#ff7300'/>
	        <Line type='monotone' dataKey='outdated' stroke='#ff4306'/>
	      </ComposedChart>
			</ResponsiveContainer>
    );
  }
}
export default SameDataComposedChart;
