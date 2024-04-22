//
//  InputReaderTests.swift
//  AdventOfCodeTests
//
//  Created by iosdev on 4/22/24.
//

import XCTest
@testable import AdventOfCode

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
        let sut = makeSUT("DeleteTest")
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
            XCTFail("Expected error, got \(String(describing: character)) instead")
        } catch {
            XCTAssertEqual(error as? InputReader.InputReaderError, .notInitialized)
        }
    }
    
    func test_next_throws_end_of_file_on_empty_file() throws {
        let sut = makeSUT("EmptyTest")!
        try sut.load()
        do {
            let character = try sut.next()
            XCTFail("Expected error, got \(character) instead")
        } catch {
            XCTAssertEqual(error as? InputReader.InputReaderError, .endOfFile)
        }
    }
    
    func test_next_nil_on_invalid_character() throws {
        let sut = makeSUT("InvalidCharacterTest")!
        try sut.load()
        let character = try sut.next()
        XCTAssertNil(character, "Expected nil, got \(String(describing: character)) instead")
    }
    
    func test_next_character_on_valid_character() throws {
        let sut = makeSUT()!
        try sut.load()
        let character = try sut.next()
        XCTAssertEqual(character, "t", "Expected t, got \(String(describing: character)) instead")
        
        let character2 = try sut.next()
        XCTAssertEqual(character2, "h", "Expected h, got \(String(describing: character2)) instead")
    }
    
    func test_next_character_on_escape_characters() throws {
        let sut = makeSUT("EscapeCharacters")!
        try sut.load()
        let character = try sut.next()
        XCTAssertEqual(character, "\n", "Expected \n, got \(String(describing: character)) instead")
        
        let character2 = try sut.next()
        XCTAssertEqual(character2, "\t", "Expected \t, got \(String(describing: character2)) instead")
    }
    
    func test_next_throws_eof_on_closed_file() throws {
        let sut = makeSUT()!
        try sut.load()
        try sut.close()
        do {
            let character = try sut.next()
            XCTFail("Expected error, got \(String(describing: character)) instead")
        } catch {
            XCTAssertEqual(error as? InputReader.InputReaderError, .endOfFile)
        }
    }
    
    func makeSUT(_ file: String = "InputTest", _ type: String = "text") -> InputReader? {
        return InputReader(in: Bundle(for: Self.self), file: file, ofType: type)
    }
}
