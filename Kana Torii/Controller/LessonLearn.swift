//
//  LessonLearn.swift
//  Kana Torii
//
//  Created by clément floret on 07/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit
import GradientButtonSwift

class LessonLearn: UIViewController {
        
    // MARK: - Properties
    var currentLesson: Lesson!
    var test: Test!
    var choiceKanaType: Lessons.KanaType!
    var lessonType: Lessons.LessonType!
    
    var detail: Detail = Detail(romaji: "", kana: "", linesImage: UIImage())
    var arrayKana: [String] = []
    
    // MARK: - Outlets
    @IBOutlet weak var partLesson: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLesson: UILabel!
    @IBOutlet weak var romaji: UILabel!
    @IBOutlet weak var kana: UILabel!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var continueButton: GradientButton!
    @IBOutlet weak var subtitle: LabelRounded!
    
    // MARK: - Actions
    @IBAction func submitSoundButton() {
        readKana()
    }
    
    @IBAction func submitContinueButton() {
        switch currentLesson.state {
        case .play:
            alertIfStartNotedTest()
            if currentLesson.partType == "Test" {
                var randomInt: Int
                randomInt = Int.random(in: 0...1)
                createTestInstance()
                if randomInt == 0 {
                    performSegue(withIdentifier: "segueToLessonTest", sender: self)
                } else {
                    performSegue(withIdentifier: "segueToLessonTestRomaji", sender: self)
                }
            } else if currentLesson.partType == "Learn" {
                newPart()
            }
        case .end:
            performSegue(withIdentifier: "unwindToKanaLesson", sender: self)
        }
    }
    
    @IBAction func unwindToLessonLearn(segue:UIStoryboardSegue) {
        newPart()
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelsSize()
        setLessonTitle()
        newPart()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToLessonTest" {
            if let lessonTestVC = segue.destination as? LessonTest {
                lessonTestVC.currentLesson = currentLesson
                lessonTestVC.test = test
                
            }
        } else if segue.identifier == "segueToLessonTestRomaji" {
            if let lessonTestRomajiVC = segue.destination as? LessonTestRomaji {
                lessonTestRomajiVC.currentLesson = currentLesson
                lessonTestRomajiVC.test = test
            }
        }
    }
}

// MARK: - Extensions

extension LessonLearn {
    
    // Resize labels for different screen size
    private func setLabelsSize() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 12.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 12.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 18.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 55.0)
            kana.font = UIFont(name: kana.font.fontName, size: 120.0)
        } else if screenHeight >= 667 && screenHeight < 736 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 14.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 16.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 22.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 65.0)
            kana.font = UIFont(name: kana.font.fontName, size: 140.0)
        } else if screenHeight >= 736 && screenHeight < 812 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 16.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 20.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 24.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 85.0)
            kana.font = UIFont(name: kana.font.fontName, size: 170.0)
        } else if screenHeight >= 812 && screenHeight < 896 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 16.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 22.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 28.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 85.0)
            kana.font = UIFont(name: kana.font.fontName, size: 175.0)
        } else if screenHeight >= 896 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 16.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 22.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 34.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 95.0)
            kana.font = UIFont(name: kana.font.fontName, size: 190.0)
        }
    }
    
    // Set display
    private func setView() {
        partLesson.text = NSLocalizedString("Part", comment: "") + " \(currentLesson.currentPart) / \(currentLesson.totalParts)"
        progressBar.progress = (Float(currentLesson.currentPart) / Float(currentLesson.totalParts))
        romaji.text = detail.romaji
        kana.text = detail.kana
    }
    
    // Set detail instance
    private func setdetail() {
        detail = Detail(romaji: currentLesson.currentRomaji, kana: currentLesson.currentKana, linesImage: UIImage())
    }
    
    // Set lesson title
    private func setLessonTitle() {
        var kanaTypeTitle: String
        if choiceKanaType == .hiragana {
            kanaTypeTitle = "Hiragana"
        } else {
            kanaTypeTitle = "Katakana"
        }
        titleLesson.text = kanaTypeTitle + " " + currentLesson.title + NSLocalizedString("Reading", comment: "")
    }
    
    // New part of current lesson
    private func newPart() {
        setdetail()
        setView()
        arrayKana.append(currentLesson.currentKana)
        currentLesson.nextPart()
        readKana()
    }
    
    // Play kana reading
    private func readKana() {
        detail.readTextInJapanese(text: detail.kana)
    }
    
    // Create test instance for next view controllers
    private func createTestInstance() {
        var hiraganaOrKatakana: Test.HiraganaOrKatakana
        
        if choiceKanaType == .hiragana {
            hiraganaOrKatakana = .hiragana
        } else {
            hiraganaOrKatakana = .katakana
        }
        
        test = Test(hiraganaOrKatakana: hiraganaOrKatakana, arrayKana: arrayKana, allKana: currentLesson.kanaArray )
    }
    
    // display alert if user start noted tests
    private func alertIfStartNotedTest() {
        if currentLesson.EndOfTests(reading: true) {
            let alert = UIAlertController(title: NSLocalizedString("Note", comment: ""), message: NSLocalizedString("EndOfLearning", comment: ""), preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                if self.currentLesson.partType == "Test" {
                    var randomInt: Int
                    randomInt = Int.random(in: 0...1)
                    self.createTestInstance()
                    if randomInt == 0 {
                        self.performSegue(withIdentifier: "segueToLessonTest", sender: self)
                    } else {
                        self.performSegue(withIdentifier: "segueToLessonTestRomaji", sender: self)
                    }
                } else if self.currentLesson.partType == "Learn" {
                    self.newPart()
                }
            }
            alert.view.tintColor = #colorLiteral(red: 1, green: 0.4045273066, blue: 0, alpha: 1)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
