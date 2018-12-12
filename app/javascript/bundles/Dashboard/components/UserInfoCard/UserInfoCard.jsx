import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import "./user-info-card.scss";
import {ComposedChart, Bar, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend} from 'recharts';

class UserInfoCard extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      data: null
    };
  }

  componentDidMount() {
    fetch('http://localhost:3000/account/user-info')
      .then(response => response.json())
      .then(data => this.setState({ data: data }));
  }

  render() {
    return (
      <div>
        <UserInfoChart data={this.state.data}/>
      </div>
    )
  }
}

class UserInfoChart extends React.Component {
  render () {
    return (
      <ComposedChart width={700} height={300} data={this.props.data}
          margin={{top: 20, right: 30, left: 20, bottom: 5}}>
        <XAxis dataKey="date" stroke="#000"/>
        <YAxis orientation="left" stroke="#000"/>
        <CartesianGrid strokeDasharray="3 3"/>
        <Tooltip />
        <Legend />
        <Bar dataKey='created' barSize={20} fill='#8884d8'/>
        <Bar dataKey='assigned' barSize={20} fill='#82ca9d'/>
        <Line type="monotone" dataKey="completed" stroke="#ff7300" />
      </ComposedChart>
    );
  }
}
 export default UserInfoCard;