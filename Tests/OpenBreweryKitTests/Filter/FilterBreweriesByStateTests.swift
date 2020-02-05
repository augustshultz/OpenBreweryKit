//
//  Created by August Shultz on 1/8/20.
//

import XCTest
@testable import OpenBreweryKit

class FilterBreweriesByStateTests: XCTestCase {

  func testFilterBreweriesByState() throws {

    let url = URL(string: "https://api.openbrewerydb.org/breweries?by_state=Iowa")!
    let data = try Data(fromJsonFile: "../Filter/filter_breweries_by_state.json")
    URLProtocolMock.urls = [url: data]
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [URLProtocolMock.self]
    let session = URLSession(configuration: configuration)
    let networkController = BreweryNetworkController(session: session)
    let expectation = XCTestExpectation()
    networkController.filterBreweries(byState: "Iowa") { (result) in
      if case .success(let breweries) = result {
        XCTAssertEqual(breweries.count, 20)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 1.0)
  }
}
