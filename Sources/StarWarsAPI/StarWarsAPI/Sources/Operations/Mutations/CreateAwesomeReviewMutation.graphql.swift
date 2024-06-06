// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateAwesomeReviewMutation: GraphQLMutation {
  public static let operationName: String = "CreateAwesomeReview"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    operationIdentifier: "6758478141ddd4fde56693cbf43efaf5982c5805bb4b5d4ab6e25f656989d7de",
    definition: .init(
      #"mutation CreateAwesomeReview { createReview( episode: JEDI review: { stars: 10, commentary: "This is awesome!" } ) { __typename stars commentary } }"#
    ))

  public init() {}

  public struct Data: StarWarsAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createReview", CreateReview?.self, arguments: [
        "episode": "JEDI",
        "review": [
          "stars": 10,
          "commentary": "This is awesome!"
        ]
      ]),
    ] }

    public var createReview: CreateReview? { __data["createReview"] }

    public init(
      createReview: CreateReview? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": StarWarsAPI.Objects.Mutation.typename,
          "createReview": createReview._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(CreateAwesomeReviewMutation.Data.self)
        ]
      ))
    }

    /// CreateReview
    ///
    /// Parent Type: `Review`
    public struct CreateReview: StarWarsAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.Review }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("stars", Int.self),
        .field("commentary", String?.self),
      ] }

      /// The number of stars this review gave, 1-5
      public var stars: Int { __data["stars"] }
      /// Comment about the movie
      public var commentary: String? { __data["commentary"] }

      public init(
        stars: Int,
        commentary: String? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": StarWarsAPI.Objects.Review.typename,
            "stars": stars,
            "commentary": commentary,
          ],
          fulfilledFragments: [
            ObjectIdentifier(CreateAwesomeReviewMutation.Data.CreateReview.self)
          ]
        ))
      }
    }
  }
}
