import React from 'react';
import { Link } from 'gatsby';
import Helmet from 'react-helmet';
import Layout from '../components/layout'
import './post.css'

export default function Template({ data }) {
  const {markdownRemark: post} = data;
  return (
    <Layout>
    <div>
      <h1>{post.frontmatter.title}</h1>
      <div dangerouslySetInnerHTML={{__html: post.html}}/>
      <div className="twoLinking">
        <Link to="/404">Previous</Link>
        <Link to="/404">Next</Link>
      </div>
    </div>
  </Layout>
  )
}

export const postQuery = graphql`
  query($path: String!) {
    markdownRemark(frontmatter: { path: { eq: $path } }) {
      html
      frontmatter {
        path
        title
      }
    }
  }
`
