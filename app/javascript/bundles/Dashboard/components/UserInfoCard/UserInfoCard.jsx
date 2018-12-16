import React from "react";
import axios from 'axios';
import PropTypes from "prop-types";
import _ from "lodash";
import "./user-info-card.scss";

import UserInfoChart from "../UserInfoChart";

class UserInfoCard extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      data: null
    };
  }

  componentDidMount() {
    axios.get(`/account/user-info`)
     .then(resp => {
       this.setState({ data: resp.data.info });
     })
  }

  render () {
    return (
      <div className="user-info">
        <h3 className="user-info-title"> Your progress</h3>
        <UserInfoChart data={this.state.data}/>
      </div>
    );
  }
}

 export default UserInfoCard;