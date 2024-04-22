//
//  InputReaderTests.swift
//  AdventOfCodeTests
//
//  Created by iosdev on 4/22/24.
//

import XCTest

class InputReader {
    
    private let filePath: String
    
    init?(in bundle: Bundle, file: String, ofType type: String) {
        guard let path = bundle.path(forResource: file, ofType: type) else {
            return nil
        }
        self.filePath = path
    }
    
    func load() {
        
    }
}

class InputReaderTests: XCTestCase {

    func test_init_nils_with_invalidFile() {
        let sut = makeSUT("InvalidFile")
        XCTAssertNil(sut, "Expected nil, got \(String(describing: sut)) instead")
    }
    
    func test_init_with_existingFile() {
        let sut = makeSUT()
        XCTAssertNotNil(sut, "Expected InputReader nil, got \(String(describing: sut)) instead")
    }
    
    func makeSUT(_ file: String = "InputTest", _ type: String = "text") -> InputReader! {
        return InputReader(in: Bundle(for: Self.self), file: file, ofType: type)
    }
}
