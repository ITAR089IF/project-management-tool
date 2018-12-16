import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import { WidthProvider, Responsive } from "react-grid-layout";
import TasksInfoCard from '../TasksInfoCard'

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
        {i: 'e', x: 4, y: 8, w: 1, h: 2}
      ]
    }

    this.onLayoutChange = this.onLayoutChange.bind(this);
  }

  componentDidMount() {
    api.load_layout().then(data => {
      if(data == null) {
        return;
      }

      this.setState({ layout: data.layout})
    });
  }

  onLayoutChange(layout) {
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
        onLayoutChange={(layout) => this.onLayoutChange(layout)}
        layouts={{lg: this.state.layout}}
      >
        <div className="box" key="a" data-grid={{i: 'a', x: 0, y: 0, w: 3, h: 8, minW: 3, minH: 8}}>
          <TasksInfoCard/>
        </div>
        <div className="box" key="a">a</div>
        <div className="box" key="b">b</div>
        <div className="box" key="c">c</div>
        <div className="box" key="d">d</div>
        <div className="box" key="e">e</div>
      </ResponsiveReactGridLayout>
    )
  }
}

export default Dashboard;
