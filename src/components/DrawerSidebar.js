import React from "react";
import Sidebar from "react-sidebar";
import './DrawerSidebar.css'

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      open: false,
      dummyText: "fshfdfj"
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
        sidebar={<b>fdjdkhsjkfhsfdkj</b>}
        open={this.state.open}
        onSetOpen={() => this.onSetSidebarOpen(false)}
        styles={{ sidebar: { background: "white" } }}
        pullRight={true}
      >

        <a onClick={() => this.onSetSidebarOpen(true)} className="rightAlignButton">
          ☰
        </a>

      </Sidebar>
    );
  }
}

export default App;
