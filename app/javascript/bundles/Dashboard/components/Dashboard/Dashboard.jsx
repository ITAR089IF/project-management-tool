import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import { WidthProvider, Responsive } from "react-grid-layout";
import UserInfoCard  from '../UserInfoCard'

import * as api from '../../Api/layout_api';
import * as config from '../config.js';

import "./dashboard.scss";
import "react-grid-layout/css/styles.css";
import "react-resizable/css/styles.css";

const ResponsiveReactGridLayout = WidthProvider(Responsive);

class Dashboard extends React.Component {
  constructor(props) {
    super(props);

    const defaults = [
      {i: 'a', x: 0, y: 0, w: 1, h: 2},
      {i: 'b', x: 1, y: 0, w: 1, h: 2},
      {i: 'c', x: 2, y: 0, w: 1, h: 2},
      {i: 'd', x: 3, y: 0, w: 1, h: 2},
      {i: 'e', x: 4, y: 0, w: 1, h: 2}
    ];

    this.state = {
      layout: this.props.layout != null ? this.props.layout : defaults
    }

    this.onDragStop = this.onDragStop.bind(this);
    this.onResizeStop = this.onResizeStop.bind(this);
  }

  componentDidMount() {
    api.load_layout().then(data => {
      if(data == null) {
        return;
      }

      this.setState({ layout: data.layout});
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
        useCSSTransforms={false}
      >
        <div className="box" key="a" data-grid={{i: 'a', x: 0, y: 0, w: 7, h: 8, minW: 7, minH: 8}}>
          <UserInfoCard/>
        </div>
        <div className="box" key="b" data-grid={{i: 'a', x: 0, y: 0, w: 2, h: 3, minW: 2, minH: 2}}>b</div>
        <div className="box" key="c" data-grid={{i: 'c', x: 2, y: 0, w: 1, h: 2}}>c</div>
        <div className="box" key="d" data-grid={{i: 'd', x: 3, y: 0, w: 1, h: 2}}>d</div>
        <div className="box" key="e" data-grid={{i: 'e', x: 4, y: 0, w: 1, h: 2}}>e</div>
      </ResponsiveReactGridLayout>
    )
  }
}

export default Dashboard;
