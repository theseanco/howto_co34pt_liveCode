import React from 'react';
import { Link, graphql } from 'gatsby';


const Intro = ( {data} ) => (
  <div>

    THIS IS DYNAMIC
    {data}

    THIS IS PRESET
    <h3>About</h3>

    <p>howto_co34pt_liveCode is an attempt to extensively document my live-coding music practice. I live code as <a href="https://co34pt.bandcamp.com">co34pt</a>, mostly making dance music (including for <a href="https://algorave.com/">Algoraves</a>), but I have also employed live coding as part of some <a href="https://www.youtube.com/watch?v=dY6oSwoRRho">other projects</a>. This repo contains a number of articles and essays listed in this contents page which cover various aspects of my live coding practice from the ground up, and also contains a number of files to support your use of SuperCollider in the way that I use it. More info about this in 'What This Repo Is'.</p>

    <p>This resource is hosted both <a href="https://github.com/theseanco/howto_co34pt_liveCode">on GitHub</a> and <a href="https://theseanco.github.io/howto_co34pt_liveCode/">on GitHub Pages</a> (you will likely already be on one of these). I'd recommend browsing articles on GitHub pages, and if you want to use any of the examples, see any SuperCollider code and use my setup I'd recommend downloading the repo, this will be covered in 'How To Use This Repo'. There is also e-book versions of the 'first edition' of this repo in the <code>Documents</code> folder in <code>epub</code>, <code>pdf</code> and <code>pages</code> format. Huge thanks to @shamansir for putting these together.</p>

    <p>This repository is currently mostly finished, and may have additional content added to it in the future, depending on the amount of time I have available.</p>

    <p>I'm always keen to know the ways in which this has been helpful to anyone, or any comments you have at all: Drop me a line on <a href="https://twitter.com/theseanco">Twitter</a>, <a href="https://github.com/theseanco/">GitHub</a> or via <a href="mailto:theseancotterill%20atsign%20live%20period%20com">Email</a></p>

    <p>If any content does not work, please open an issue/pull request. These examples have been tested on *ubuntu 16.10 only thus far.</p>
  </div>
  )


export const postQuery = graphql`
  query {
    markdownRemark(frontmatter: { section: {eq: 0} }) {
      html
      frontmatter {
        path
        title
      }
    }
  }
`
/*
  export const query = graphql`
    fragment grabFirstHTML on MarkdownRemark {
      edges {
        node {
          html
        }
      }
    }
*/

export default Intro
