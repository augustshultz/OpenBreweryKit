//
//  Created by August Shultz on 10/29/19.
//

import XCTest
@testable import OpenBreweryKit

class BreweryNetworkControllerTests: XCTestCase {

    func testSearchForBrewery() throws {
        let url = URL(string: "https://api.openbrewerydb.org/breweries/search?query=dog")!
        let data = try Data(fromJsonFile: "sample_breweries.json")
        URLProtocolMock.urls = [url: data]
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: configuration)
        let networkController = BreweryNetworkController(session: session)
        let expectation = XCTestExpectation()
        networkController.searchForBreweries(searchText: "dog" ) { (result) in
            if case .success(let breweries) = result {
                XCTAssertTrue(breweries.count > 0)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)

    }

    func testGetBreweries() throws {
        let url = URL(string: "https://api.openbrewerydb.org/breweries")!
        let data = try Data(fromJsonFile: "sample_breweries.json")
        URLProtocolMock.urls = [url: data]
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: configuration)
        let networkController = BreweryNetworkController(session: session)
        let expectation = XCTestExpectation()
        networkController.getBreweries { (result) in
            if case .success(let breweries) = result {
                XCTAssertTrue(breweries.count > 0)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
}
