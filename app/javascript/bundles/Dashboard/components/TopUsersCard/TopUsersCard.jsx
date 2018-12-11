import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import {BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, LabelList, Legend} from 'recharts';
import "./top-users-card.scss";

const data = [
      {name: 'user 1', completed_tasks: 25},
      {name: 'user 2', completed_tasks: 30},
      {name: 'user 3', completed_tasks: 24},
      {name: 'user 4', completed_tasks: 15},
      {name: 'user 5', completed_tasks: 3},
];

const renderCustomizedLabel = (props) => {
  const { x, y, width, height, value } = props;
  const radius = 10;

  return (
    <g>
      <circle cx={x + width / 2} cy={y - radius} r={radius} fill="#8884d8" />
      <text x={x + width / 2} y={y - radius} fill="#fff" textAnchor="middle" dominantBaseline="middle">
        {value.split(' ')[1]}
      </text>
    </g>
  );
};

class TopUsersCard extends React.Component {
  render() {
    return (
      <SimpleBarChart />
    )
  }
}
class SimpleBarChart extends React.Component {
  render () {
  	return (
    	<BarChart width={600} height={300} data={data}
            margin={{top: 5, right: 30, left: 20, bottom: 5}}>
       <CartesianGrid strokeDasharray="3 3"/>
       <XAxis dataKey="name"/>
       <YAxis/>
       <Tooltip/>
       <Legend />
       <Bar dataKey="completed_tasks" fill="#8884d8" minPointSize={5}>
          <LabelList dataKey="name" content={renderCustomizedLabel} />
        </Bar>
      </BarChart>
    );
  }
}

export default TopUsersCard;
