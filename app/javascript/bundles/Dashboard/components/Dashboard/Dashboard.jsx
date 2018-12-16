import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import { WidthProvider, Responsive } from "react-grid-layout";
import CommentsInfoCard  from '../CommentsInfoCard';

const ResponsiveReactGridLayout = WidthProvider(Responsive);

import "./dashboard.scss";
import "react-grid-layout/css/styles.css";
import "react-resizable/css/styles.css";

class Dashboard extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      layout: []
    }

    this.onLayoutChange = this.onLayoutChange.bind(this);
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
        <div className="box" key="a" data-grid={{i: 'a', x: 0, y: 0, w: 1, h: 2}}>
        <CommentsInfoCard/>
        </div>
        <div className="box" key="b" data-grid={{i: 'b', x: 1, y: 0, w: 1, h: 2}}>b</div>
        <div className="box" key="c" data-grid={{i: 'c', x: 2, y: 0, w: 1, h: 2}}>c</div>
        <div className="box" key="d" data-grid={{i: 'd', x: 3, y: 0, w: 1, h: 2}}>d</div>
        <div className="box" key="e" data-grid={{i: 'e', x: 4, y: 0, w: 1, h: 2}}>e</div>
      </ResponsiveReactGridLayout>
    )
  }
}

export default Dashboard;
