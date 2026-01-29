module Data.Tool exposing (Tool, tools)


type alias Tool =
    { name : String
    , description : String
    , url : String
    , githubUrl : String
    }


tools : List Tool
tools =
    [ { name = "kyasual -a smart kasual beamer theme-"
      , description = "Cool beamer theme."
      , url = "https://kyawaway.github.io/myblog/post-kyasual/"
      , githubUrl = "https://github.com/kyawaway/kyasual"
      }
    , { name = "linear type playground"
      , description = "Type checking playground for linear lambda calculus. The front-end is written in Elm and the back-end (linear lambda calculus) is written in OCaml."
      , url = "https://kyawaway.github.io/linear-type-playground/"
      , githubUrl = "https://github.com/kyawaway/linear-type-playground"
      }
    ]
