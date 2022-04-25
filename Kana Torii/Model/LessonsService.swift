//
//  LessonsService.swift
//  Kana Torii
//
//  Created by clément floret on 24/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import Foundation

class LessonsService {
    static let shared = LessonsService()
    private init() {}

    private(set) var lessHiraganaOne: [Lessons] = []
    private(set) var lessHiraganaTwo: [Lessons] = []
    private(set) var lessHiraganaThree: [Lessons] = []
    
    private(set) var lessKatakanaOne: [Lessons] = []
    private(set) var lessKatakanaTwo: [Lessons] = []
    private(set) var lessKatakanaThree: [Lessons] = []

    func addToHiraganaOne(lessons: Lessons) {
        lessHiraganaOne.append(lessons)
    }
    func addToHiraganaTwo(lessons: Lessons) {
        lessHiraganaTwo.append(lessons)
    }
    func addToHiraganaThree(lessons: Lessons) {
        lessHiraganaThree.append(lessons)
    }
    
    func addToKatakanaOne(lessons: Lessons) {
        lessKatakanaOne.append(lessons)
    }
    func addToKatakanaTwo(lessons: Lessons) {
        lessKatakanaTwo.append(lessons)
    }
    func addToKatakanaThree(lessons: Lessons) {
        lessKatakanaThree.append(lessons)
    }
    
}
