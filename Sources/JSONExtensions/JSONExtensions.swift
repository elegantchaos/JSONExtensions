// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 20/04/2022.
//  All code (c) 2022 - present day, Sam Deane.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

//extension JSONSerialization {
//    func load(into engine: Engine) throws {
//        if let data = file.asData {
//            do {
//                let decoded = try JSONSerialization.jsonObject(with: data, options: [])
//                if let properties = decoded as? [String:Any] {
//                    let definition = Definition(id: id, properties: properties)
//                    engine.register(definition)
//                    engineChannel.log("Loaded \(id) definition.")
//                }
//            } catch {
//                let nserror = error as NSError
//                if (nserror.domain == NSCocoaErrorDomain) && (nserror.code == 3840) {
//                    if let json = String(data: data, encoding: .utf8),
//                       let description = nserror.userInfo["NSDebugDescription"] as? String,
//                       let number = description.split(separator: " ").last?.split(separator: ".").first,
//                       let index = Int(number) {
//
//                        let lines = json.split(separator: "\n")
//                        var count = 0
//                        for n in 0 ..< lines.count {
//                            count = count + lines[n].count
//                            if count > index {
//                                print("Error")
//                                if n > 0 {
//                                    print("\(n - 1): \(lines[n - 1])")
//                                }
//                                print("\(n): \(lines[n])")
//                                if n + 1 < lines.count {
//                                    print("\(n + 1): \(lines[n + 1])")
//                                }
//                                throw error
//                            }
//                        }
//                    }
//                }
//
//                throw error
//            }
//        }
//    }
//
//}

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
        guard
            let number = description.split(separator: " ").last?.split(separator: ".").first,
            let index = Int(number)
        else {
            return description
        }

        var buffer = ""
        let lines = json.split(separator: "\n")
        var count = 0
        for n in 0 ..< lines.count {
            count = count + lines[n].count
            if count > index {
                if n > 0 {
                    buffer += "\(n - 1): \(lines[n - 1])"
                }
                buffer += "\(n): \(lines[n])"
                if n + 1 < lines.count {
                    buffer += "\(n + 1): \(lines[n + 1])"
                }
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
