import React from "react";
import PropTypes from "prop-types";
import {BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, LabelList, Legend} from 'recharts';
import "./simple-bar-chart.scss";


const renderCustomizedLabel = (props) => {
  const { x, y, width, height, value } = props;
  const radius = 10;

  return (
    <g>
      <circle cx={x + width / 2} cy={y - radius} r={radius} fill="#8884d8" />
      <text x={x + width / 2} y={y - radius} fill="#fff" textAnchor="middle" dominantBaseline="middle">
        {value.split(' ')[0]}
      </text>
    </g>
  );
};

class SimpleBarChart extends React.Component {
  render () {
  	return (
    	<BarChart width={600} height={300} data={this.props.data}
            margin={{top: 5, right: 30, left: 40, bottom: 5}}>
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
