//
//  Created by August Shultz on 10/31/19.
//

import Foundation

struct AutocompleteResult: Decodable {
  let autocompleteId: String
  let name: String

  enum CodingKeys: String, CodingKey {
    case autocompleteId = "id", name
  }
}
