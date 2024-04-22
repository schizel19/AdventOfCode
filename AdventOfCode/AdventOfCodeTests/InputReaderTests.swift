//
//  InputReaderTests.swift
//  AdventOfCodeTests
//
//  Created by iosdev on 4/22/24.
//

import XCTest

class InputReader {
    
    enum InputReaderError: Error {
        case notFound
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
        try fileHandle.seek(toOffset: 0)
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
    
    func test_load_throws_error_on_missing_file() {
        let sut = makeSUT()
        let path = Bundle(for: Self.self).path(forResource: "InputTest", ofType: "text")!
        try! FileManager.default.removeItem(atPath: path)
        do {
            try sut?.load()
            XCTFail("Expected error, got success instead")
        } catch {
            XCTAssertEqual(error as? InputReader.InputReaderError, InputReader.InputReaderError.notFound)
        }
    }
    
    func makeSUT(_ file: String = "InputTest", _ type: String = "text") -> InputReader! {
        return InputReader(in: Bundle(for: Self.self), file: file, ofType: type)
    }
}
