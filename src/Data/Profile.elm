module Data.Profile exposing (Profile, profile)


type alias Profile =
    { name : String
    , subtitle : String
    , bio : String
    , twitterUrl : String
    , githubUrl : String
    , uedalabUrl : String
    , currentPosition : String
    }


profile : Profile
profile =
    { name = "Kento Takyu"
    , subtitle = "My Portfolio"
    , bio = "I am a researcher in the field of computer science and computer security. My research interests include linear logic, proof nets, functional programming, and graph transformation."
    , twitterUrl = "https://twitter.com/kyawaway"
    , githubUrl = "https://github.com/kyawaway"
    , uedalabUrl = "https://www.ueda.info.waseda.ac.jp"
    , currentPosition = "Researcher at Japanese tech company"
    }
