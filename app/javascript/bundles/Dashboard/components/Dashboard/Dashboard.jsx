import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import { WidthProvider, Responsive } from "react-grid-layout";
<<<<<<< HEAD
import CommentsInfoCard  from '../CommentsInfoCard';
=======
import TopWorkspacesCard from '../TopWorkspacesCard';
import TasksInfoCard from '../TasksInfoCard'
import UserInfoCard  from '../UserInfoCard'
>>>>>>> 830fb6f6bb127c8479db9b9b2ca6d5e24303f4f2

const ResponsiveReactGridLayout = WidthProvider(Responsive);

import "./dashboard.scss";
import "react-grid-layout/css/styles.css";
import "react-resizable/css/styles.css";

class Dashboard extends React.Component {
  constructor(props) {
    super(props);

<<<<<<< HEAD
=======
    const defaults = [
      {i: 'tasks-info-card', x: 0, y: 0, w: 1, h: 2},
      {i: 'b', x: 1, y: 0, w: 1, h: 2},
      {i: 'user-info-card', x: 2, y: 0, w: 7, h: 9},
      {i: 'd', x: 3, y: 0, w: 1, h: 2},
      {i: 'top-workspaces-card', x: 5, y: 0, w: 6, h: 8}
    ];

>>>>>>> 830fb6f6bb127c8479db9b9b2ca6d5e24303f4f2
    this.state = {
      layout: []
    }

<<<<<<< HEAD
    this.onLayoutChange = this.onLayoutChange.bind(this);
=======
    this.onDragStop = this.onDragStop.bind(this);
    this.onResizeStop = this.onResizeStop.bind(this);
  }

  componentDidMount() {
    api.load_layout().then(data => {
      if(data != null) {
        this.setState({ layout: data.layout})
      }
    });
  }

  onDragStop(layout) {
    api.save_layout(layout);
>>>>>>> 830fb6f6bb127c8479db9b9b2ca6d5e24303f4f2
  }

  onLayoutChange(layout) {
    this.setState({ layout });
  }

  render() {
    return (
      <ResponsiveReactGridLayout
        className="layout"
        breakpoints={{lg: 1200}}
        cols={{lg: 12}}
        rowHeight={30}
        width={1200}
        onLayoutChange={(layout) => this.onLayoutChange(layout)}
        layouts={{lg: this.state.layout}}
      >
<<<<<<< HEAD
        <div className="box" key="a" data-grid={{i: 'a', x: 0, y: 0, w: 1, h: 2}}>a</div>
        <div className="box" key="b" data-grid={{i: 'b', x: 1, y: 0, w: 1, h: 2}}>b</div>
        <div className="box" key="c" data-grid={{i: 'c', x: 2, y: 0, w: 1, h: 2}}>c</div>
        <div className="box" key="d" data-grid={{i: 'd', x: 3, y: 0, w: 1, h: 2}}><CommentsInfoCard/></div>
        <div className="box" key="e" data-grid={{i: 'e', x: 4, y: 0, w: 1, h: 2}}>e</div>
=======
        <div className="box" key="tasks-info-card" data-grid={{i: 'tasks-info-card', x: 0, y: 0, w: 4, h: 8, minW: 4, minH: 8}}>
          <TasksInfoCard/>
        </div>
        <div className="box" key="b">b</div>
        <div className="box" key="user-info-card" data-grid={{i: 'user-info-card', x: 0, y: 0, w: 7, h: 9, minW: 7, minH: 9}}>
          <UserInfoCard/>
        </div>
        <div className="box" key="d">d</div>
        <div className="box" key="top-workspaces-card" data-grid={{i: 'top-workspaces-card', x: 4, y: 8, w: 6, h: 8, minW: 6, minH: 8}}>
          <TopWorkspacesCard/>
        </div>
>>>>>>> 830fb6f6bb127c8479db9b9b2ca6d5e24303f4f2
      </ResponsiveReactGridLayout>
    )
  }
}

export default Dashboard;
