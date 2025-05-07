//
//  Logger.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 06/05/25.
//

import Foundation

import Foundation

enum LogLevel: String {
    case info = "ℹ️"
    case warning = "⚠️"
    case error = "❌"
}

struct Logger {
    static func log(_ message: String, level: LogLevel = .info, file: String = #file, line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent
        print("\(level.rawValue) [\(fileName):\(line)] - \(message)")
    }
}
