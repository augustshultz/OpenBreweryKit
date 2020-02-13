//
//  Created by August Shultz on 1/4/20.
//

import XCTest
@testable import OpenBreweryKit

class GetBreweryTests: XCTestCase {

  func testGetBreweryForValidBrewery() throws {
    let url = try XCTUnwrap(URL(string: "https://api.openbrewerydb.org/breweries/5494"))
    let data = try Data(fromJsonFile: "../Brewery/sample_brewery.json")
    URLProtocolMock.urls = [url: data]
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [URLProtocolMock.self]
    let session = URLSession(configuration: configuration)
    let networkController = BreweryNetworkController(session: session)
    let expectation = XCTestExpectation()
    networkController.getBrewery(forId: 5494) { (result) in
      if case .success(let brewery) = result {
        XCTAssertNotNil(brewery)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 1.0)
  }

}
