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
    <Intro />

    <h3>Contents</h3>
    {
      console.log(data)
    }

    {
      data.allMarkdownRemark.edges.map((data, i) => {
        return(<div key={i}> <Link to={data.node.frontmatter.path}> {data.node.frontmatter.section} - {data.node.frontmatter.subsection} - {data.node.frontmatter.title} </Link></div>)
      })
    }
  </Layout>
)

export const pageQuery = graphql`
  query IndexQuery {
    allMarkdownRemark(
      limit: 100
      # filter: {frontmatter: {published: {eq: true}}}
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

export default IndexPage
