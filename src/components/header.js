import React from 'react'
import { Link } from 'gatsby'

const Header = ({ siteTitle }) => (
  <div
    className="gridContainer"
    style={{
      background: 'rebeccapurple',
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
