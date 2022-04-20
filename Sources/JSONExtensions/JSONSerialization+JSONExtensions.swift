// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 20/04/2022.
//  All code (c) 2022 - present day, Sam Deane.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

extension JSONSerialization {
    static func jsonObject(from url: URL, options: JSONSerialization.ReadingOptions = []) throws -> Any {
        let data = try Data(contentsOf: url)
        return try jsonObjectWrappingError(with: data, options: options)
    }

    static func jsonObject(with string: String, options: JSONSerialization.ReadingOptions = []) throws -> Any {
        guard let data = string.data(using: .utf8) else {
            throw JSONError.badEncoding(string)
        }

        return try jsonObjectWrappingError(with: data, options: options)
    }

    static func jsonObjectWrappingError(with data: Data, options: JSONSerialization.ReadingOptions) throws -> Any {
        do {
            return try jsonObject(with: data, options: options)
        } catch {
            if error.isJSONError {
                throw JSONError.jsonCorrupt(error.jsonErrorDescription(for: data), error)
            } else {
                throw error
            }
        }
    }

    static func jsonObject(from url: URL, options: JSONSerialization.ReadingOptions = [], errorHandler: (String, Error) -> ()) -> Any? {
        do {
            let data = try Data(contentsOf: url)
            return jsonObject(with: data, options: options, errorHandler: errorHandler)
        } catch {
            errorHandler(error.localizedDescription, error)
            return nil
        }
    }

    static func jsonObject(with string: String, options: JSONSerialization.ReadingOptions = [], errorHandler: (String, Error) -> ()) -> Any? {
        guard let data = string.data(using: .utf8) else {
            let error = JSONError.badEncoding(string)
            errorHandler("Can't encode as UTF", error)
            return nil
        }

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

