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
    
    func next() throws -> Character {
        guard let fileHandle else {
            throw InputReaderError.notInitialized
        }
        
        guard let data = try fileHandle.read(upToCount: 1) else {
            throw InputReaderError.endOfFile
        }
        
        return "a"
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
        let sut = makeSUT("DeleteTest", "text")
        let path = Bundle(for: Self.self).path(forResource: "DeleteTest", ofType: "text")!
        try! FileManager.default.removeItem(atPath: path)
        do {
            try sut?.load()
            XCTFail("Expected error, got success instead")
        } catch {
            XCTAssertEqual(error as? InputReader.InputReaderError, .notFound)
        }
    }
    
    func test_next_throws_not_initialized_on_not_loaded_file() {
        let sut = makeSUT()
        do {
            let character = try sut?.next()
            XCTFail("Expected error, got \(character) instead")
        } catch {
            XCTAssertEqual(error as? InputReader.InputReaderError, .notInitialized)
        }
    }
    
    func test_next_throws_end_of_file_on_empty_file() throws {
        let sut = makeSUT("EmptyTest", "text")!
        try sut.load()
        do {
            let character = try sut.next()
            XCTFail("Expected error, got \(character) instead")
        } catch {
            XCTAssertEqual(error as? InputReader.InputReaderError, .endOfFile)
        }
    }
    
    func makeSUT(_ file: String = "InputTest", _ type: String = "text") -> InputReader? {
        return InputReader(in: Bundle(for: Self.self), file: file, ofType: type)
    }
}
