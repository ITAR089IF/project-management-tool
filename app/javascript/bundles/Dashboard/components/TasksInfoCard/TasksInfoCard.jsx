import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
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
      isLoading: true,
    };
  }

  componentDidMount() {
    this.setState({ isLoading: true });
    fetch('http://localhost:3000/account/tasks-info')
      .then(response => response.json())
      .then(data => this.setState({ data: data.info, workspaces: data.workspaces, isLoading: false }));
  }

  handleClick(id){
    let workspaceUrl='';
    if (id != 'all'){
      workspaceUrl=`?id=${encodeURIComponent(id)}`;
    }
    this.setState({ isLoading: true });
    fetch(`http://localhost:3000/account/tasks-info${workspaceUrl}`)
      .then(response => response.json())
      .then(data => this.setState({ data: data.info, active: this.state.workspaces[id] || 'All Workspaces', isLoading: false }))
  }

  render() {
    if (this.state.isLoading) {
      return <p>Loading ...</p>;
    }

    return (
      <div className="task-info">
        <SelectWorkspace workspaces={this.state.workspaces} active={this.state.active} onClick={(id) => this.handleClick(id)}/>
        <SameDataComposedChart data={this.state.data}/>
      </div>
    )
  }
}

export default TasksInfoCard;
