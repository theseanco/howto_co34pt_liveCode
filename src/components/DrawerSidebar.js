import React from "react";
import Sidebar from "react-sidebar";

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      sidebarOpen: false
    };
    this.onSetSidebarOpen = this.onSetSidebarOpen.bind(this);
  }

  onSetSidebarOpen(open) {
    console.log("fired", open);
    this.setState({ sidebarOpen: open });
  }

  render() {
    return (
      <Sidebar
        sidebar={<b>ddSidebar content</b>}
        open={this.state.sidebarOpen}
        onSetOpen={() => this.onSetSidebarOpen(false)}
        styles={{ sidebar: { background: "white" } }}
      >
        <button onClick={() => this.onSetSidebarOpen(true)}>
          Open sidebar
        </button>

      </Sidebar>
    );
  }
}

export default App;
