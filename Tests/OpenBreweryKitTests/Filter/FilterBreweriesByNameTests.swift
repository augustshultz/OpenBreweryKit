//
//  Created by August Shultz on 1/7/20.
//

import XCTest
@testable import OpenBreweryKit

class FilterBreweriesByNameTests: XCTestCase {

  func testFilterBreweriesByName() throws {

    let url = URL(string: "https://api.openbrewerydb.org/breweries?by_name=Big%20Grove")!
    let data = try Data(fromJsonFile: "../Filter/filter_breweries_by_name.json")
    URLProtocolMock.urls = [url: data]
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [URLProtocolMock.self]
    let session = URLSession(configuration: configuration)
    let networkController = BreweryNetworkController(session: session)
    let expectation = XCTestExpectation()
    networkController.filterBreweries(byName: "Big Grove") { (result) in
      if case .success(let breweries) = result {
        XCTAssertEqual(breweries.count, 2)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 1.0)
  }
}
