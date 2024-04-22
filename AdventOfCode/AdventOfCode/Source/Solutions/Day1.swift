//
//  Day1.swift
//  AdventOfCode
//
//  Created by iosdev on 4/22/24.
//

import Foundation

class TrieNode {
    var value: Int = 0
    var children = [Character: TrieNode]()
    
    func insert(word: String, value: Int) {
        var current = self
        for char in word {
            let node = current.children[char] ?? .init()
            current.children[char] = node
            current = node
        }
        current.value = value
    }
}


class Day1: InputReader {
    
    let root = TrieNode()
    var current: TrieNode
    
    override init?(in bundle: Bundle, file: String, ofType type: String) {
        
        self.current = root
        super.init(in: bundle, file: file, ofType: type)
        do {
            try load()
        } catch {
            return nil
        }
        
        root.insert(word: "0", value: 0)
        root.insert(word: "1", value: 1)
        root.insert(word: "2", value: 2)
        root.insert(word: "3", value: 3)
        root.insert(word: "4", value: 4)
        root.insert(word: "5", value: 5)
        root.insert(word: "6", value: 6)
        root.insert(word: "7", value: 7)
        root.insert(word: "8", value: 8)
        root.insert(word: "9", value: 9)
        root.insert(word: "one", value: 1)
        root.insert(word: "two", value: 2)
        root.insert(word: "three", value: 3)
        root.insert(word: "four", value: 4)
        root.insert(word: "five", value: 5)
        root.insert(word: "six", value: 6)
        root.insert(word: "seven", value: 7)
        root.insert(word: "eight", value: 8)
        root.insert(word: "nine", value: 9)
    }
    
    func solve() throws -> Int {
        var sum = 0
        var current = 0
        var eof = false
        while !eof {
            do {
                guard let char = try next() else { continue }
                switch char {
                case "0"..."9":
                    if current > 10 {
                        current = current/10
                    }
                    current = (current * 10) + Int("\(char)")!
                case "\n":
                    if current < 10 {
                        current = current + (current * 10)
                    }
                    sum += current
                    current = 0
                default:
                    continue
                }
            } catch {
                eof = true
            }
        }
        try close()
        return sum
    }

    
    func solve2() throws -> Int {
        var sum = 0
        var accumulated = 0
        var eof = false
        
        while !eof {
            do {
                guard let char = try next() else { continue }
                switch char {
                case "\n":
                    if accumulated < 10 {
                        accumulated = accumulated + (accumulated * 10)
                    }
                    sum += accumulated
                    accumulated = 0
                default:
                    var node: TrieNode?
                    if current.children[char] == nil {
                        node = root.children[char]
                    } else {
                        node = current.children[char]
                    }
                    guard let node else {
                        current = root
                        continue
                    }
                    
                    if node.value != 0 {
                        if accumulated > 10 {
                            accumulated = accumulated/10
                        }
                        accumulated = (accumulated * 10) + node.value
                        current = root
                    } else {
                        current = node
                    }
                }
            } catch {
                eof = true
            }
        }
        
        return sum
    }
}

class Day1Solution {
    let day1: Day1
    
    init() {
        self.day1 = Day1(in: Bundle(for: Self.self), file: "InputD1", ofType: "text")!
    }
    
    func solve() -> Int {
        do {
            return try day1.solve()
        } catch {
            return 0
        }
    }
    
    func solve2() -> Int {
        do {
            return try day1.solve2()
        } catch {
            return 0
        }
    }
}
