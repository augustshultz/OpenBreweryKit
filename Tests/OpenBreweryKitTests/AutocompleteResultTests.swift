//
//  Created by August Shultz on 10/31/19.
//

import XCTest
@testable import OpenBreweryKit

class AutocompleteResultTests: XCTestCase {

  func testDecodeAutocompleteJson() {

    guard let data = autoCompleteResults.data(using: .utf8) else {
      XCTFail("Data could not be created")
      return
    }
    do {
      let results = try JSONDecoder().decode([AutocompleteResult].self, from: data)
      XCTAssertEqual(results.count, 3)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

}

let autoCompleteResults = """
[
  {
    "id": "4263",
    "name": "Lead Dog Brewing"
  },
  {
    "id": "5359",
    "name": "Boss Dog Brewing"
  },
  {
    "id": "5925",
    "name": "Running Dogs Brewery"
  }
]
"""
