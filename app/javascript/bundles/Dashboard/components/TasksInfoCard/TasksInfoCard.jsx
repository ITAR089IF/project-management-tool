import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import { ComposedChart, Line, Area, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';
import "./tasks-info-card.scss";

class TasksInfoCard extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      data: null
    };
  }

  componentDidMount() {
    fetch('http://localhost:3000/account/tasks-info')
      .then(response => response.json())
      .then(data => this.setState({ data: data }));
  }

  render() {
    return (
      <SameDataComposedChart data={this.state.data}/>
    )
  }
}

class SameDataComposedChart extends React.Component {
	render () {
  	return (
      <ComposedChart width={600} height={400} data={this.props.data}
        margin={{top: 20, right: 20, bottom: 20, left: 20}}>
        <CartesianGrid stroke='#777'/>
        <XAxis dataKey="name"/>
        <YAxis />
        <Tooltip/>
        <Legend/>
        <Bar dataKey='uncompleted' barSize={20} fill='#413ea0'/>
        <Line type='monotone' dataKey='due soon' stroke='#ff7300'/>
        <Line type='monotone' dataKey='outdated' stroke='#ff4306'/>
      </ComposedChart>
    );
  }
}

export default TasksInfoCard;
