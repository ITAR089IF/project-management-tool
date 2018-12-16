import React from "react";
import PropTypes from "prop-types";
import "./select-workspace.scss";
 class SelectWorkspace extends React.Component {
	render () {
    const workspaces = this.props.workspaces;
  	return (
      <div className="dropdown is-hoverable">
        <div className="dropdown-trigger">
          <button className="button" aria-haspopup="true" aria-controls="dropdown-menu">
            <span>{this.props.active}</span>
            <span className="icon is-small">
              <i className="fas fa-angle-down" aria-hidden="true"></i>
            </span>
          </button>
        </div>
        <div className="dropdown-menu" id="dropdown-menu" role="menu">
          <div className="dropdown-content">
            <li className="dropdown-item" key='1' onClick={() => this.props.onClick()}>{value}</li>
            { Object.entries(workspaces).map(([key, value]) => {
              return <li href="#" className="dropdown-item" key={key} onClick={() => this.props.onClick(key)}>
                        {value}
                      </li>
            })}
          </div>
        </div>
      </div>
    );
  }
}
 export default SelectWorkspace;
