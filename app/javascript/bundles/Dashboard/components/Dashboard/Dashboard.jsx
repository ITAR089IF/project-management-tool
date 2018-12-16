import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import { WidthProvider, Responsive } from "react-grid-layout";
import TopWorkspacesCard from '../TopWorkspacesCard';

import * as api from '../../Api/layout_api';
import * as config from '../config.js';

import "./dashboard.scss";
import "react-grid-layout/css/styles.css";
import "react-resizable/css/styles.css";

const ResponsiveReactGridLayout = WidthProvider(Responsive);

class Dashboard extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      layout: [
        {i: 'a', x: 0, y: 0, w: 1, h: 2},
        {i: 'b', x: 1, y: 2, w: 1, h: 2},
        {i: 'c', x: 2, y: 4, w: 1, h: 2},
        {i: 'd', x: 3, y: 6, w: 1, h: 2},
        {i: 'top-workspaces-card', x: 4, y: 8, w: 6, h: 8, minW: 6, minH: 8}
      ]
    }

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
  }

  onResizeStop(layout) {
    api.save_layout(layout);
  }

  render() {
    return (
      <ResponsiveReactGridLayout
        className="layout"
        breakpoints={{lg: 1200}}
        cols={{lg: 12}}
        rowHeight={30}
        width={1200}
        onDragStop={(layout) => this.onDragStop(layout)}
        onResizeStop={(layout) => this.onResizeStop(layout)}
        layouts={{lg: this.state.layout}}
      >
        <div className="box" key="a"></div>
        <div className="box" key="b">b</div>
        <div className="box" key="c">c</div>
        <div className="box" key="d">d</div>
        <div className="box" key="top-workspaces-card" data-grid={{i: 'top-workspaces-card', x: 4, y: 8, w: 6, h: 8, minW: 6, minH: 8}}>
          <TopWorkspacesCard/>
        </div>
      </ResponsiveReactGridLayout>
    )
  }
}

export default Dashboard;
