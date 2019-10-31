//
//  Created by August Shultz on 10/29/19.
//

import XCTest
@testable import OpenBreweryKit

class BreweryNetworkControllerTests: XCTestCase {

  func testSearchForBrewery() {
    guard let url = URL(string: "https://api.openbrewerydb.org/breweries/search?query=dog") else {
      XCTFail("A url is required to pass this test")
      return
    }
    guard let data = sampleBreweriesJson.data(using: .utf8) else {
      XCTFail("Data is required to pass this test")
      return
    }
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

  func testGetBreweries() {
    guard let url = URL(string: "https://api.openbrewerydb.org/breweries") else {
      XCTFail("A url is required to pass this test")
      return
    }
    guard let data = sampleBreweriesJson.data(using: .utf8) else {
      XCTFail("Data is required to pass this test")
      return
    }
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
