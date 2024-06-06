// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct DroidNameAndPrimaryFunction: StarWarsAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment DroidNameAndPrimaryFunction on Droid { __typename ...CharacterName ...DroidPrimaryFunction }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: any ApolloAPI.ParentType { StarWarsAPI.Objects.Droid }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .fragment(CharacterName.self),
    .fragment(DroidPrimaryFunction.self),
  ] }

  /// The name of the character
  public var name: String { __data["name"] }
  /// This droid's primary function
  public var primaryFunction: String? { __data["primaryFunction"] }

  public struct Fragments: FragmentContainer {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public var characterName: CharacterName { _toFragment() }
    public var droidPrimaryFunction: DroidPrimaryFunction { _toFragment() }
  }

  public init(
    name: String,
    primaryFunction: String? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": StarWarsAPI.Objects.Droid.typename,
        "name": name,
        "primaryFunction": primaryFunction,
      ],
      fulfilledFragments: [
        ObjectIdentifier(DroidNameAndPrimaryFunction.self),
        ObjectIdentifier(CharacterName.self),
        ObjectIdentifier(DroidPrimaryFunction.self)
      ]
    ))
  }
}
