import React from "react";
import PropTypes from "prop-types";
import _ from "lodash";
import { WidthProvider, Responsive } from "react-grid-layout";

const ResponsiveReactGridLayout = WidthProvider(Responsive);

import "./dashboard.scss";


export class Dashboard extends React.Component {
  constructor(props) {
    super(props);

    const layout = [
      {i: 'a', x: 0, y: 0, w: 1, h: 2},
      {i: 'b', x: 1, y: 0, w: 1, h: 2},
      {i: 'c', x: 2, y: 0, w: 1, h: 2},
      {i: 'd', x: 3, y: 0, w: 1, h: 2},
      {i: 'e', x: 4, y: 0, w: 1, h: 2},
      {i: 'f', x: 5, y: 0, w: 1, h: 2},
      {i: 'g', x: 6, y: 0, w: 1, h: 2},
      {i: 'h', x: 7, y: 0, w: 1, h: 2},
      {i: 'i', x: 8, y: 0, w: 1, h: 2},
      {i: 'j', x: 9, y: 0, w: 1, h: 2},
      {i: 'k', x: 10, y: 0, w: 1, h: 2},
      {i: 'l', x: 11, y: 0, w: 1, h: 2}
    ];

    this.state = {
      layout,
      layouts: {
        lg: layout,
        md: layout,
        sm: layout,
        xs: layout,
        xxs: layout
      }
    };

    this.onLayoutChange = this.onLayoutChange.bind(this);
  }

  generateLayout() {
    return(_.map(this.state.layout, (element) => {
      return(
        <div className="box" key={element.i} data-grid={element}>{element.i}</div>
      );
    }));
  }

  onLayoutChange(layout, layouts) {
    console.log(layouts);
    this.setState({ layouts });
  }

  render() {
    return (
      <ResponsiveReactGridLayout
        {...this.props}
        layouts={this.state.layouts}
        onLayoutChange={(layout, layouts) => this.onLayoutChange(layout, layouts)}
      >
        {this.generateLayout()}
      </ResponsiveReactGridLayout>
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
