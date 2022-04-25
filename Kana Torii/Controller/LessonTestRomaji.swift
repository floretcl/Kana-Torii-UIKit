//
//  LessonTestRomaji.swift
//  Kana Torii
//
//  Created by Clément FLORET on 08/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit
import AudioToolbox
import GradientButtonSwift

class LessonTestRomaji: UIViewController {

    // MARK: - Properties
    var currentLesson: Lesson!
    var test: Test!
    var detail: Detail = Detail(romaji: "", kana: "", linesImage: UIImage())
    let generator = UINotificationFeedbackGenerator() // Feedback vibrations
    
    // MARK: - Outlets
    @IBOutlet weak var partLesson: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLesson: UILabel!
    @IBOutlet weak var romaji: UILabel!
    @IBOutlet weak var correction: CorrectionLabel!
    @IBOutlet weak var annotationAnswer: UILabel!
    @IBOutlet weak var suggestionCollection: UICollectionView!
    @IBOutlet weak var continueButton: GradientButton!
    @IBOutlet weak var subtitle: LabelRounded!
    
    
    
    // MARK: - Actions
    @IBAction func submitContinueButton(_ sender: Any) {
        switch currentLesson.state {
        case .play:
            if currentLesson.partType == "Test" {
                var randomInt: Int
                randomInt = Int.random(in: 0...1)
                if randomInt == 0 {
                    performSegue(withIdentifier: "segueTestRomajiToTest", sender: self)
                } else {
                    newQuestion()
                }
            } else if currentLesson.partType == "Learn" {
                performSegue(withIdentifier: "unwindToLessonLearn", sender: self)
            }
        case .end:
            performSegue(withIdentifier: "segueLessonTestRomajiToEnd", sender: self)
        }
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabelsSize()
        setLessonTitle()
        newQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        suggestionCollection.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueTestRomajiToTest" {
            let testVC = segue.destination as! LessonTest
            testVC.currentLesson = currentLesson
            testVC.test = test
        } else if segue.identifier == "segueLessonTestRomajiToEnd" {
             let endVC = segue.destination as! EndLesson
             endVC.currentLesson = currentLesson
             endVC.test = test
        }
    }
}

extension LessonTestRomaji {
    
    private func playSound(sound: String, ext: String) {
        if let soundURL = Bundle.main.url(forResource: sound, withExtension: ext) {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);
        }
    }
    
    // Play kana reading
    private func readKana() {
        detail.readTextInJapanese(text: detail.kana)
    }
    
}

extension LessonTestRomaji {
    
    // Resize labels for different screen size
    private func setLabelsSize() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 12.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 12.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 14.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 60.0)
            correction.font = UIFont(name: correction.font.fontName, size: 20.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 12.0)
        } else if screenHeight >= 667 && screenHeight < 736 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 14.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 16.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 18.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 100.0)
            correction.font = UIFont(name: correction.font.fontName, size: 30.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 16.0)
        } else if screenHeight >= 736 && screenHeight < 812 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 16.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 20.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 22.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 120.0)
            correction.font = UIFont(name: correction.font.fontName, size: 35.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 18.0)
        } else if screenHeight >= 812 && screenHeight < 896 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 16.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 20.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 22.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 140.0)
            correction.font = UIFont(name: correction.font.fontName, size: 40.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 18.0)
        } else if screenHeight >= 896 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 16.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 22.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 28.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 150.0)
            correction.font = UIFont(name: correction.font.fontName, size: 42.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 18.0)
        }
    }
    
    // Create Detail instance
    private func setDetail() {
        detail = Detail(romaji: test.currentRomaji, kana: test.currentKana, linesImage: UIImage())
    }
    
    // Set lesson title
    private func setLessonTitle() {
        var kanaTypeTitle: String
        if currentLesson.hiraganaOrKatakana == .hiragana {
            kanaTypeTitle = "Hiragana"
        } else {
            kanaTypeTitle = "Katakana"
        }
        
        titleLesson.text = kanaTypeTitle + " " + currentLesson.title + NSLocalizedString("Reading", comment: "")
    }
    
    // Set display
    private func setView() {
        annotationAnswer.alpha = 0
        correction.alpha = 0
        continueButton.alpha = 0
        suggestionCollection.alpha = 1
        romaji.alpha = 1
        correction.text = test.currentKana
        suggestionCollection.reloadData()
        romaji.text = test.currentRomaji
        partLesson.text = NSLocalizedString("Part", comment: "") + " \(currentLesson.currentPart) / \(currentLesson.totalParts)"
        progressBar.progress = (Float(currentLesson.currentPart) / Float(currentLesson.totalParts))
    }
    
    private func newQuestion() {
        
        test.correctAnswer = false
        setView()
        currentLesson.nextPart()
        test.deleteSuggestions()
        test.createSuggestions()
        setDetail()
        readKana()
    }
    
    
    private func answerQuestion(with name: String, cell: SuggestionCollectionViewCell) {
        
        // Answer question
        test.answerCurrentQuestion(with: name, kanaToRomajiOrRomajiToKana: false, score: true)
        
        // If user answer is correct
        if test.correctAnswer == true {
            // Haptic feedback correct answer
            generator.notificationOccurred(.success)
            
            // Change display settings for correct answer
            annotationAnswer.text = NSLocalizedString("GoodAnswer", comment: "")
            annotationAnswer.textColor = .green
            annotationAnswer.alpha = 1
            cell.setColorToGreen()
            
            // Play sound correct answer
            playSound(sound: "Correct Beep", ext: "mp3")
            
            // animation for correct answer
            UIView.animate(withDuration: 1.0) {
                self.annotationAnswer.alpha = 0
                self.romaji.alpha = 0
            }
            
            // Move to another part of lesson
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                // Put your code which should be executed with a delay here
                cell.setdefaultColor()
                switch self.currentLesson.state {
                case .play:
                    if self.currentLesson.partType == "Test" {
                        var randomInt: Int
                        randomInt = Int.random(in: 0...1)
                        if randomInt == 0 {
                            self.performSegue(withIdentifier: "segueTestRomajiToTest", sender: self)
                        } else {
                            self.newQuestion()
                        }
                    } else if self.currentLesson.partType == "Learn" {
                        self.performSegue(withIdentifier: "unwindToLessonLearn", sender: self)
                    }
                case .end:
                    self.performSegue(withIdentifier: "segueLessonTestRomajiToEnd", sender: self)
                }
            }
            // If user answer is wrong
        } else {
            // Haptic feedback wrong answer
            generator.notificationOccurred(.error)
            
            // Change display settings for wrong answer
            annotationAnswer.text = NSLocalizedString("WrongAnswer", comment: "")
            annotationAnswer.textColor = .red
            annotationAnswer.alpha = 1
            cell.setColorToRed()
            
            // Play sound for wrong answer
            playSound(sound: "Wrong Beep", ext: "mp3")
            
            // animation for wrong answer
            UIView.animate(withDuration: 2.0) {
                self.annotationAnswer.alpha = 0
            }
            
            // Correction step
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                // Put your code which should be executed with a delay here
                cell.setdefaultColor()
                self.suggestionCollection.alpha = 0
                self.continueButton.alpha = 1
                self.correction.alpha = 1
            }
        }
    }
}

extension LessonTestRomaji: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return SuggestionService.shared.suggestionKana.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = suggestionCollection.dequeueReusableCell(withReuseIdentifier: SuggestionCollectionViewCell.reuseID, for: indexPath) as? SuggestionCollectionViewCell else {
            return UICollectionViewCell()
        }
        // Configure the cell
        let suggestion: Detail
        suggestion = SuggestionService.shared.suggestionKana[indexPath.item]
        cell.setSuggestionCell(with: suggestion.kana)
        cell.delegate = self
        
        return cell
    }
}

extension LessonTestRomaji: SuggestionCollectionViewCellDelegate {
    
    // When tap on a cell: answer question
    func didTapButton(with name: String, self cell: SuggestionCollectionViewCell) {
        answerQuestion(with: name, cell: cell)
    }
}
