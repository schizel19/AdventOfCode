//
//  InputReaderTests.swift
//  InputReaderTests
//
//  Created by iosdev on 4/22/24.
//

import XCTest
@testable import AdventOfCode

final class InputReaderTests: XCTestCase {
    
    func test_can_access_existing_bundle_resource() throws {
        let sut = makeSUT()
        do {
            let _ = try sut.fetchInput(forDay: 1)
        } catch {
            XCTFail("Expected result, got \(error) instead")
        }
    }
    
    func test_throws_notFound_on_nonexisting_bundle_resource() {
        let sut = makeSUT()
        do {
            let result = try sut.fetchInput(forDay: -1)
            XCTFail("Expected not found error, got \(result) instead")
        } catch {
            assertError(error, isError: .notFound)
        }
    }
    
    func assertError(_ error: Error, isError ref: InputReader.InputReaderError, file: String = #filePath, line: UInt = #line) {
        if let error = error as? InputReader.InputReaderError, error == ref {
            return
        } else {
            XCTFail("Expected \(ref), got \(error) instead")
        }
    }
    
    func makeSUT() -> InputReader {
        return .init()
    }
}
