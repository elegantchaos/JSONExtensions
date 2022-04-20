// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 20/04/2022.
//  All code (c) 2022 - present day, Sam Deane.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import XCTest
import XCTestExtensions

@testable import JSONExtensions

final class JSONExtensionsTests: XCTestCase {
    func testEmpty() {
        let json = ""
        let data = json.data(using: .utf8)!
        do {
            try JSONSerialization.jsonObject(with: data)
        } catch {
            XCTAssertTrue(error.isJSONError)
            let description = error.jsonErrorDescription(for: data)
            XCTAssertEqual(description, "Unable to parse empty data.")
        }
    }
    
    func testNumberFragment() {
        let json = "123"
        let data = json.data(using: .utf8)!
        do {
            try JSONSerialization.jsonObject(with: data)
        } catch {
            XCTAssertTrue(error.isJSONError)
            let description = error.jsonErrorDescription(for: data)
            XCTAssertEqual(description, "JSON text did not start with array or object and option to allow fragments not set.\n\n123\n")
        }
    }

    func testStringFragment() {
        let json = """
                "test"
                """
        
        let data = json.data(using: .utf8)!
        do {
            try JSONSerialization.jsonObject(with: data)
        } catch {
            XCTAssertTrue(error.isJSONError)
            let description = error.jsonErrorDescription(for: data)
            XCTAssertEqual(description, "JSON text did not start with array or object and option to allow fragments not set.\n\n\"test\"\n")
        }
    }

}
