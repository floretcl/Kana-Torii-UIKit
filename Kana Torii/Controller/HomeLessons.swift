//
//  HomeLessons.swift
//  Kana Torii
//
//  Created by clément floret on 24/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit
import GradientButtonSwift

class HomeLessons: UIViewController {
    
    // MARK: - Properties
    var choiceKanaType: Lessons.KanaType!
    var lessonType: Lessons.LessonType!
    
    // MARK: - Actions
    @IBAction func buttonHiragana(_ sender: Any) {
        choiceKanaType = .hiragana
        lessonType = .reading
    }
    
    @IBAction func buttonKatakana(_ sender: Any) {
        choiceKanaType = .katakana
        lessonType = .reading
    }
    
    @IBAction func buttonHiraganaWriting(_ sender: Any) {
        choiceKanaType = .hiragana
        lessonType = .writing
    }
    
    @IBAction func buttonKatakanaWriting(_ sender: Any) {
        choiceKanaType = .katakana
        lessonType = .writing
    }
    
    @IBAction func unwindToHomeLesson(segue:UIStoryboardSegue) {
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLessons()
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToHiraganaLessons" {
            if let hiraganaLessonVC = segue.destination as? KanaLessons {
                hiraganaLessonVC.choiceKanaType = choiceKanaType
                hiraganaLessonVC.lessonType = lessonType
            }
        } else if segue.identifier == "segueToKatakanaLessons" {
            if let katakanaLessonVC = segue.destination as? KanaLessons {
                katakanaLessonVC.choiceKanaType = choiceKanaType
                katakanaLessonVC.lessonType = lessonType
            }
        } else if segue.identifier == "segueToHiraganaWritingLessons" {
            if let hiraganaWritingLessonVC = segue.destination as? KanaLessons {
                hiraganaWritingLessonVC.choiceKanaType = choiceKanaType
                hiraganaWritingLessonVC.lessonType = lessonType
            }
        } else if segue.identifier == "segueToKatakanaWritingLessons" {
            if let katakanaWritingLessonVC = segue.destination as? KanaLessons {
                katakanaWritingLessonVC.choiceKanaType = choiceKanaType
                katakanaWritingLessonVC.lessonType = lessonType
            }
        }
    }
}

// MARK: - Extensions

extension HomeLessons {
    
    // Create lessons list for all mode
    private func createLessons() {
        for lessons in Lessons.lessonsHiraganaGojuon {
            LessonsService.shared.addToHiraganaOne(lessons: lessons)
        }
        for lessons in Lessons.lessonsHiraganaDakuonHandakuon {
            LessonsService.shared.addToHiraganaTwo(lessons: lessons)
        }
        for lessons in Lessons.lessonsHiraganaYoon {
            LessonsService.shared.addToHiraganaThree(lessons: lessons)
        }
        for lessons in Lessons.lessonsKatakanaGojuon {
            LessonsService.shared.addToKatakanaOne(lessons: lessons)
        }
        for lessons in Lessons.lessonsKatakanaDakuonHandakuon {
            LessonsService.shared.addToKatakanaTwo(lessons: lessons)
        }
        for lessons in Lessons.lessonsKatakanaYoon {
            LessonsService.shared.addToKatakanaThree(lessons: lessons)
        }
        
    }
}
