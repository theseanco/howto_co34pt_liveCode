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
      <h1 style={{ margin: 0 }}>
        <Link
          to="/"
          style={{
            color: 'white',
            textDecoration: 'none',
          }}
        >
          {siteTitle}
        </Link>
      </h1>
      <div />
    </div>
  </div>
)

export default Header
