//
//  Created by August Shultz on 10/25/19.
//

import Foundation

struct BreweryController {

  let networkController: BreweryNetworkController

  func getBreweries() -> [Brewery] {

    do {
      return try networkController.fetchBreweries()
    } catch _ {
      return []
    }
  }
}

protocol BreweryNetworkController {
  func fetchBreweries() throws -> [Brewery]
}
