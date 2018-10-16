import React from 'react'
import { Link } from 'gatsby'

import Layout from '../components/layout'

const IndexPage = ( {data} ) => (
  <Layout>
    <h1>Hi people</h1>
    <p>Welcome to your new Gatsby site.</p>
    <p>Now go build something great.</p>
    {
      data.allMarkdownRemark.edges.map((data, i) => {
        return(<div key={i}> <Link to={data.node.frontmatter.path}> {data.node.frontmatter.title} </Link></div>)
      })
    }
  </Layout>
)

export const pageQuery = graphql`
  query IndexQuery {
    allMarkdownRemark(
      limit: 10
      filter: {frontmatter: {published: {eq: true}}}
    ) {
      edges {
        node {
          frontmatter {
            title
            path
          }
        }
      }
    }
  }
`

export default IndexPage
