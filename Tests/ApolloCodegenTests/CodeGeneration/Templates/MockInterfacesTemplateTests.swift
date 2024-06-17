import XCTest
import Nimble
import OrderedCollections
import GraphQLCompiler
import IR
@testable import ApolloCodegenLib
import ApolloCodegenInternalTestHelpers

class MockInterfacesTemplateTests: XCTestCase {
  var ir: IRBuilder!
  var subject: MockInterfacesTemplate!

  override func tearDown() {
    subject = nil

    super.tearDown()
  }

  // MARK: - Helpers

  private func buildSubject(
    interfaces: OrderedSet<GraphQLInterfaceType>,
    testMocks: ApolloCodegenConfiguration.TestMockFileOutput = .swiftPackage()
  ) {
    let config = ApolloCodegenConfiguration.mock(output: .mock(testMocks: testMocks))

    subject = MockInterfacesTemplate(
      graphqlInterfaces: interfaces,
      config: ApolloCodegen.ConfigurationContext(config: config)
    )
  }

  private func renderSubject() -> String {
    subject.renderBodyTemplate(nonFatalErrorRecorder: .init()).description
  }

  // MARK: Boilerplate tests

  func test__target__isTestMockFile() {
    buildSubject(interfaces: [])

    expect(self.subject.target).to(equal(.testMockFile))
  }

  // MARK: Typealias Tests

  func test__render__givenSingleInterfaceType_generatesExtensionWithTypealias() {
    // given
    let Pet = GraphQLInterfaceType.mock("Pet")
    buildSubject(interfaces: [Pet])

    let expected = """
    public extension MockObject {
      typealias Pet = Interface
    }

    """

    // when
    let actual = renderSubject()

    // then
    expect(actual).to(equalLineByLine(expected))
  }

  func test__render__givenMultipleInterfaceTypes_generatesExtensionWithTypealiasesCorrectlyCased() {
    // given
    let InterfaceA = GraphQLInterfaceType.mock("InterfaceA")
    let InterfaceB = GraphQLInterfaceType.mock("interfaceB")
    let InterfaceC = GraphQLInterfaceType.mock("Interfacec")
    buildSubject(interfaces: [InterfaceA, InterfaceB, InterfaceC])

    let expected = """
    public extension MockObject {
      typealias InterfaceA = Interface
      typealias InterfaceB = Interface
      typealias Interfacec = Interface
    }

    """

    // when
    let actual = renderSubject()

    // then
    expect(actual).to(equalLineByLine(expected))
  }

  // MARK: Access Level Tests

  func test__render__givenInterfaceType_whenTestMocksIsSwiftPackage_shouldRenderWithPublicAccess() throws {
    // given
    buildSubject(interfaces: [GraphQLInterfaceType.mock("Pet")], testMocks: .swiftPackage())

    let expected = """
    public extension MockObject {
    """

    // when
    let actual = renderSubject()

    // then
    expect(actual).to(equalLineByLine(expected, ignoringExtraLines: true))
  }

  func test__render__givenInterfaceType_whenTestMocksAbsolute_withPublicAccessModifier_shouldRenderWithPublicAccess() throws {
    // given
    buildSubject(
      interfaces: [GraphQLInterfaceType.mock("Pet")],
      testMocks: .absolute(path: "", accessModifier: .public)
    )

    let expected = """
    public extension MockObject {
    """

    // when
    let actual = renderSubject()

    // then
    expect(actual).to(equalLineByLine(expected, ignoringExtraLines: true))
  }

  func test__render__givenInterfaceType_whenTestMocksAbsolute_withInternalAccessModifier_shouldRenderWithInternalAccess() throws {
    // given
    buildSubject(
      interfaces: [GraphQLInterfaceType.mock("Pet")],
      testMocks: .absolute(path: "", accessModifier: .internal)
    )

    let expected = """
    extension MockObject {
    """

    // when
    let actual = renderSubject()

    // then
    expect(actual).to(equalLineByLine(expected, ignoringExtraLines: true))
  }
  
  // MARK: - Reserved Keyword Tests
  
  func test__render__usingReservedKeyword__generatesTypeWithSuffix() {
    let keywords = ["Type", "type"]
    
    keywords.forEach { keyword in
      // given
      let interface = GraphQLInterfaceType.mock(keyword)
      buildSubject(interfaces: [interface])

      let expected = """
      public extension MockObject {
        typealias \(keyword.firstUppercased)_Interface = Interface
      }
      """

      // when
      let actual = renderSubject()

      // then
      expect(actual).to(equalLineByLine(expected, ignoringExtraLines: true))
    }
  }
  
  // Schema Customization Tests
  
  func test__render__givenInterface_withCustomName_shouldRenderWithCustomName() throws {
    // given
    let myInterface = GraphQLInterfaceType.mock("MyInterface")
    myInterface.name.customName = "MyCustomInterface"
    buildSubject(interfaces: [myInterface])

    let expected = """
    public extension MockObject {
      typealias MyCustomInterface = Interface
    }

    """

    // when
    let actual = renderSubject()

    // then
    expect(actual).to(equalLineByLine(expected))
  }
  
}
