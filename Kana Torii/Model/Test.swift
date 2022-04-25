//
//  Test.swift
//  Kana Torii
//
//  Created by Clément FLORET on 06/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.

import Foundation
import UIKit

class Test {
    
    // MARK: - Properties
    
    var state: State
    var correctAnswer: Bool
    var currentIndex: Int
    var score: Int
    var hiraganaOrKatakana: HiraganaOrKatakana
    var kanaToRomaji = Dictionary<String, String>()
    var kanaToUse: [String]
    var allKanaToLearn: [String]
    var numberOfSuggestion: Int
    var loop: Int
    
    var currentKana: String {
        return kanaToUse[currentIndex]
    }
    
    var currentRomaji: String {
        return kanaToRomaji[currentKana]!
    }
    
    var numberTotalKana: Int {
        return kanaToUse.count
    }
    
    var randomStringArray: [String] {
        var randomStringArray: [String] = []
        var randomString: String
        randomStringArray.append(currentKana)
        for i in 2...numberOfSuggestion {
            var same : Bool = true
            repeat {
                randomString = allKanaToLearn.randomElement()!
                if i > 1 {
                    if randomStringArray.contains(randomString) {
                        same = true
                    } else {
                        same = false
                    }
                } else {
                    same = false
                }
            } while same
            randomStringArray.append(randomString)
        }
        return randomStringArray.shuffled()
    }
    
    enum HiraganaOrKatakana {
        case hiragana
        case katakana
    }
    
    enum State {
        case play
        case end
    }
    
    init(hiraganaOrKatakana: HiraganaOrKatakana, arrayKana: [String], allKana: [String]) {
        self.state = .play
        self.correctAnswer = false
        self.currentIndex = 0
        self.score = 0
        self.numberOfSuggestion = 4
        self.allKanaToLearn = allKana
        if allKanaToLearn.count == 3 {
            self.numberOfSuggestion = 3
        }
        self.hiraganaOrKatakana = hiraganaOrKatakana
        self.kanaToUse = arrayKana
        
        self.loop = 0
        
        switch hiraganaOrKatakana {
        case .hiragana:
            kanaToRomaji = hiraganaAllToRomaji
        case .katakana:
            kanaToRomaji = katakanaAllToRomaji
        }
        
        kanaToUse.shuffle()
    }
    
    func answerCurrentQuestion(with answer: String, kanaToRomajiOrRomajiToKana: Bool, score: Bool) {
        if kanaToRomajiOrRomajiToKana {
            if answer.lowercased() == currentRomaji.lowercased() {
                correctAnswer = true
                if score == true {
                    self.score += 1
                }
            } else {
                correctAnswer = false
            }
        } else {
            if answer == currentKana {
                correctAnswer = true
                if score == true {
                    self.score += 1
                }
            } else {
                correctAnswer = false
            }
        
        }
        nextQuestion(kanaToRomajiOrRomajiToKana: kanaToRomajiOrRomajiToKana)
    }
    
    private func nextQuestion(kanaToRomajiOrRomajiToKana: Bool) {
        
        if currentIndex < kanaToUse.count - 1 {
            currentIndex += 1
        } else if (currentIndex >= kanaToUse.count - 1 ) && (loop == 0){
            kanaToUse.shuffle()
            currentIndex = 0
            loop = 1
        } else {
            finishTest()
        }
    }
    
    private func finishTest() {
        state = .end
    }
    
    func createSuggestions() {
        for string in randomStringArray {
            let suggestion = Detail(romaji: kanaToRomaji[string]!, kana: string, linesImage: UIImage())
            SuggestionService.shared.addToSuggestionKana(suggestion: suggestion)
            
        }
    }
    func deleteSuggestions() {
        SuggestionService.shared.deleteToSuggestionKana()
    }
}

