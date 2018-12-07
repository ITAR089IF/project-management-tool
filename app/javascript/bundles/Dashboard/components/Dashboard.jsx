import React from "react";
import _ from "lodash";
import GridLayout from "react-grid-layout";


export class Dashboard extends React.Component {
  constructor() {
    super();

    const layout = [
      {i: 'a', x: 0, y: 0, w: 1, h: 2},
      {i: 'b', x: 1, y: 0, w: 3, h: 2},
      {i: 'c', x: 4, y: 0, w: 1, h: 2}
    ];

    this.state = { layout };

    this.onLayoutChange = this.onLayoutChange.bind(this);
  }

  generateDOM() {
    return(_.map(this.state.layout, (l, i) => {
      return(
        <div className='box' key={l.i} data-grid={l}>{l.i}</div>
      );
    }));
  }

  onLayoutChange(layout) {
    this.setState({ layout });
    this.props.onLayoutChange(layout);
  }

  render() {
    return (
      <GridLayout
        {...this.props}
        layout={this.state.layout}
        onLayoutChange={this.onLayoutChange}
      >
        {this.generateDOM()}
      </GridLayout>
    )
  }
}

Dashboard.defaultProps = {
  className: "layout",
  cols: 12,
  rowHeight: 30,
  width: 1200,
  onLayoutChange: function() {}
}
