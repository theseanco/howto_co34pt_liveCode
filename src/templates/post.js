import React from 'react';
import { Link } from 'gatsby';
import Helmet from 'react-helmet';
import Layout from '../components/layout'
import './post.css'

export default function Template({ data, pathContext }) {
  const {markdownRemark: post} = data;
  //destructuring proprties from path context
  const {prev, next} = pathContext
  const {title, path, section, subsection} = post.frontmatter

  return (
    <Layout>
    <div>
      <h1>{section}.{subsection} - {title}</h1>
      <div dangerouslySetInnerHTML={{__html: post.html}}/>
      <div className="twoLinking">
        {prev === null ? <div /> : <Link to={prev.frontmatter.path}>Previous</Link>}
        {next === null ? <div /> : <Link to={next.frontmatter.path}>Next</Link>}
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
        section
        subsection
      }
    }
  }
`
