import React from "react";
import Sidebar from "react-sidebar";
import './DrawerSidebar.css';
import SidebarList from "./subcomponents/SidebarList/SidebarList";

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      open: false,
      dummyText: "Dummy Text"
    };
    this.onSetSidebarOpen = this.onSetSidebarOpen.bind(this);
  }

  // this.setState({sidebarOpen: false});

  onSetSidebarOpen(open) {
    this.setState({ open: open });
  }

  render() {

    // this.onSetSidebarOpen(false);

    return (
      <Sidebar
        sidebar={<SidebarList />}
        open={this.state.open}
        onSetOpen={() => this.onSetSidebarOpen(false)}
        // position fixed locks the sidebar to the right of the text
        styles={{ sidebar: { background: "white", position: "fixed" } }}
        pullRight={true}
        onClick={() => this.onSetSidebarOpen(false)}
        dragToggleDistance={10}
      >


        <a onClick={() => this.onSetSidebarOpen(true)} className="rightAlignButton">
          ☰
        </a>

      </Sidebar>
    );
  }
}

export default App;
