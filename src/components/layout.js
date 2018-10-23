import React from 'react'
import PropTypes from 'prop-types'
import Helmet from 'react-helmet'
import { StaticQuery, graphql } from 'gatsby'
import Media from "react-media";
import Waypoint from 'react-waypoint';

//components and css
import GridSidebar from './GridSidebar'
import DrawerSidebar from './DrawerSidebar'
import Header from './header'
import './layout.css'



const enter = () => {
    console.log("entered")
  }

const Layout = ({ children, displaySidebar }) => (


  <StaticQuery
    query={graphql`
      query SiteTitleQuery {
        site {
          siteMetadata {
            title
          }
        }
      }
    `}
    render={data => (
      <>
        <Helmet
          title={data.site.siteMetadata.title}
          meta={[
            { name: 'description', content: 'Sample' },
            { name: 'keywords', content: 'sample, something' },
          ]}
        >
          <html lang="en" />
        </Helmet>
        <Waypoint onPositionChange={console.log("changed")} onEnter={console.log("enter")} onLeave={console.log("leave")} >
          <div>
        <Header siteTitle={data.site.siteMetadata.title} />
      </div>
        </Waypoint>
        <div className="gridContainer">
        <div
          className="textBody"
        >
          {children}
        </div>

        <Media query="(min-width: 768px)">
          {matches => {
          if(matches) {
            return (
          <GridSidebar /> ) } else {
            return(<DrawerSidebar isOpen={false}/>)
          }
        }
      }
        </Media>
      </div>
      </>
    )}
  />
)

Layout.propTypes = {
  children: PropTypes.node.isRequired,
}

export default Layout
