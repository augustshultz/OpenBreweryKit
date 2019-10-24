//
//  Created by August Shultz on 10/17/19.
//

import XCTest
@testable import OpenBreweryKit

class BreweryTests: XCTestCase {

  let jsonDecoder = JSONDecoder()

  func testJsonDecodingId() throws {
    guard let data = sampleBreweryJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: data)
    XCTAssertEqual(decodedJson.breweryId, 5494)
  }

  func testJsonDecodingName() throws {
    guard let data = sampleBreweryJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: data)
    XCTAssertEqual(decodedJson.name, "MadTree Brewing")
  }

  func testJsonDecodingBreweryType() throws {
    guard let data = sampleBreweryJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: data)
    XCTAssertEqual(decodedJson.type, BreweryType.regional)
  }

  func testJsonDecodingBreweryStreet() throws {
    guard let data = sampleBreweryJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: data)
    XCTAssertEqual(decodedJson.street, "3301 Madison Rd")
  }

  func testJsonDecodingBreweryCity() throws {
    guard let data = sampleBreweryJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: data)
    XCTAssertEqual(decodedJson.city, "Cincinnati")
  }

  func testJsonDecodingBreweryState() throws {
    guard let data = sampleBreweryJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: data)
    XCTAssertEqual(decodedJson.state, "Ohio")
  }

  func testJsonDecodingBreweryPostalCode() throws {
    guard let data = sampleBreweryJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: data)
    XCTAssertEqual(decodedJson.postalCode, "45209-1132")
  }

  func testJsonDecodingBreweryCountry() throws {
    let jsonDecoder = JSONDecoder()
    guard let data = sampleBreweryJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: data)
    XCTAssertEqual(decodedJson.country, "United States")
  }

  func testJsonDecodingBreweryLatitude() throws {
    guard let data = sampleBreweryJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: data)
    XCTAssertEqual(decodedJson.latitude, 39.1563725)
  }

  func testJsonDecodingBreweryLongitude() throws {
    guard let data = sampleBreweryJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: data)
    XCTAssertEqual(decodedJson.longitude, -84.4239715)
  }

  func testJsonDecodingBreweryPhone() throws {
    guard let data = sampleBreweryJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: data)
    XCTAssertEqual(decodedJson.phone, "5138368733")
  }

  func testJsonDecodingBreweryUrl() throws {
    guard let data = sampleBreweryJson.data(using: .utf8), let url = URL(string: "http://www.madtreebrewing.com") else {
      throw BreweryError.decodingError
    }
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: data)
    XCTAssertEqual(decodedJson.url, url)
  }

  func testJsonDecodingBreweryTags() throws {
    guard let data = sampleBreweryJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: data)
    XCTAssertEqual(decodedJson.features, ["patio", "tours"])
  }

  func testDecodeBreweryFeature() throws {
    guard let data = "[\"food-service\"]".data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decoded = try jsonDecoder.decode([String].self, from: data)
    XCTAssertEqual(decoded, ["food-service"])
  }

  func testDecodingBreweries() throws {
    guard let data = sampleBreweriesJson.data(using: .utf8) else {
      throw BreweryError.decodingError
    }
    let decoded = try jsonDecoder.decode([Brewery].self, from: data)
    XCTAssert(decoded.count == 2)
  }

  let sampleBreweryJson = """
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
  }
  """

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
}
