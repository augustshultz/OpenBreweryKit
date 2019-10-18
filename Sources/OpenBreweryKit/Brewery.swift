//
//  Created by August Shultz on 10/17/19.
//

import Foundation
import CoreLocation

struct Brewery: Decodable {
  let breweryId: Int
  let name: String
  let type: BreweryType
  let street: String
  let city: String
  let state: String
  let country: String
  let postalCode: String
  let latitude: CLLocationDegrees
  let longitude: CLLocationDegrees
  let phone: String
  let url: URL?
  let tags: [String]

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    breweryId = try container.decode(Int.self, forKey: CodingKeys.breweryId)
    name = try container.decode(String.self, forKey: CodingKeys.name)
    type = try container.decode(BreweryType.self, forKey: CodingKeys.type)
    street = try container.decode(String.self, forKey: CodingKeys.street)
    city = try container.decode(String.self, forKey: CodingKeys.city)
    state = try container.decode(String.self, forKey: CodingKeys.state)
    country = try container.decode(String.self, forKey: CodingKeys.country)
    postalCode = try container.decode(String.self, forKey: CodingKeys.postalCode)
    let latitudeString = try container.decode(String.self, forKey: CodingKeys.latitude)
    let longitudeString = try container.decode(String.self, forKey: CodingKeys.longitude)
    guard let longitude = Double(longitudeString), let latitude = Double(latitudeString) else {
      throw BreweryError.decodingError
    }
    self.longitude = longitude
    self.latitude = latitude
    phone = try container.decode(String.self, forKey: CodingKeys.phone)
    let urlString = try container.decode(String.self, forKey: CodingKeys.url)
    url = URL(string: urlString)
    tags = try container.decode([String].self, forKey: CodingKeys.tags)
  }

  enum CodingKeys: String, CodingKey {
    case breweryId = "id", name, type = "brewery_type", street, city, state, postalCode = "postal_code", country,
    latitude, longitude, phone, url = "website_url", tags = "tag_list"
  }
}

enum BreweryType: String, Decodable {
  case micro, regional, brewpub, large, planning, bar, contract, proprieter
}

enum BreweryError: Error {
  case decodingError
}
