//
//  InputReader.swift
//  AdventOfCode
//
//  Created by iosdev on 4/22/24.
//

import Foundation

class InputReader {
    
    enum InputReaderError: Error {
        case notFound
        case notInitialized
        case endOfFile
    }
    
    private let filePath: String
    private var fileHandle: FileHandle?
    
    init?(in bundle: Bundle, file: String, ofType type: String) {
        guard let path = bundle.path(forResource: file, ofType: type) else {
            return nil
        }
        self.filePath = path
    }
    
    func load() throws {
        guard let fileHandle = FileHandle(forReadingAtPath: filePath) else {
            throw InputReaderError.notFound
        }
        
        self.fileHandle = fileHandle
    }
    
    func next() throws -> Character? {
        guard let fileHandle else {
            throw InputReaderError.notInitialized
        }
        
        var data: Data!
        do {
            if let d = try fileHandle.read(upToCount: 1) {
                data = d
            } else {
                throw InputReaderError.endOfFile
            }
        } catch {
            throw InputReaderError.endOfFile
        }
        
        return String(data: data, encoding: .utf8)?.first
    }
    
    func close() throws {
        try fileHandle?.close()
    }
}
