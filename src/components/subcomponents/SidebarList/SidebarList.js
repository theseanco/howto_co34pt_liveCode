import React from 'react'
import { StaticQuery, Link, graphql } from 'gatsby'
import './SidebarList.css'
import sectionNames from './SidebarNames'

const SidebarList = ({ data }) => (

  <StaticQuery
    query={graphql`
      query {
        allMarkdownRemark(
          limit: 100
          sort: {fields: [frontmatter___section, frontmatter___subsection], order: ASC}
          filter: {
            frontmatter: {section: {ne: 0}}
          }
        ) {
          edges {
            node {
              frontmatter {
                title
                path
                section
                subsection
              }
            }
          }
        }
      }
      `
    }
    render={data => (
      <div className="sidebarContents">
        <h4> Contents </h4>
        <ul>

        {
        data.allMarkdownRemark.edges.map((data, index) => {
          //See if we need a section title, if not, return null
          let title;
          if (data.node.frontmatter.subsection === 1) {
            title=<strong>{sectionNames[data.node.frontmatter.section-1]}</strong>
          } else {
            title = null
          }
          return(
            <div>
            {
            //return the title (if needed), and any page information
            }
            {title}
            <li key={index}><Link to={data.node.frontmatter.path}>{data.node.frontmatter.section}.{data.node.frontmatter.subsection} - {data.node.frontmatter.title} </Link></li>
            </div>
          )
        })
        }
      </ul>
      </div>
    )}
    />
)

export default SidebarList
