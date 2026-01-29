module Data.ResearchInterest exposing (ResearchInterest, researchInterests)


type alias ResearchInterest =
    { category : String
    , items : List String
    }


researchInterests : List ResearchInterest
researchInterests =
    [ { category = "Logic"
      , items = [ "Linear logic and proof nets" ]
      }
    , { category = "Functional programming"
      , items = []
      }
    , { category = "Software verification"
      , items = []
      }
    , { category = "Graph transformation"
      , items = []
      }
    ]
