//
//  Created by August Shultz on 1/6/20.
//

import XCTest
@testable import OpenBreweryKit

class FilterBreweriesByTypeTests: XCTestCase {

  func testFilterByType() throws {

    let url = URL(string: "https://api.openbrewerydb.org/breweries?by_type=micro")!
    let data = try Data(fromJsonFile: "../Filter/filter_breweries_by_type.json")
    URLProtocolMock.urls = [url: data]
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [URLProtocolMock.self]
    let session = URLSession(configuration: configuration)
    let networkController = BreweryNetworkController(session: session)
    let expectation = XCTestExpectation()
    networkController.filterBreweries(byType: BreweryType.micro) { (result) in
      if case .success(let breweries) = result {
        XCTAssertEqual(breweries.count, 13)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 1.0)

  }
}
