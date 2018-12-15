import React from "react";
import PropTypes from "prop-types";
import { ComposedChart, Line, Area, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';
import "./same-data-composed-chart.scss";

class SameDataComposedChart extends React.Component {
	render () {
    const width = this.props.width;
    console.log(width);
  	return (
      <ComposedChart width={width} height={2*width/3} data={this.props.data} >
        <CartesianGrid stroke='#777'/>
        <XAxis dataKey="name" fontSize='0.7rem'/>
        <YAxis fontSize='0.7rem'/>
        <Tooltip/>
        <Legend width={width} wrapperStyle={{fontSize: '0.7rem', left: '0'}}/>
        <Bar dataKey='uncompleted' barSize={width/30} fill='#413ea0'/>
        <Line type='monotone' dataKey='due soon' stroke='#ff7300'/>
        <Line type='monotone' dataKey='outdated' stroke='#ff4306'/>
      </ComposedChart>
    );
  }
}
export default SameDataComposedChart;
