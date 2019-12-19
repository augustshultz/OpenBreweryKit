//
//  Created by August Shultz on 10/31/19.
//

import XCTest
@testable import OpenBreweryKit

class AutocompleteResultTests: XCTestCase {

    func testDecodeAutocompleteJson() throws {

        let directory = URL(fileURLWithPath: #file).deletingLastPathComponent()
        let file = directory.appendingPathComponent("autocomplete.json")
        let data = try Data(contentsOf: file)
        let results = try JSONDecoder().decode([AutocompleteResult].self, from: data)
        XCTAssertEqual(results.count, 3)
    }

}
