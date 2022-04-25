//
//  Lesson.swift
//  Kana Torii
//
//  Created by clément floret on 07/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import Foundation

class Lesson {
    
    var hiraganaOrKatakana: HiraganaOrKatakana
    var kanaArray: [String]
    var title: String
    var currentPart: Int
    var currentKana: String
    var numberOfTest: Int
    var numberOfPractice: Int
    var numberOfFirstTest: Int

    var state: State
    var mode: Mode
    
    var partsArray: [String] {
        if kanaArray.count == 5 && mode == .reading {
            return ["Learn","Learn","Test","Test","Learn","Learn","Test","Test","Test","Test","Learn","Test","Test","Test","Test","Test","Test","Test","Test","Test","Test"]
        } else if kanaArray.count == 3 && mode == .reading {
            return ["Learn","Learn","Test","Test","Learn","Test","Test","Test","Test","Test","Test"]
        } else if kanaArray.count == 5 && mode == .writing {
            return ["Learn","Practice","FirstTest","Learn","Practice","FirstTest","Test","Test","Test","Test","Learn","Practice","FirstTest","Learn","Practice","FirstTest","Test","Test","Test","Test","Test","Test","Test","Test","Learn","Practice","FirstTest","Test","Test","Test","Test","Test","Test","Test","Test","Test","Test"]
        } else {
            return ["Learn","Practice","FirstTest","Learn","Practice","FirstTest","Test","Test","Test","Test","Learn","Practice","FirstTest","Test","Test","Test","Test","Test","Test"]
        }
    }
    
    var totalParts: Int {
        return partsArray.count
    }
    
    var partType: String {
        return partsArray[currentPart - 1]
    }
    
    var currentRomaji: String {
        switch hiraganaOrKatakana {
        case .hiragana:
            return hiraganaAllToRomaji[currentKana]!
        case .katakana:
            return katakanaAllToRomaji[currentKana]!
        }
    }
    
    enum State {
        case play
        case end
    }
    enum HiraganaOrKatakana {
        case hiragana
        case katakana
    }
    enum Mode {
        case reading
        case writing
    }
    
    init(with kanaArray: [String], name: String, hiraganaOrKatakana: HiraganaOrKatakana, mode: Mode) {
        self.state = .play
        self.kanaArray = kanaArray
        self.title = name
        self.currentPart = 1
        self.numberOfTest = 0
        self.numberOfPractice = 0
        self.numberOfFirstTest = 0
        self.currentKana = kanaArray[currentPart - 1]
        switch hiraganaOrKatakana {
        case .hiragana:
            self.hiraganaOrKatakana = .hiragana
        case .katakana:
            self.hiraganaOrKatakana = .katakana
        }
        self.mode = mode
    }
    
    func nextPart() {
        if currentPart < totalParts {
            currentPart += 1
            if partsArray[currentPart - 1] == "Learn" {
                currentKana = kanaArray[currentPart - 1 - numberOfTest - numberOfPractice - numberOfFirstTest]
            } else if partsArray[currentPart - 1] == "Practice" {
                numberOfPractice += 1
            } else if partsArray[currentPart - 1] == "FirstTest" {
                numberOfFirstTest += 1
            } else if partsArray[currentPart - 1] == "Test" {
                numberOfTest += 1
            }
        } else {
            finishLesson()
        }
    }
    
    func finishLesson() {
        state = .end
    }
    
    func EndOfTests(reading: Bool) -> Bool {
        if reading == true {
            if currentPart == (partsArray.lastIndex(of: "Learn")! + 2 ) {
                return true
            } else {
                return false
            }
        } else {
            if currentPart == (partsArray.lastIndex(of: "FirstTest")! + 2 ) {
                return true
            } else {
                return false
            }
        }
        
    }
    
    
}
