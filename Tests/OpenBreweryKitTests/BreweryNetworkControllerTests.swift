//
//  Created by August Shultz on 10/29/19.
//

import XCTest
@testable import OpenBreweryKit

class BreweryNetworkControllerTests: XCTestCase {

  func testSearchForBrewery() throws {
    let url = URL(string: "https://api.openbrewerydb.org/breweries/search?query=dog")!
    let directory = URL(fileURLWithPath: #file).deletingLastPathComponent()
    let file = directory.appendingPathComponent("sample_breweries.json")
    let data = try Data(contentsOf: file)
    URLProtocolMock.urls = [url: data]
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [URLProtocolMock.self]
    let session = URLSession(configuration: configuration)
    let networkController = BreweryNetworkController(session: session)
    var returned = false
    let semaphore = DispatchSemaphore(value: 0)
    networkController.searchForBreweries(searchText: "dog" ) { (result) in
      switch result {
      case .success(let breweries):
        XCTAssertTrue(breweries.count > 0)
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
      returned = true
      semaphore.signal()
    }
    _ = semaphore.wait()
    XCTAssertTrue(returned, "The completion was never called")

  }

  func testGetBreweries() throws {
    let url = URL(string: "https://api.openbrewerydb.org/breweries")!
    let directory = URL(fileURLWithPath: #file).deletingLastPathComponent()
    let file = directory.appendingPathComponent("sample_breweries.json")
    let data = try Data(contentsOf: file)
    URLProtocolMock.urls = [url: data]
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [URLProtocolMock.self]
    let session = URLSession(configuration: configuration)
    let networkController = BreweryNetworkController(session: session)
    var returned = false
    let semaphore = DispatchSemaphore(value: 0)
    networkController.getBreweries { (result) in
      switch result {
      case .success(let breweries):
        XCTAssertTrue(breweries.count > 0)
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
      returned = true
      semaphore.signal()
    }
    _ = semaphore.wait()
    XCTAssertTrue(returned, "The completion was never called")
  }

}
