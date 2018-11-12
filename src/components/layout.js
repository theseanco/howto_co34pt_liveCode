import React, {ReactDOM} from 'react';
import PropTypes from 'prop-types';
import Helmet from 'react-helmet';
import { StaticQuery, graphql } from 'gatsby';
import Media from "react-media";
import Waypoint from 'react-waypoint';
import SidebarList from './subcomponents/SidebarList/SidebarList';

//components and css
// import GridSidebar from './GridSidebar'
import DrawerSidebar from './DrawerSidebar'
import Header from './header'
import './layout.css'
import './stickySidebar.css'
import VisibilitySensor from 'react-visibility-sensor'



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

        <div className="gridContainer">
        <div className="headerItem">
        <VisibilitySensor onChange={console.log("changed")} sctollCheck={true}>
        <Header />
        </VisibilitySensor>
        </div>

        <div
          className="textBody"
        >
          {children}
        </div>

        <Media query="(min-width: 768px)">
          {matches => {
          if(matches) {
            return (
          <div className="sticky-sidebar">
          <SidebarList />
          </div>
        ) } else {
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
