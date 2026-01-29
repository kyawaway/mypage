module Data.Publication exposing (Category(..), Publication, posters, refereedPapers, unrefereedPapers)


type Category
    = Journal
    | Proceedings


type alias Publication =
    { authors : String
    , title : String
    , venue : String
    , year : String
    , url : Maybe String
    , links : List ( String, String )
    , featured : Bool
    , category : Category
    }


refereedPapers : List Publication
refereedPapers =
    [ { authors = "Kento Takyu and Kazunori Ueda"
      , title = "Enhancing a Hierarchical Graph Rewriting Language based on MELL Cut Elimination"
      , venue = "The 27th International Symposium on Practical Aspects of Declarative Languages (PADL 2025), LNCS 15537, 2025, Springer, pp.196-214"
      , year = "2025"
      , url = Just "https://popl25.sigplan.org/details/PADL-2025-papers/3/Enhancing-a-Hierarchical-Graph-Rewriting-Language-based-on-MELL-Cut-Elimination"
      , links =
            [ ( "paper (extended version)", "https://arxiv.org/pdf/2411.14802" )
            , ( "slide", "https://www.ueda.info.waseda.ac.jp/~takyu/about/padl2025-slide.pdf" )
            ]
      , featured = True
      , category = Proceedings
      }
    ]


unrefereedPapers : List Publication
unrefereedPapers =
    [ { authors = "Kento Takyu and Kazunori Ueda"
      , title = "MELLのカット除去規則に基づく階層グラフ書換え言語の拡張"
      , venue = "The 41th JSSST Annual Conference (JSSST 2024), 2024. (in Japanese)"
      , year = "2024"
      , url = Nothing
      , links = []
      , featured = False
      , category = Proceedings
      }
    , { authors = "Kento Takyu and Yuto Otsuki"
      , title = "MermaidCP: Mermaid記法からデッドロックフリーな通信プログラムを生成するDSL"
      , venue = "2026年 暗号と情報セキュリティシンポジウム (SCIS 2026), 2026. (in Japanese)"
      , year = "2026"
      , url = Nothing
      , links = []
      , featured = False
      , category = Proceedings
      }
    ]


posters : List Publication
posters =
    [ { authors = "Kento Takyu and Eiji Iwase"
      , title = "熱溶融積層型3Dプリンタを用いた単層ヒンジ構造の自己折り畳み"
      , venue = "In Proc, 第13回マイクロ・ナノ工学シンポジウム, 2022. (in Japanese)"
      , year = "2022"
      , url = Nothing
      , links = []
      , featured = False
      , category = Proceedings
      }
    , { authors = "Kento Takyu and Kazunori Ueda"
      , title = "階層グラフ書き換え言語による線形論理のカット除去のエンコーディング"
      , venue = "The 40th JSSST Annual Conference (JSSST 2023), 2023. (in Japanese)"
      , year = "2023"
      , url = Nothing
      , links = []
      , featured = False
      , category = Proceedings
      }
    , { authors = "Kento Takyu and Kazunori Ueda"
      , title = "Encoding MELL Cut Elimination into a Hierarchical Graph Rewriting Language"
      , venue = "The 21st Asian Symposium on Programming Languages and Systems (APLAS 2023), 2023."
      , year = "2023"
      , url = Just "https://conf.researchr.org/details/aplas-2023/src-and-posters/4/-Non-SRC-Encoding-MELL-Cut-Elimination-into-a-Hierarchical-Graph-Rewriting-Language"
      , links =
            [ ( "abstract", "https://www.ueda.info.waseda.ac.jp/~takyu/about/aplas2023-abst.pdf" )
            , ( "poster", "https://www.ueda.info.waseda.ac.jp/~takyu/about/aplas2023-poster.pdf" )
            ]
      , featured = True
      , category = Proceedings
      }
    , { authors = "Kento Takyu and Kazunori Ueda"
      , title = "MELL proof netsにおける単純型付きラムダ計算の代入表現の再考"
      , venue = "第27回プログラミングおよびプログラミング言語ワークショップ (PPL 2025), 2025. (in Japanese)"
      , year = "2025"
      , url = Nothing
      , links = []
      , featured = False
      , category = Proceedings
      }
    , { authors = "Kento Takyu, Yuto Otsuki, Toshinori Usui, Yuhei Kawakoya, Eitaro Shioji and Makoto Iwamura"
      , title = "安全な分散システム開発のためのプログラミング言語的アプローチに向けて"
      , venue = "コンピュータセキュリティシンポジウム2025 (CSS 2025), 2025. (in Japanese)"
      , year = "2025"
      , url = Nothing
      , links = []
      , featured = False
      , category = Proceedings
      }
    ]
