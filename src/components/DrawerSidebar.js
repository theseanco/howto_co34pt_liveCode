import React from "react";
import Sidebar from "react-sidebar";

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      open: false
    };
    this.onSetSidebarOpen = this.onSetSidebarOpen.bind(this);
  }

  // this.setState({sidebarOpen: false});

  onSetSidebarOpen(open) {
    console.log("fired", open);
    this.setState({ open: open });
  }

  render() {

    // this.onSetSidebarOpen(false);

    return (
      <Sidebar
        sidebar={<b>ddSidebar content</b>}
        open={this.state.open}
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
