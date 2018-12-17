import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";

import axios from 'axios';
import * as api from '../../Api/layout_api';
import "./comments-info-card.scss";

import CommentsInfoChart from "../CommentsInfoChart";

class CommentsInfoCard extends React.Component {
  constructor(props) {
      super(props);
      this.state = {
        data: null
      };
}

componentDidMount() {
  api.get_init_comments_info()
    .then(data => {
      this.setState({ data: data.info });
    })
}

render() {
  return (
    <div className="comments-info">
      <h3 className="comments-info-title">Comments info</h3>
      <CommentsInfoChart data={this.state.data}/>
    </div>
  )
 }
}

export default CommentsInfoCard;
