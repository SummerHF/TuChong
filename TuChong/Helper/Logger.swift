//  Logger.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/19.
//
//
//  Copyright (c) 2019 SummerHF(https://github.com/summerhf)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

class Logger {
    let destination: URL
    lazy fileprivate var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"

        return formatter
    }()
    lazy fileprivate var fileHandle: FileHandle? = {
        let path = self.destination.path
        FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)

        do {
            let fileHandle = try FileHandle(forWritingTo: self.destination)
            print("Successfully logging to: \(path)")
            return fileHandle
        } catch let error as NSError {
            print("Serious error in logging: could not open path to log file. \(error).")
        }

        return nil
    }()

    init(destination: URL) {
        self.destination = destination
    }

    deinit {
        fileHandle?.closeFile()
    }

    func log(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
        let logMessage = stringRepresentation(message, function: function, file: file, line: line)

        printToConsole(logMessage)
        printToDestination(logMessage)
    }
}

 extension Logger {
    func stringRepresentation(_ message: String, function: String, file: String, line: Int) -> String {
        let dateString = dateFormatter.string(from: Date())

        let file = URL(fileURLWithPath: file).lastPathComponent 
        return "\(dateString) [\(file):\(line)] \(function): \(message)\n"
    }

    func printToConsole(_ logMessage: String) {
        print(logMessage)
    }

    func printToDestination(_ logMessage: String) {
        if let data = logMessage.data(using: String.Encoding.utf8) {
            fileHandle?.write(data)
        } else {
            print("Serious error in logging: could not encode logged string into data.")
        }
    }
}

func logPath() -> URL {
    let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    return docs.appendingPathComponent("logger.txt")
}

// MARK: - 全局输出 保存调试信息

/// 可输出到控制台或者保存到本地
let logger = Logger(destination: logPath())
