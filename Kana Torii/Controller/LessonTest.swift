//
//  LessonTest.swift
//  Kana Torii
//
//  Created by Clément FLORET on 08/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit
import AudioToolbox
import GradientButtonSwift

class LessonTest: UIViewController {

    // MARK: - Properties
    var currentLesson: Lesson!
    var test: Test!
    let generator = UINotificationFeedbackGenerator() // Feedback vibrations

    // MARK: - Outlets
    @IBOutlet weak var partLesson: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLesson: UILabel!
    @IBOutlet weak var kana: UILabel!
    @IBOutlet weak var romaji: UILabel!
    @IBOutlet weak var correction: CorrectionLabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var annotationAnswer: UILabel!
    @IBOutlet weak var continueButton: GradientButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var subtitle: LabelRounded!
    
    // MARK: - Actions
    @IBAction func submitContinueButton(_ sender: Any) {
        switch currentLesson.state {
        case .play:
            if currentLesson.partType == "Test" {
                var randomInt: Int
                randomInt = Int.random(in: 0...1)
                if randomInt == 0 {
                    newQuestion()
                } else {
                    performSegue(withIdentifier: "segueTestToTestRomaji", sender: self)
                }
            } else if currentLesson.partType == "Learn" {
                performSegue(withIdentifier: "unwindToLessonLearn", sender: self)
            }
        case .end:
            performSegue(withIdentifier: "segueLessonTestToEnd", sender: self)
        }
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelsSize()
        setLessonTitle()
        
        annotationAnswer.alpha = 0
        continueButton.alpha = 0
        answerTextField.delegate = self
        
        registerForKeyboardNotifications()
        newQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "segueTestToTestRomaji" {
             let testRomajiVC = segue.destination as! LessonTestRomaji
             testRomajiVC.currentLesson = currentLesson
             testRomajiVC.test = test
         } else if segue.identifier == "segueLessonTestToEnd" {
                let endVC = segue.destination as! EndLesson
                endVC.currentLesson = currentLesson
                endVC.test = test
         }
     }
}

// MARK: - Extensions

extension LessonTest: UITextFieldDelegate {
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func deleteKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height, right: 0.0)

        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets

        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.answerTextField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        self.scrollView.isScrollEnabled = true
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize!.height, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
}

extension LessonTest {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        answerQuestion()
        return false
    }
    
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func playSound(sound: String, ext: String) {
        if let soundURL = Bundle.main.url(forResource: sound, withExtension: ext) {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);
        }
    }
}

extension LessonTest {
    
    // Resize labels for different screen sizeip
    private func setLabelsSize() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 12.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 12.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 14.0)
            kana.font = UIFont(name: kana.font.fontName, size: 43.0)
            correction.font = UIFont(name: correction.font.fontName, size: 18.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 12.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 12.0)
        } else if screenHeight >= 667 && screenHeight < 736 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 14.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 16.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 18.0)
            kana.font = UIFont(name: kana.font.fontName, size: 120.0)
            correction.font = UIFont(name: correction.font.fontName, size: 25.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 16.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 16.0)
        } else if screenHeight >= 736 && screenHeight < 812 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 16.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 20.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 22.0)
            kana.font = UIFont(name: kana.font.fontName, size: 145.0)
            correction.font = UIFont(name: correction.font.fontName, size: 33.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 20.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 18.0)
        } else if screenHeight >= 812 && screenHeight < 896 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 16.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 20.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 22.0)
            kana.font = UIFont(name: kana.font.fontName, size: 120.0)
            correction.font = UIFont(name: correction.font.fontName, size: 28.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 18.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 18.0)
        } else {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 16.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 22.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 28.0)
            kana.font = UIFont(name: kana.font.fontName, size: 160.0)
            correction.font = UIFont(name: correction.font.fontName, size: 38.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 20.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 18.0)
        }
    }
    
    // Set Lesson title
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
        kana.alpha = 1
        correction.text = test.currentRomaji
        test.correctAnswer = false
        kana.text = test.currentKana
        partLesson.text = NSLocalizedString("Part", comment: "") + " \(currentLesson.currentPart) / \(currentLesson.totalParts)"
        progressBar.progress = (Float(currentLesson.currentPart) / Float(currentLesson.totalParts))
    }
    
    private func newQuestion() {
        // Auto display keyboard
        answerTextField.becomeFirstResponder()

        setView()
        currentLesson.nextPart()
    }
    
    private func answerQuestion() {
        
        // Answer question if textfield isnt empty
        if let answer = answerTextField.text {
            test.answerCurrentQuestion(with: answer, kanaToRomajiOrRomajiToKana: true, score: true)
            }

        // Clean textfield
        answerTextField.text = ""
        
        // If answer is correct
        if test.correctAnswer == true {
            // Haptic feedback correct answer
            generator.notificationOccurred(.success)
            
            // Change display settings for correct answer
            annotationAnswer.text = NSLocalizedString("GoodAnswer", comment: "")
            annotationAnswer.textColor = .green
            annotationAnswer.alpha = 1
            
            // Play sound correct answer
            playSound(sound: "Correct Beep", ext: "mp3")
            
            // animation for correct answer
            UIView.animate(withDuration: 1.0) {
                self.annotationAnswer.alpha = 0
                self.kana.alpha = 0
            }
            
            // Move to another part of lesson
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.nextPartLesson()
            }
            
            // If answer is incorrect
        } else {
            // Auto hide keyboard
            answerTextField.resignFirstResponder()
            // Haptic feedback wrong answer
            generator.notificationOccurred(.error)
            
            // Change display settings for wrong answer
            annotationAnswer.text = NSLocalizedString("WrongAnswer", comment: "")
            annotationAnswer.textColor = .red
            annotationAnswer.alpha = 1
            continueButton.alpha = 1
            correction.alpha = 1
            
            // Play sound wrong answer
            playSound(sound: "Wrong Beep", ext: "mp3")
            
            // animation for wrong answer
            UIView.animate(withDuration: 2.0) {
                self.annotationAnswer.alpha = 0
            }
        }
    }
    
    // Move to another part of lesson
    private func nextPartLesson() {
        switch currentLesson.state {
        case .play:
            if currentLesson.partType == "Test" {
                var randomInt: Int
                randomInt = Int.random(in: 0...1)
                if randomInt == 0 {
                    newQuestion()
                } else {
                    performSegue(withIdentifier: "segueTestToTestRomaji", sender: self)
                }
            } else if currentLesson.partType == "Learn" {
                performSegue(withIdentifier: "unwindToLessonLearn", sender: self)
            }
        case .end:
            performSegue(withIdentifier: "segueLessonTestToEnd", sender: self)
        }
    }
}
