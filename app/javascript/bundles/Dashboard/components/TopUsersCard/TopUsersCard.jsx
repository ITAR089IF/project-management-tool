import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import axios from 'axios';
import * as api from '../../Api/layout_api';
import "./top-users-card.scss";

import SelectWorkspace from "../SelectWorkspace";
import SimpleBarChart from "../SimpleBarChart";


class TopUsersCard extends React.Component {
  constructor(props) {
    super(props);
      this.state = {
        data: null,
        workspaces: null,
        isLoading: true,
        collection: null,
        active: 0
      };
  }
  componentDidMount() {
    api.get_init_top_users()
    .then(data => {
      const id = Object.keys(data.workspaces)[0];
      this.setState({ data: data.info, workspaces: data.workspaces, active: data.workspaces[id], isLoading: false });
   })
  }

  handleClick(id){
      this.setState({ isLoading: true });
      let url = `/account/top-users`;
      if (id) {
        url = `/account/top-users?id=${id}`;
      }
      axios.get(url)
        .then(resp => {
          this.setState({ data: resp.data.info, workspaces: resp.data.workspaces, active: this.state.workspaces[0], isLoading: false });
        })
  }

  render() {
     if (this.state.isLoading) {
       return <p>Loading ...</p>;
     }

    return (
       <div className="top-users">
         <h3 className="card-title">Top users</h3>
         <SelectWorkspace workspaces={this.state.workspaces} active={this.state.active} onClick={(id) => this.handleClick(id)}/>
         <SimpleBarChart data={this.state.data}/>
       </div>
     )
   }
}

export default TopUsersCard;
