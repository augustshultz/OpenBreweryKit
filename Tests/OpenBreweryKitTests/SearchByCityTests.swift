//
//  Created by August Shultz on 1/6/20.
//

import XCTest
@testable import OpenBreweryKit

class SearchByCityTests: XCTestCase {

  func testSearchByCity() throws {

    let url = URL(string: "https://api.openbrewerydb.org/breweries?by_city=Des%20Moines")!
    let data = try Data(fromJsonFile: "search_by_city_results.json")
    URLProtocolMock.urls = [url: data]
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [URLProtocolMock.self]
    let session = URLSession(configuration: configuration)
    let networkController = BreweryNetworkController(session: session)
    let expectation = XCTestExpectation()
    networkController.getBreweries(forCity: "Des Moines") { (result) in
        if case .success(let breweries) = result {
            XCTAssertEqual(breweries.count, 8)
            expectation.fulfill()
        }
    }
    wait(for: [expectation], timeout: 1.0)

  }
}