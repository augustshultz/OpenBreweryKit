//
//  Created by August on 2/5/20.
//

import XCTest
@testable import OpenBreweryKit

class StringExtensionTests: XCTestCase {

  func testIsZipCodeFailsForNonNumber() {
    XCTAssertFalse("a".isZipCode())
  }

  func testIsZipCodeFailsForValidZipPrependedByLetters() {
    XCTAssertFalse("a12345".isZipCode())
  }

  func testIsZipCodeFailsForValidZipAppendedByLetters() {
    XCTAssertFalse("12345a".isZipCode())
  }
  
  func testIsZipCodeSucceedsForFiveDigitNumber() {
    XCTAssertTrue("12345".isZipCode())
  }
  
  func testIsZipCodeSucceedsForNineDigitNumberSeparatedByADash() {
    XCTAssertTrue("12345-1234".isZipCode())
  }
}
