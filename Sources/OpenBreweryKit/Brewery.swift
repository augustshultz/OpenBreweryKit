//
//  Created by August Shultz on 10/17/19.
//

import Foundation
import CoreLocation

public struct Brewery: Decodable {
  let breweryId: Int
  let name: String
  let type: BreweryType
  let street: String
  let city: String
  let state: String
  let country: String
  let postalCode: String
  let latitude: CLLocationDegrees?
  let longitude: CLLocationDegrees?
  let phone: String
  let url: URL?
  let features: [String]

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    breweryId = try container.decode(Int.self, forKey: CodingKeys.breweryId)
    name = try container.decode(String.self, forKey: CodingKeys.name)
    type = try container.decode(BreweryType.self, forKey: CodingKeys.type)
    street = try container.decode(String.self, forKey: CodingKeys.street)
    city = try container.decode(String.self, forKey: CodingKeys.city)
    state = try container.decode(String.self, forKey: CodingKeys.state)
    country = try container.decode(String.self, forKey: CodingKeys.country)
    postalCode = try container.decode(String.self, forKey: CodingKeys.postalCode)

    longitude = Double(try? container.decode(String.self, forKey: CodingKeys.longitude))
    latitude = Double(try? container.decode(String.self, forKey: CodingKeys.latitude))

    phone = try container.decode(String.self, forKey: CodingKeys.phone)
    let urlString = try container.decode(String.self, forKey: CodingKeys.url)
    url = URL(string: urlString)
    features = try container.decode([String].self, forKey: CodingKeys.features)
  }

  enum CodingKeys: String, CodingKey {
    case breweryId = "id", name, type = "brewery_type", street, city, state, postalCode = "postal_code", country,
    latitude, longitude, phone, url = "website_url", features = "tag_list"
  }
}

public enum BreweryType: String, Decodable {
  case micro, regional, brewpub, large, planning, bar, contract, proprieter
}
