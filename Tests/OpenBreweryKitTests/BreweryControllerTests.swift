//
//  Created by August Shultz on 10/25/19.
//

import XCTest
@testable import OpenBreweryKit

struct TestBreweryNetworkController: BreweryNetworkController {
  func fetchBreweries() throws -> [Brewery] {
    let jsonDecoder = JSONDecoder()
    guard let data = sampleBreweriesJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    return try jsonDecoder.decode([Brewery].self, from: data)
  }
}

class BreweryControllerTests: XCTestCase {

  let breweryController = BreweryController(networkController: TestBreweryNetworkController())

  func testGetBreweriesReturnsList() throws {
    let actual = breweryController.getBreweries()
    XCTAssertTrue(actual.count == 2)
  }

}

let sampleBreweriesJson = """
[
  {
    "id": 5494,
    "name": "MadTree Brewing",
    "brewery_type": "regional",
    "street": "3301 Madison Rd",
    "city": "Cincinnati",
    "state": "Ohio",
    "postal_code": "45209-1132",
    "country": "United States",
    "longitude": "-84.4239715",
    "latitude": "39.1563725",
    "phone": "5138368733",
    "website_url": "http://www.madtreebrewing.com",
    "updated_at": "2018-08-24T15:44:22.281Z",
    "tag_list": [
      "patio", "tours"
    ]
  },
  {
    "id": 5495,
    "name": "MadBush Brewing",
    "brewery_type": "regional",
    "street": "3301 Madison Rd",
    "city": "Cincinnati",
    "state": "Ohio",
    "postal_code": "45209-1132",
    "country": "United States",
    "longitude": "-84.4239715",
    "latitude": "39.1563725",
    "phone": "5138368733",
    "website_url": "http://www.madtreebrewing.com",
    "updated_at": "2018-08-24T15:44:22.281Z",
    "tag_list": [
      "patio", "tours"
    ]
  }
]
"""
