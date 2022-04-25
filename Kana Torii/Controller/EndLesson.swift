//
//  EndLesson.swift
//  Kana Torii
//
//  Created by Clément FLORET on 11/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class EndLesson: UIViewController {

    // MARK: - Properties
    var currentLesson: Lesson!
    var test: Test!
        
    // MARK: - Outlets
    @IBOutlet weak var titleScore: UILabel!
    @IBOutlet weak var score: UILabel!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

        showScore()
        saveData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - Extensions

extension EndLesson {
    
    // SetDisplay : show score 
    private func showScore() {
        if currentLesson.mode == .reading {
            titleScore.text = NSLocalizedString("YourScore", comment: "")
            score.text = "\(test.score) / \(test.allKanaToLearn.count * 2)"
        } else {
            titleScore.text = NSLocalizedString("YourScore", comment: "")
            score.text = "\(test.score) / \((test.allKanaToLearn.count * 2))"
        }
        
    }
    
    // Save lesson data in CoreData
    private func saveData() {
        let title = currentLesson.title
        var hiraganaOrKatakana: String
        var mode: String
        if currentLesson.hiraganaOrKatakana == .hiragana && currentLesson.mode == .reading {
            hiraganaOrKatakana = "hiragana"
            mode = "reading"
        } else if currentLesson.hiraganaOrKatakana == .hiragana && currentLesson.mode == .writing {
            hiraganaOrKatakana = "hiragana"
            mode = "writing"
        } else if currentLesson.hiraganaOrKatakana == .katakana && currentLesson.mode == .reading {
            hiraganaOrKatakana = "katakana"
            mode = "reading"
        } else {
            hiraganaOrKatakana = "katakana"
            mode = "writing"
        }
        let lessondt = LessonData(context: AppDelegate.viewContext)
        lessondt.name = title
        lessondt.type = hiraganaOrKatakana
        lessondt.mode = mode
        lessondt.completed = true
        do {
            try AppDelegate.viewContext.save()
        } catch {
            fatalError("Error saving lesson data")
        }
    }
}
