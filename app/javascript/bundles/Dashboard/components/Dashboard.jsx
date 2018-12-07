import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import { Responsive as ResponsiveGridLayout } from "react-grid-layout";

import "./dashboard.scss";


export class Dashboard extends React.Component {
  constructor(props) {
    super(props);

    const layout = [
      {i: 'a', x: 0, y: 0, w: 1, h: 2},
      {i: 'b', x: 1, y: 0, w: 3, h: 2},
      {i: 'c', x: 4, y: 0, w: 1, h: 2}
    ];

    this.state = { layout };

    this.onLayoutChange = this.onLayoutChange.bind(this);
  }

  generateLayout() {
    return(_.map(this.state.layout, (element) => {
      return(
        <div className="box" key={element.i} data-grid={element}>{element.i}</div>
      );
    }));
  }

  onLayoutChange(layout) {
    this.setState({ layout });
    this.props.onLayoutChange(layout);
  }

  render() {
    return (
      <ResponsiveGridLayout
        {...this.props}
        layout={this.state.layout}
        onLayoutChange={this.onLayoutChange}
      >
        {this.generateLayout()}
      </ResponsiveGridLayout>
    )
  }
}

Dashboard.defaultProps = {
  className: "layout",
  breakpoints: {lg: 1200, md: 996, sm: 768, xs: 480, xxs: 0},
  cols: {lg: 12, md: 10, sm: 6, xs: 4, xxs: 2},
  rowHeight: 30,
  width: 1200,
  onLayoutChange: function() {}
}

Dashboard.propTypes = {
  className: PropTypes.string,
  breakpoints: PropTypes.object,
  cols: PropTypes.object,
  rowHeight: PropTypes.number,
  width: PropTypes.number,
  onLayoutChange: PropTypes.func
}
