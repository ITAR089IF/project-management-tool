import React from "react";
import axios from 'axios';
import PropTypes from "prop-types";
import _ from "lodash";

import UserInfoChart from "../UserInfoChart";
import * as api from '../../Api/layout_api';

import "./user-info-card.scss";

class UserInfoCard extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      data: null
    };
  }

  componentDidMount() {
    api.get_init_user_info()
      .then(data => {
        this.setState({ data: data.info });
      })
  }

  render () {
    return (
      <div className="user-info">
        <h3 className="user-info-title"> Your progress:</h3>
        <UserInfoChart data={this.state.data}/>
      </div>
    );
  }
}

export default UserInfoCard;
