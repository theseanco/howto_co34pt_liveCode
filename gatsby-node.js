/**
 * Implement Gatsby's Node APIs in this file.
 *
 * See: https://www.gatsbyjs.org/docs/node-apis/
 */

// You can delete this file if you're not using it

const path = require("path");

exports.createPages = ({ boundActionCreators, graphql }) => {
  const {createPage} = boundActionCreators;

  const postTemplate = path.resolve(`src/templates/post.js`);

  return graphql(`{
    allMarkdownRemark (
      sort: {fields: [frontmatter___section, frontmatter___subsection], order: ASC}
    ){
      edges {
        node {
          html
          id
          frontmatter {
            path
            title
            section
            subsection
          }
        }
      }
    }
  }`)
  .then(res => {
    if(res.errors) {
      return Promise.reject(res.errors)
    }

    const posts = res.data.allMarkdownRemark.edges;

    //NOTE: context is used to pass previous and next pages to post
    //This cannot be accessed from within the post.
    posts.forEach( ({node}, index) => {
      createPage({
        path: node.frontmatter.path,
        component: postTemplate,
        context: {
          prev: index === 0 ? null : posts[index - 1].node,
          next: index === posts.length - 1 ? null : posts[index + 1].node
        }
      })
    })
  })
}
