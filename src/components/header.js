import React from 'react'
import { Link } from 'gatsby'

/*
SIDEBAR SHOULD END UP LIKE THIS:

    position: fixed;
    width: 350px;
    height: 100%;
    overflow: scroll;
    z-index: 400;
    top: 0;

Sidebar should also have this property when stuck to the top of the screen:

  height: 100vh
  overflow: scroll

So oncce the header is out of the way, you can then add:

  position: fixed;
  top: 0

Add this using react-waypoint.

*/

const Header = ({ siteTitle }) => (
  <div
    className="headerItem"
    style={{
      background: 'rebeccapurple',
      width: "100%"
    }}
  >
    <div className="textBody" >
      <h2 style={{ margin: 0 }}>
        <Link
          to="/"
          style={{
            color: 'white',
            textDecoration: 'none',
          }}
        >
          howto_&#8203;co34pt_&#8203;liveCode
        </Link>
      </h2>
      <div />
    </div>
  </div>
)

export default Header
