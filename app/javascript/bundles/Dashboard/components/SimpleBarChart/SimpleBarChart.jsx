import React from "react";
import PropTypes from "prop-types";
import {BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, LabelList, Legend} from 'recharts';
import "./simple-bar-chart.scss";


const renderCustomizedLabel = (props) => {
  const { x, y, value } = props;
  const radius = 10;

  return (
    <g>
      <circle cx={x / 2} cy={y - radius} r={radius} fill="#8884d8" />
      <text x={x / 2} y={y - radius} fill="#fff" textAnchor="middle" dominantBaseline="middle">
        {value.split(' ')[0]}
      </text>
    </g>
  );
};

class SimpleBarChart extends React.Component {
  render () {
    if (this.props.data.length == 0) {
			return (
		  	<h4>You don't have any workpaces yet</h4>
		  );
		}
  	return (
    	<BarChart  data={this.props.data}>
       <CartesianGrid strokeDasharray="10 10"/>
       <XAxis dataKey="name"/>
       <YAxis/>
       <Tooltip/>
       <Legend />
       <Bar dataKey="completed" fill="#8884d8" minPointSize={5}>
          <LabelList dataKey="name" content={renderCustomizedLabel} />
        </Bar>
      </BarChart>
    );
  }
}

export default SimpleBarChart;
