// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct CharacterNameAndDroidPrimaryFunction: StarWarsAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment CharacterNameAndDroidPrimaryFunction on Character { __typename ...CharacterName ...DroidPrimaryFunction }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Interfaces.Character }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .inlineFragment(AsDroid.self),
    .fragment(CharacterName.self),
  ] }

  /// The name of the character
  public var name: String { __data["name"] }

  public var asDroid: AsDroid? { _asInlineFragment() }

  public struct Fragments: FragmentContainer {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public var characterName: CharacterName { _toFragment() }
  }

  public init(
    __typename: String,
    name: String
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": __typename,
        "name": name,
      ],
      fulfilledFragments: [
        ObjectIdentifier(CharacterNameAndDroidPrimaryFunction.self),
        ObjectIdentifier(CharacterName.self)
      ]
    ))
  }

  /// AsDroid
  ///
  /// Parent Type: `Droid`
  public struct AsDroid: StarWarsAPI.InlineFragment {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public typealias RootEntityType = CharacterNameAndDroidPrimaryFunction
    public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.Droid }
    public static var __selections: [ApolloAPI.Selection] { [
      .fragment(DroidPrimaryFunction.self),
    ] }

    /// This droid's primary function
    public var primaryFunction: String? { __data["primaryFunction"] }
    /// The name of the character
    public var name: String { __data["name"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var droidPrimaryFunction: DroidPrimaryFunction { _toFragment() }
      public var characterName: CharacterName { _toFragment() }
    }

    public init(
      primaryFunction: String? = nil,
      name: String
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": StarWarsAPI.Objects.Droid.typename,
          "primaryFunction": primaryFunction,
          "name": name,
        ],
        fulfilledFragments: [
          ObjectIdentifier(CharacterNameAndDroidPrimaryFunction.self),
          ObjectIdentifier(CharacterNameAndDroidPrimaryFunction.AsDroid.self),
          ObjectIdentifier(DroidPrimaryFunction.self),
          ObjectIdentifier(CharacterName.self)
        ]
      ))
    }
  }
}
