//
//  Created by August Shultz on 1/15/20.
//

import Foundation

extension Double {
  init?(_ string: String?) {
    guard let string = string else {
      return nil
    }
    self.init(string)
  }
}
