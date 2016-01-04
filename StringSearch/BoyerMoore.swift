//
//  BoyerMoore.swift
//  StringSearch
//
//  Created by Lucas Louca on 03/01/16.
//  Copyright © 2016 Lucas Louca. All rights reserved.
//

import Foundation

extension String {
    
    private func preprocess(pattern:String) -> [Character: Int] {
        var lookup = [Character: Int]()
        
        for (index, char) in pattern.characters.enumerate() {
            lookup[char] = index
        }
        
        return lookup
    }
    
    /**
     Returns the position in the String at which the pattern was found. Returns -1 if the pattern was not found.
     
     - parameter pattern: the pattern to search for, may not be nil
     
     - returns: the position in the String or -1 if the pattern was not found.
     */
    func indexOf(pattern:String) -> Int {
        let lookup = preprocess(pattern)
        
        let m = self.characters.count
        let n = pattern.characters.count
        var skip: Int
        
        for var i = 0; i <= m-n; i+=skip {
            skip = 0
            for var j = n-1; j >= 0; j-- {
                if (pattern[j] != self[i+j]) {
                    skip = max(1, j - (lookup[self[i+j]] ?? n))
                    break
                }
            }
            
            if (skip == 0) {
                return i
            }
        }
        
        return -1
    }
    
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
}