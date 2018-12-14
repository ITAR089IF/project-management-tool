import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import "./top-workspaces-card.scss";

import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';

class TopWorkspacesCard extends React.Component {
  constructor(props) {
    super(props);
     this.state = {
      data: null
     };
  }

componentDidMount() {
  fetch('http://localhost:3000/account/top-workspaces')
    .then(response => response.json())
    .then(data => this.setState({ data: data }));
}

render() {
   return (
     <StackedBarChart data={this.state.data}/>
   )
 }
}

class StackedBarChart extends React.Component {
	render () {
  	return (
      <BarChart width={650} height={300} data={this.props.data}
          margin={{top: 20, right: 30, left: 20, bottom: 5}}>
        <CartesianGrid strokeDasharray="3 3"/>
        <XAxis dataKey="name"/>
        <YAxis/>
        <Tooltip/>
        <Legend />
        <Bar dataKey="completed" stackId="a" fill="#2bb712" />
        <Bar dataKey="uncompleted" stackId="a" fill="#f44242" />
      </BarChart>
    );
  }
}

export default TopWorkspacesCard;
