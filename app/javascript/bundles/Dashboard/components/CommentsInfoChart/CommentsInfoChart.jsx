import React from "react";
import PropTypes from "prop-types";
import "./comments-info-chart.scss";

import {ResponsiveContainer, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, LabelList, Legend} from 'recharts';

class CommentsInfoChart extends React.Component{
  render (){
    return(
      <ResponsiveContainer>
        <BarChart  data={this.props.data}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="name" stroke="#000"/>
          <YAxis orientation="left" stroke="#000"/>
          <Tooltip />
          <Legend />
          <Bar dataKey="comments" fill="#8884d8" minPointSize={5} />
        </BarChart>
      </ResponsiveContainer>
    );
  }
}

export default CommentsInfoChart;
