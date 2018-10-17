/*

Here's a way to do multiple queries: https://github.com/gatsbyjs/gatsby/issues/4977

Next and previous buttons: https://blog.bitsrc.io/build-your-own-blog-using-gatsby-and-react-a1255a5ab086

*/

import React from 'react'
import { Link } from 'gatsby'

import Layout from '../components/layout'

require("prismjs/plugins/line-numbers/prism-line-numbers.css")

const sectionNames = [
  'Introduction',
  'Basics',
  'Rhythm',
  'Melody and Pitch',
  'Non-Pattern Techniques',
  'Visuals and Data'
]

//a function to sort the output if it is fed the section.
//this could take object properties as an argument but I don't need it to right now.
const sortBySection = (inputArray) => {
  let array = [[]]
  let index = 0
  let prev = inputArray[0].node.frontmatter.section;
  inputArray.forEach((data,i) => {
    if (data.node.frontmatter.section === prev) {
      array[index].push(data);
    } else {
      array.push([]);
      index++;
      array[index].push(data);
    }
    prev = data.node.frontmatter.section;
  })
  return array
}

const IndexPage = ( {data} ) => (
  <Layout>
    <div id="introParagraph" dangerouslySetInnerHTML={{__html: data.readmeHTML.edges[0].node.html}} />

    <h3>Contents</h3>

    {
      sortBySection(data.contentsPage.edges).map((data,i) => {
        data.map((data,i) => {
          return(<div key={i}> <Link to={data.node.frontmatter.path}> {data.node.frontmatter.section} - {data.node.frontmatter.subsection} - {data.node.frontmatter.title} </Link></div>)
        })
        return(
          <div className="contents-section">
          <h4 style={{margin: "5px auto"}}>{i+1} - {sectionNames[i]}</h4>
          <span>
            {
            data.map((data,i) => {
          return(<div key={i}> <Link to={data.node.frontmatter.path}> {data.node.frontmatter.section}.{data.node.frontmatter.subsection} - {data.node.frontmatter.title} </Link></div>)
          })
            }
        </span>
          </div>
        )
      })
    }
  </Layout>
)

/*

this creates queries for generating index page content

contentsPage excludes section 0 (which only contains the text for this page), then grabs sections, subsections and titles which will be used to generate a contents page. These results are sorted by section and subsection numbers

readmeHTML generates HTML from the readme file which is stored in section 0 which is used to generate content inside of this page

*/
export const pageQuery = graphql`
  query indexQuery {
    contentsPage:allMarkdownRemark(
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
