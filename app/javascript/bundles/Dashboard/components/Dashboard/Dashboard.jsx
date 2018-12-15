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
      layout: [],
      response: ""
    }

    this.onLayoutChange = this.onLayoutChange.bind(this);
  }

  componentDidMount() {
    api.load_layout().then(data => this.setState({ layout: data.layout}));;
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

      </ResponsiveReactGridLayout>
    )
  }
}

export default Dashboard;
