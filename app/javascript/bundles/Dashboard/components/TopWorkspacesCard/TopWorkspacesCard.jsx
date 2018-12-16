import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import axios from 'axios';
import * as api from '../../Api/layout_api';
import "./top-workspaces-card.scss";

import TopWorkspacesChart from '../TopWorkspacesChart';

class TopWorkspacesCard extends React.Component {
  constructor(props) {
    super(props);
     this.state = {
      data: null
     };
  }

componentDidMount() {
  api.get_init_top_workspaces()
      .then(data => {
        this.setState({ data: data.info });
      })
}

render() {
   return (
     <div className="top-workspaces">
        <h3 className="top-workspaces-title"> Top5 Workspaces:</h3>
        <TopWorkspacesChart data={this.state.data}/>
     </div>
   )
 }
}

export default TopWorkspacesCard;
