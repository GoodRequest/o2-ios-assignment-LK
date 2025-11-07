#!/usr/bin/env swift

import Foundation

// MARK: - Configuration
let localizableStringsPath = "Assignment/Resources/en.lproj/Localizable.strings"
let outputPath = "Assignment/Resources/L10n.swift"

// MARK: - Main Script
func main() {
    let fileManager = FileManager.default
    let currentDirectory = fileManager.currentDirectoryPath
    
    let localizableStringsFullPath = (currentDirectory as NSString).appendingPathComponent(localizableStringsPath)
    let outputFullPath = (currentDirectory as NSString).appendingPathComponent(outputPath)
    
    guard fileManager.fileExists(atPath: localizableStringsFullPath) else {
        print("Error: Localizable.strings not found at \(localizableStringsFullPath)")
        exit(1)
    }
    
    // Read and parse Localizable.strings
    guard let content = try? String(contentsOfFile: localizableStringsFullPath, encoding: .utf8) else {
        print("Error: Could not read Localizable.strings")
        exit(1)
    }
    
    let keys = parseLocalizableStrings(content: content)
    
    guard !keys.isEmpty else {
        print("Error: No localization keys found in Localizable.strings")
        exit(1)
    }
    
    // Generate Swift code
    let swiftCode = generateL10nEnum(keys: keys)
    
    // Write to file
    do {
        try swiftCode.write(toFile: outputFullPath, atomically: true, encoding: .utf8)
        print("✅ Successfully generated \(outputPath)")
        print("   Found \(keys.count) localization keys")
    } catch {
        print("Error: Failed to write L10n.swift: \(error)")
        exit(1)
    }
}

func parseLocalizableStrings(content: String) -> [String] {
    var keys: [String] = []
    
    // Regular expression to match: "key" = ...
    // This matches the key part only, which is simpler and more reliable
    let pattern = #""([^"]+)"\s*="#
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let nsContent = content as NSString
    let matches = regex.matches(in: content, options: [], range: NSRange(location: 0, length: nsContent.length))
    
    for match in matches {
        if match.numberOfRanges > 1 {
            let keyRange = match.range(at: 1)
            let key = nsContent.substring(with: keyRange)
            // Skip empty keys and comments
            if !key.isEmpty && !key.hasPrefix("/*") {
                keys.append(key)
            }
        }
    }
    
    return keys.sorted()
}

func generateL10nEnum(keys: [String]) -> String {
    let staticVars = keys.map { key in
        return "    nonisolated static let \(key) = tr(\"Localizable\", \"\(key)\")"
    }.joined(separator: "\n")
    
    return """
//
//  L10n.swift
//  assignment
//
//  Generated from Localizable.strings
//  DO NOT EDIT - This file is auto-generated
//

import Foundation

enum L10n {
\(staticVars)

}

extension L10n {
    
    nonisolated private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = Bundle.main.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
    
}
"""
}

main()

