//
//  DebugLogger.swift
//  ReelJournal
//
//  Created by Dom S on 4/3/26.
//

import Foundation

enum SeverityLevel {
    case success
    case low
    case medium
    case high
    
    var label: String {
        switch self {
        case .low:
            return " 🟡 LOW 🟡"
        case .medium:
            return "🟠 MEDIUM 🟠"
        case .high:
            return " 🔴 HIGH 🔴"
        default: return "🟢 SUCCESS 🟢"
        }
    }
}

struct DebugLogger {
    static var baseString: String {
        let debugTitle = "⚡️ Debug Logger ⚡️\n"
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd hh:mm:ss a"
        let timeStamp = "\(formatter.string(from: Date()))\n"
        return debugTitle + timeStamp
    }
    
    static func printError(
        error: Error,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line,
        _ severity: SeverityLevel = .high
    ) {
        let debugSeverityString = "Severity: \(severity.label)\n"
        let debugErrorString = "Error: \(error)\n"
        let contextString = "At: \(file).\(function)(line \(line))"
        
        let finalDebug = baseString + debugSeverityString + debugErrorString + contextString
        
        #if DEBUG || Testing
        print(finalDebug)
        #endif
    }
    
    static func printLog(
        _ message: String = "",
        file: String = #fileID,
        function: String = #function,
        line: Int = #line,
        _ severity: SeverityLevel = .success
    ) {
        let debugSeverityString = "Severity: \(severity.label)\n"
        let messageString = "\(message)\n"
        let contextString = "At: \(file).\(function)\nline \(line)"
        
        let finalDebug = baseString + debugSeverityString + messageString + contextString
        
        #if DEBUG || Testing
        print(finalDebug)
        #endif
    }
}
