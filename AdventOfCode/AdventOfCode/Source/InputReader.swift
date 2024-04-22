//
//  InputReader.swift
//  AdventOfCode
//
//  Created by iosdev on 4/22/24.
//

import Foundation

public class InputReader {
    
    public enum InputReaderError: Error {
        case notFound
    }
    
    var bundle: Bundle {
        Bundle(for: Self.self)
    }
    
    func fetchInput(forDay day: Int) throws -> String {
        guard let path = bundle.path(forResource: "Day\(day)", ofType: "text") else {
            throw InputReaderError.notFound
        }
        return path
    }
}
