// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 20/04/2022.
//  All code (c) 2022 - present day, Sam Deane.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

extension JSONSerialization {
    static func jsonObject(with string: String, options: JSONSerialization.ReadingOptions = []) throws -> Any? {
        guard let data = string.data(using: .utf8) else { return nil }
        return try jsonObject(with: data, options: options)
    }

    static func jsonObject(with string: String, options: JSONSerialization.ReadingOptions = [], errorHandler: (String, Error) -> ()) -> Any? {
        guard let data = string.data(using: .utf8) else { return nil }
        return jsonObject(with: data, options: options, errorHandler: errorHandler)
    }
    
    static func jsonObject(with data: Data, options: JSONSerialization.ReadingOptions = [], errorHandler: (String, Error) -> ()) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: [])
        } catch {
            let description = error.jsonErrorDescription(for: data)
            errorHandler(description, error)
            return nil
        }
    }
}

