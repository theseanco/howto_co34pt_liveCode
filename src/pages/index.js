/*

todo:

Dynamically generate intro text by selectively querying the allMarkdownRemark html
Here's a way to do multiple queries: https://github.com/gatsbyjs/gatsby/issues/4977

*/

import React from 'react'
import { Link } from 'gatsby'

import Layout from '../components/layout'
import Intro from '../components/intro'

const IndexPage = ( {data} ) => (
  <Layout>
    <div dangerouslySetInnerHTML={{__html: data.readmeHTML.edges[0].node.html}} /> 


    <h3>Contents</h3>
    {
      console.log(data.readmeHTML.edges[0].node.html)
    }

    {
      data.contentsPage.edges.map((data, i) => {
        return(<div key={i}> <Link to={data.node.frontmatter.path}> {data.node.frontmatter.section} - {data.node.frontmatter.subsection} - {data.node.frontmatter.title} </Link></div>)
      })
    }
  </Layout>
)

export const pageQuery = graphql`
  query indexQuery {
    contentsPage:allMarkdownRemark(
      limit: 100
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
    readmeHTML:allMarkdownRemark(
      filter: {
        frontmatter: {section: {eq:0}}
      }
      limit:1
    ) {
      edges {
        node {
          html
        }
      }
    }
  }
`

export default IndexPage
