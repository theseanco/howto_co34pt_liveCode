import React from 'react'
import { StaticQuery, Link, graphql } from 'gatsby'
import './sidebar.css'

const Sidebar = ({ data }) => (

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
          return(
            <li key={index}><Link   to={data.node.frontmatter.path}>{data.node.frontmatter.section}.{data.node.frontmatter.subsection} - {data.node.frontmatter.title} </Link></li>
          )
        })
        }
      </ul>
      </div>
    )}
  />
)

export default Sidebar
