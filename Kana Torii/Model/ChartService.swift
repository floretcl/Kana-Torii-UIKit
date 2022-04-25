//
//  ChartService.swift
//  Kana Torii
//
//  Created by clément floret on 25/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import Foundation

class ChartService {
    static let shared = ChartService()
    private init() {}

    private(set) var chartHiraganaOne: [Chart] = []
    private(set) var chartHiraganaTwo: [Chart] = []
    private(set) var chartHiraganaThree: [Chart] = []
    
    private(set) var chartKatakanaOne: [Chart] = []
    private(set) var chartKatakanaTwo: [Chart] = []
    private(set) var chartKatakanaThree: [Chart] = []

    func addToHiraganaOne(chart: Chart) {
        chartHiraganaOne.append(chart)
    }
    func addToHiraganaTwo(chart: Chart) {
        chartHiraganaTwo.append(chart)
    }
    func addToHiraganaThree(chart: Chart) {
        chartHiraganaThree.append(chart)
    }
    
    func addToKatakanaOne(chart: Chart) {
        chartKatakanaOne.append(chart)
    }
    func addToKatakanaTwo(chart: Chart) {
        chartKatakanaTwo.append(chart)
    }
    func addToKatakanaThree(chart: Chart) {
        chartKatakanaThree.append(chart)
    }
}
