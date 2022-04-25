//
//  Quiz.swift
//  Kana Torii
//
//  Created by clément floret on 09/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import Foundation
import UIKit

class Quiz {
    
    // MARK: - Properties
    
    var difficulty: Difficulty
    var mode: Mode
    var hiraganaOrKatakana: HiraganaOrKatakana
    var correctAnswer: Bool
    var score: Int
    var numberQuestion: Int
    var currentIndex: Int
    var kana = Dictionary<String, String>()
    var state: State
    var romajiToUse: [String]
    var arrayCorrectKanaToRomaji = Dictionary<String, String>()
    var kanaToRomaji = Dictionary<String, String>()
    let numberOfSuggestion: Int = 9
    
    var currentRomaji: String {
        return romajiToUse[currentIndex]
    }
    
    var correctRomaji: String {
        return arrayCorrectKanaToRomaji[currentKana]!
    }
    
    var currentKana: String {
        return kana[currentRomaji]!
    }
    
    var numberTotalKana: Int {
        return romajiToUse.count
    }
    var randomNumberArray: [Int] {
        var randomNumbers: [Int] = []
        var randomInt: Int
        randomNumbers.append(currentIndex)
        for i in 2...numberOfSuggestion {
            var same : Bool = true
            repeat {
                randomInt = Int.random(in: 0..<romajiToUse.count)
                if i > 1 {
                    if randomNumbers.contains(randomInt) {
                        same = true
                    } else {
                        same = false
                    }
                } else {
                    same = false
                }
            } while same
            randomNumbers.append(randomInt)
        }
        
        
        return randomNumbers.shuffled()
    }
    
    enum Difficulty {
        case easy
        case hard
    }
    
    enum Mode {
        case kanaToRomaji
        case romajiToKana
    }
    
    enum HiraganaOrKatakana {
        case hiragana
        case katakana
    }
    
    enum TypeKana {
        case gojuon
        case handakuon
        case yoon
    }
    
    enum State {
        case play
        case end
       }
    
    
    
    init(difficulty: Difficulty,mode: Mode, hiraganaOrKatakana: HiraganaOrKatakana, all: Bool, kanaType: TypeKana) {
        self.state = .play
        self.correctAnswer = false
        self.score = 0
        self.numberQuestion = 1
        self.currentIndex = 0
        self.difficulty = difficulty
        self.mode = mode
        self.hiraganaOrKatakana = hiraganaOrKatakana
            
        switch hiraganaOrKatakana {
        case .hiragana:
            arrayCorrectKanaToRomaji = hiraganaAllToRomaji
            if all {
                romajiToUse = allRomaji
                kana = romajiToHiraganaAll
                kanaToRomaji = hiraganaAllToRomaji
                
            } else {
                switch kanaType {
                    case .gojuon:
                        romajiToUse = gojuonRomaji
                        kana = romajiToHiraganaGojuon
                        kanaToRomaji = hiraganaGojuonToRomaji
                    case .handakuon:
                        romajiToUse = dakuonHandakuonRomaji
                        kana = romajiToHiraganaHandakuon
                        kanaToRomaji = hiraganaHandakuonToRomaji
                    case .yoon:
                        romajiToUse = yoonRomaji
                        kana = romajiToHiraganaYoon
                        kanaToRomaji = hiraganaYoonToRomaji
                }
            }
        case .katakana:
            arrayCorrectKanaToRomaji = katakanaAllToRomaji
            if all {
                romajiToUse = allRomaji
                kana = romajiToKatakanaAll
                kanaToRomaji = katakanaAllToRomaji
            } else {
                switch kanaType {
                    case .gojuon:
                        romajiToUse = gojuonRomaji
                        kana = romajiToKatakanaGojuon
                        kanaToRomaji = katakanaGojuonToRomaji

                    case .handakuon:
                        romajiToUse = dakuonHandakuonRomaji
                        kana = romajiToKatakanaHandakuon
                        kanaToRomaji = katakanaHandakuonToRomaji

                    case .yoon:
                        romajiToUse = yoonRomaji
                        kana = romajiToKatakanaYoon
                        kanaToRomaji = katakanaYoonToRomaji

                }
            }
        }
        romajiToUse.shuffle()
        if difficulty == .easy {
            deleteSuggestions()
            createSuggestions()
        }

    }
 
    
     func answerCurrentQuestion(with answer: String) {
        if (difficulty == .hard && mode == .kanaToRomaji) {
            if answer.lowercased() == correctRomaji.lowercased() {
                registerGoodAnswer()
            }
        } else if (difficulty == .easy && mode == .romajiToKana ) {
            if answer == currentKana {
                registerGoodAnswer()
            }
        } else if (difficulty == .easy && mode == .kanaToRomaji) {
            if answer.lowercased() == currentRomaji.lowercased() {
                registerGoodAnswer()
            }
        } else if (difficulty == .hard && mode == .romajiToKana) {
            if answer == currentKana {
                registerGoodAnswer()
            }
        }
        nextQuestion()
    }
    
    private func registerGoodAnswer() {
        score += 1
        correctAnswer = true
    }
    
    private func nextQuestion() {
        if currentIndex < romajiToUse.count - 1 {
            currentIndex += 1
            numberQuestion += 1
        } else {
            finishQuiz()
        }
        if difficulty == .easy {
            deleteSuggestions()
            createSuggestions()
        }
    }
    
    private func finishQuiz() {
        state = .end
    }
    
    func createSuggestions() {
        for number in randomNumberArray {
            let suggestion = Detail(romaji: romajiToUse[number], kana: kana[romajiToUse[number]]!, linesImage: UIImage())
            SuggestionService.shared.addToSuggestionKana(suggestion: suggestion)
        }
    }
    func deleteSuggestions() {
        SuggestionService.shared.deleteToSuggestionKana()
    }
}
