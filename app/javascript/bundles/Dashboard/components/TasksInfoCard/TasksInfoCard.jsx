import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";

import * as api from '../../Api/layout_api';

import "./tasks-info-card.scss";
import SelectWorkspace from "../SelectWorkspace";
import SameDataComposedChart from "../SameDataComposedChart";
class TasksInfoCard extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      data: null,
      workspaces: null,
      active: 'All Workspaces',
      isLoading: true
    };
  }

  componentDidMount() {
    api.get_init_tasks_info()
      .then(data => {
        this.setState({ data: data.info, workspaces: data.workspaces, isLoading: false });
      })
  }

  handleClick(id){
    this.setState({ isLoading: true });
    let url = `/account/tasks-info`;
    if (id) {
      url = `/account/tasks-info?id=${id}`;
    }
    api.get_tasks_info(url)
      .then(data => {
        this.setState({ data: data.info, workspaces: data.workspaces, active: this.state.workspaces[id] || 'All Workspaces', isLoading: false });
      })
  }

  render() {
    if (this.state.isLoading) {
      return <h4>Loading...</h4>
    }
    return (
      <div className="task-info">
        <h3 className="card-title">Assigned to you tasks</h3>
        <SelectWorkspace workspaces={this.state.workspaces} active={this.state.active} onClick={(id) => this.handleClick(id)}/>
        <SameDataComposedChart data={this.state.data}/>
      </div>
    );
  }
}

export default TasksInfoCard;
