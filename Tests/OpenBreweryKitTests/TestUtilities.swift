//
//  Created by August Shultz on 12/19/19.
//

import Foundation

extension Data {
    init(fromJsonFile jsonFile: String) throws {
        let directory = URL(fileURLWithPath: #file).deletingLastPathComponent()
        let file = directory.appendingPathComponent(jsonFile)
        try self.init(contentsOf: file)
    }
}
