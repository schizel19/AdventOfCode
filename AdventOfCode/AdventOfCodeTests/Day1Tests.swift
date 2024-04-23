//
//  Day1Tests.swift
//  AdventOfCodeTests
//
//  Created by iosdev on 4/22/24.
//

import Foundation
import XCTest
@testable import AdventOfCode

class Day1Tests: XCTestCase {
    
    func test_solve_takes_int_by_line() throws {
        let sut = Day1(in: Bundle(for: Self.self), file: "SampleD1", ofType: "text")!
        let result = try sut.solve()
        XCTAssertEqual(result, 142)
    }
    
    func test_solve2_takes_keywords_by_line() throws {
        let sut = Day1(in: Bundle(for: Self.self), file: "SampleD1_B", ofType: "text")!
        let result = try sut.solve2()
        XCTAssertEqual(result, 281)
    }
    
    func test_solve_problem() {
        let sut = Day1Solution()
        XCTAssertEqual(56049, sut.solve())
    }

    func test_solve_problem2() {
        let sut = Day1Solution()
        XCTAssertEqual(54530, sut.solve2())
    }
}
