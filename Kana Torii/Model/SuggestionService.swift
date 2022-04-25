//
//  SuggestionService.swift
//  Kana Torii
//
//  Created by clément floret on 02/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import Foundation

class SuggestionService {
    static let shared = SuggestionService()
    private init() {}

    private(set) var suggestionKana: [Detail] = []

    func addToSuggestionKana(suggestion: Detail) {
        suggestionKana.append(suggestion)
    }
    func deleteToSuggestionKana() {
        suggestionKana.removeAll()
    }
    
}
