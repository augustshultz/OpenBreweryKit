import XCTest
@testable import OpenBreweryKit

final class OpenBreweryKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(OpenBreweryKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
