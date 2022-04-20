// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 20/04/2022.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

public enum JSONError: Error {
    case badEncoding(String)
    case jsonCorrupt(String, Error)
}

extension JSONError: CustomStringConvertible {
    public var description: String {
        switch self {
            case .badEncoding: return "Bad string encoding."
            case .jsonCorrupt(let description, _): return description
        }
    }
}
