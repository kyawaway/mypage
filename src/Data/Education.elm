module Data.Education exposing (Education, educations)


type alias Education =
    { period : String
    , degree : String
    , description : String
    , supervisorName : Maybe String
    , supervisorUrl : Maybe String
    }


educations : List Education
educations =
    [ { period = "April 2025 – current"
      , degree = ""
      , description = "Researcher at Japanese tech company."
      , supervisorName = Nothing
      , supervisorUrl = Nothing
      }
    , { period = "April 2023 – March 2025"
      , degree = "Master of Engineering"
      , description = "Department of Computer Science and Communications Engineering, Graduate School of Fundamental Science and Engineering, Waseda University"
      , supervisorName = Just "Kazunori Ueda"
      , supervisorUrl = Just "https://www.ueda.info.waseda.ac.jp/~ueda/index.html"
      }
    , { period = "April 2019 – March 2023"
      , degree = "Bachelor of Engineering"
      , description = "Department of Applied Mechanics and Aerospace Engineering, School of Fundamental Science and Engineering, Waseda University"
      , supervisorName = Just "Eiji Iwase"
      , supervisorUrl = Just "https://www.iwaselab.amech.waseda.ac.jp/people/professor/"
      }
    ]
