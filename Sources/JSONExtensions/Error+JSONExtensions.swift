// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 20/04/2022.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

extension Error {
    var isJSONError: Bool {
        let nserror = self as NSError
        return (nserror.domain == NSCocoaErrorDomain) && (nserror.code == 3840)
    }
    
    func jsonErrorDescription(for data: Data) -> String {
        guard let json = String(data: data, encoding: .utf8) else {
            return "Data cannot be decoded."
        }
        
        guard let description = (self as NSError).userInfo["NSDebugDescription"] as? String else {
            return String(describing: self)
        }

        guard !description.starts(with: "JSON text did not start with array or object and option to allow fragments not set.") else {
            return fragmentErrorDescription(json: json)
        }

        let words = description.split(separator: " ")
        let lastWord = words.count - 1
        guard
            lastWord > 1,
            let line = Int(words[lastWord - 2].trimmingCharacters(in: .punctuationCharacters)),
            let column = Int(words[lastWord].trimmingCharacters(in: .punctuationCharacters))
        else {
            return description
        }

        let showColumnOn = line - 1
        var buffer = description
        buffer += "\n"
        let lines = json.split(separator: "\n")
        let start = max(line - 2, 0)
        let finish = min(line + 2, lines.count)

        for n in start ..< finish {
            buffer += String(format: "\n%6d: ", n + 1)
            buffer += lines[n]
            if n == showColumnOn {
                buffer += "\n        "
                for _ in 0..<column {
                    buffer += " "
                }
                buffer += "^"
            }
        }
        
        return buffer
    }
    
    func fragmentErrorDescription(json: String) -> String {
        var buffer = "JSON text did not start with array or object and option to allow fragments not set."
        
        let stripped = json.trimmingCharacters(in: .whitespacesAndNewlines)
        buffer += "\n\n"
        if let start = stripped.split(separator: "\n").first {
            buffer += "\n\n\(start)\n"
        }
        
        return buffer
    }
}