// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 20/04/2022.
//  All code (c) 2022 - present day, Sam Deane.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import XCTest
import XCTestExtensions

@testable import JSONExtensions

final class JSONExtensionsTests: XCTestCase {
    func testEmpty() {
        _ = JSONSerialization.jsonObject(with: "") { description, error in
            XCTAssertTrue(error.isJSONError)
            XCTAssertEqual(description, "Unable to parse empty data.")
        }
    }
    
    func testNumberFragment() {
        let json = "123"
        _ = JSONSerialization.jsonObject(with: json) { description, error in
            XCTAssertTrue(error.isJSONError)
            XCTAssertEqual(description, "JSON text did not start with array or object and option to allow fragments not set.\n\n123\n")
        }
    }

    func testStringFragment() {
        let json = """
                "test"
                """
        
        _ = JSONSerialization.jsonObject(with: json) { description, error in
            XCTAssertTrue(error.isJSONError)
            XCTAssertEqual(description, "JSON text did not start with array or object and option to allow fragments not set.\n\n\"test\"\n")
        }
    }

    func testMissingQuote() {
        let json = """
                {
                    property: "value"
                }
                """
        
        _ = JSONSerialization.jsonObject(with: json) { description, error in
            XCTAssertTrue(error.isJSONError)
            let expected = """
                No string key for value in object around line 2, column 4.

                     1: {
                     2:     property: "value"
                            ^
                     3: }
                """
            
            XCTAssertEqual(description, expected)
        }
    }

}
