//
//  Created by August Shultz on 1/15/20.
//

import XCTest
@testable import OpenBreweryKit

class DoubleExtensionTests: XCTestCase {

  func testNonNilStringInitializesNormally() {
    let optional: String? = "3"
    let nonOptional: String = "3"
    XCTAssertEqual(Double(nonOptional), Double(optional))
  }

  func testNilStringInitializesToNil() {
    let optional: String? = nil
    XCTAssertNil(Double(optional))
  }
}
