//
//  Created by August Shultz on 10/31/19.
//

import XCTest
@testable import OpenBreweryKit

class AutocompleteResultTests: XCTestCase {

    func testDecodeAutocompleteJson() throws {
        let data = try Data(fromJsonFile: "autocomplete.json")
        let results = try JSONDecoder().decode([AutocompleteResult].self, from: data)
        XCTAssertEqual(results.count, 3)
    }

}
