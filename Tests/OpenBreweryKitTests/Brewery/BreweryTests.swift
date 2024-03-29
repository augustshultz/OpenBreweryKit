//
//  Created by August Shultz on 10/17/19.
//

// swiftlint:disable force_try

import XCTest
@testable import OpenBreweryKit

class BreweryTests: XCTestCase {

  let jsonDecoder = JSONDecoder()
  var sampleBrewery: Data!
  var sampleBreweries: Data!

  override func setUp() {
    sampleBrewery = try! Data(fromJsonFile: "../Brewery/sample_brewery.json")
    sampleBreweries = try! Data(fromJsonFile: "../Brewery/sample_breweries.json")
  }

  func testJsonDecodingId() throws {
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: sampleBrewery)
    XCTAssertEqual(decodedJson.breweryId, 5494)
  }

  func testJsonDecodingName() throws {
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: sampleBrewery)
    XCTAssertEqual(decodedJson.name, "MadTree Brewing")
  }

  func testJsonDecodingBreweryType() throws {
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: sampleBrewery)
    XCTAssertEqual(decodedJson.type, BreweryType.regional)
  }

  func testJsonDecodingBreweryStreet() throws {
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: sampleBrewery)
    XCTAssertEqual(decodedJson.street, "3301 Madison Rd")
  }

  func testJsonDecodingBreweryCity() throws {
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: sampleBrewery)
    XCTAssertEqual(decodedJson.city, "Cincinnati")
  }

  func testJsonDecodingBreweryState() throws {
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: sampleBrewery)
    XCTAssertEqual(decodedJson.state, "Ohio")
  }

  func testJsonDecodingBreweryPostalCode() throws {
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: sampleBrewery)
    XCTAssertEqual(decodedJson.postalCode, "45209-1132")
  }

  func testJsonDecodingBreweryCountry() throws {
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: sampleBrewery)
    XCTAssertEqual(decodedJson.country, "United States")
  }

  func testJsonDecodingBreweryLatitude() throws {
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: sampleBrewery)
    XCTAssertEqual(decodedJson.latitude, 39.1563725)
  }

  func testJsonDecodingBreweryLongitude() throws {
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: sampleBrewery)
    XCTAssertEqual(decodedJson.longitude, -84.4239715)
  }

  func testJsonDecodeBreweryWithNullLatitudeAndLongitude() throws {
    let sampleData = try Data(fromJsonFile: "../Brewery/sample_brewery_with_null_lat_long.json")
    let brewery = try jsonDecoder.decode(Brewery.self, from: sampleData)
    XCTAssertNil(brewery.latitude)
    XCTAssertNil(brewery.longitude)
  }

  func testJsonDecodingBreweryPhone() throws {
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: sampleBrewery)
    XCTAssertEqual(decodedJson.phone, "5138368733")
  }

  func testJsonDecodingBreweryUrl() throws {
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: sampleBrewery)
    XCTAssertEqual(decodedJson.url, try XCTUnwrap(URL(string: "http://www.madtreebrewing.com")))
  }

  func testJsonDecodingBreweryTags() throws {
    let decodedJson = try jsonDecoder.decode(Brewery.self, from: sampleBrewery)
    XCTAssertEqual(decodedJson.features, ["patio", "tours"])
  }

  func testDecodingBreweries() throws {
    let decoded = try jsonDecoder.decode([Brewery].self, from: sampleBreweries)
    XCTAssert(decoded.count == 2)
  }
}
