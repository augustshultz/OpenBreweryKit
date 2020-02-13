//
//  Created by August Shultz on 1/6/20.
//

import XCTest
@testable import OpenBreweryKit

class FilterBreweriesByTagsTests: XCTestCase {

  func testFilterByType() throws {

    let url = try XCTUnwrap(URL(string: "https://api.openbrewerydb.org/breweries?by_tags=patio,dog-friendly"))
    let data = try Data(fromJsonFile: "../Filter/filter_breweries_by_tags.json")
    URLProtocolMock.urls = [url: data]
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [URLProtocolMock.self]
    let session = URLSession(configuration: configuration)
    let networkController = BreweryNetworkController(session: session)
    let expectation = XCTestExpectation()
    networkController.filterBreweries(byTags: ["patio", "dog-friendly"]) { (result) in
      if case .success(let breweries) = result {
        XCTAssertEqual(breweries.count, 1)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 1.0)

  }
}
