//
//  Created by August on 2/5/20.
//

import Foundation

extension String {
  func isZipCode() -> Bool {
    return self.range(of: #"^\d{5}(-\d{4})?$"#, options: .regularExpression) != nil
  }
}
