//
//  LessonLearnWriting.swift
//  Kana Torii
//
//  Created by clément floret on 01/08/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit
import GradientButtonSwift

class LessonLearnWriting: UIViewController {
        
    // MARK: - Properties
    var currentLesson: Lesson!
    var test: Test!
    var choiceKanaType: Lessons.KanaType!
    var lessonType: Lessons.LessonType!
    var arrayKana: [String] = []
    
    var detail: Detail = Detail(romaji: "", kana: "", linesImage: UIImage())
    
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
    @IBAction func submitSoundButton(_ sender: Any) {
        readKana()
    }
    @IBAction func submitContinueButton(_ sender: Any) {
        switch currentLesson.state {
        case .play:
            if currentLesson.partType == "Practice" {
                performSegue(withIdentifier: "segueToLessonWritingTestPractice", sender: self)
            }
        case .end:
            performSegue(withIdentifier: "unwindToKanaLesson", sender: self)
        }
    }
    
    @IBAction func unwindToLessonLearnWriting(segue:UIStoryboardSegue) {
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
        if segue.identifier == "segueToLessonWritingTestPractice" {
            if let lessonTestPracticeVC = segue.destination as? LessonTestWritingPractice {
                lessonTestPracticeVC.currentLesson = currentLesson
                lessonTestPracticeVC.choiceKanaType = choiceKanaType
                lessonTestPracticeVC.arrayKana = arrayKana
            }
        }
    }
}

// MARK: - Extensions

extension LessonLearnWriting {
    
    // Resize labels for different screen size
    private func setLabelsSize() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 12.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 16.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 20.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 55.0)
            kana.font = UIFont(name: kana.font.fontName, size: 120.0)
        } else if screenHeight >= 667 && screenHeight < 736 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 14.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 18.0)
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
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 20.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 24.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 85.0)
            kana.font = UIFont(name: kana.font.fontName, size: 175.0)
        } else if screenHeight >= 896 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 16.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 20.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 24.0)
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
    private func setDetail() {
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
        titleLesson.text = kanaTypeTitle + " " + currentLesson.title + NSLocalizedString("Writing", comment: "")
    }
    
    // New part of current lesson
    private func newPart() {
        setDetail()
        setView()
        arrayKana.append(currentLesson.currentKana)
        currentLesson.nextPart()
        readKana()
    }
    
    // Play kana reading
    private func readKana() {
        detail.readTextInJapanese(text: detail.kana)
    }
}
