//
//  KanaQuiz.swift
//  Kana Torii
//
//  Created by Clément FLORET on 06/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit
import AudioToolbox
import GradientButtonSwift

class KanaQuiz: UIViewController {
    
    // MARK: - Properties
    var quizKana: Quiz!
    let generator = UINotificationFeedbackGenerator()
    
    // MARK: - Outlets
    @IBOutlet weak var titleTest: UILabel!
    @IBOutlet weak var kana: UILabel!
    @IBOutlet weak var romaji: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var annotationAnswer: UILabel!
    @IBOutlet weak var kanaNumber: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var correction: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    // MARK: - Actions
    @IBAction func submitContinueButton() {
        switch quizKana.state {
        case .play:
            newQuestion()
        case .end:
            performSegue(withIdentifier: "segueKanaToScore", sender: self)
        }
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelsSize()
        annotationAnswer.alpha = 0
        continueButton.alpha = 0
        answerTextField.delegate = self
        
        registerForKeyboardNotifications()
        newQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueKanaToScore" {
            let scoreQuizVC = segue.destination as! EndQuiz
            scoreQuizVC.quizKana = quizKana
            
        }
    }
}

// MARK: - Extensions
extension KanaQuiz: UITextFieldDelegate {
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

extension KanaQuiz {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        answerQuestion()
        return false
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

extension KanaQuiz {
    
    // Resize labels for different screen size
    private func setLabelsSize() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            kanaNumber.font = UIFont(name: kanaNumber.font.fontName, size: 12.0)
            titleTest.font = UIFont(name: titleTest.font.fontName, size: 16.0)
            kana.font = UIFont(name: kana.font.fontName, size: 63.0)
            correction.font = UIFont(name: correction.font.fontName, size: 24.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 14.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 14.0)
        } else if screenHeight >= 667 && screenHeight < 736 {
            kanaNumber.font = UIFont(name: kanaNumber.font.fontName, size: 14.0)
            titleTest.font = UIFont(name: titleTest.font.fontName, size: 18.0)
            kana.font = UIFont(name: kana.font.fontName, size: 120.0)
            correction.font = UIFont(name: correction.font.fontName, size: 28.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 16.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 16.0)
        } else if screenHeight >= 736 && screenHeight < 812 {
            kanaNumber.font = UIFont(name: kanaNumber.font.fontName, size: 16.0)
            titleTest.font = UIFont(name: titleTest.font.fontName, size: 20.0)
            kana.font = UIFont(name: kana.font.fontName, size: 145.0)
            correction.font = UIFont(name: correction.font.fontName, size: 31.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 18.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 18.0)
        } else if screenHeight >= 812 && screenHeight < 896 {
            kanaNumber.font = UIFont(name: kanaNumber.font.fontName, size: 16.0)
            titleTest.font = UIFont(name: titleTest.font.fontName, size: 20.0)
            kana.font = UIFont(name: kana.font.fontName, size: 150.0)
            correction.font = UIFont(name: correction.font.fontName, size: 33.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 18.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 18.0)
        } else {
            kanaNumber.font = UIFont(name: kanaNumber.font.fontName, size: 16.0)
            titleTest.font = UIFont(name: titleTest.font.fontName, size: 25.0)
            kana.font = UIFont(name: kana.font.fontName, size: 180.0)
            correction.font = UIFont(name: correction.font.fontName, size: 38.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 23.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 18.0)
        }
    }
    
    // Set display
    private func setView() {
        annotationAnswer.alpha = 0
        correction.alpha = 0
        continueButton.alpha = 0
        kana.alpha = 1
        correction.text = quizKana.currentRomaji
        kana.text = quizKana.currentKana
        if quizKana.hiraganaOrKatakana == .hiragana {
            titleTest.text = NSLocalizedString("TranslateHiraganaToRomaji", comment: "")
        } else {
            titleTest.text = NSLocalizedString("TranslateKatakanaToRomaji", comment: "")
        }
        kanaNumber.text = NSLocalizedString("Question", comment: "") + " \(quizKana.numberQuestion) / \(quizKana.numberTotalKana)"
        progressBar.progress = (Float(quizKana.numberQuestion) / Float(quizKana.numberTotalKana))
    }
    
    private func newQuestion() {
        // Auto display keyboard
        answerTextField.becomeFirstResponder()
        
        quizKana.correctAnswer = false
        setView()
    }
    
    
    private func answerQuestion() {
        
        // Answer question if textfield isnt empty
        if let answer = answerTextField.text {
            quizKana.answerCurrentQuestion(with: answer)
            }

        // Clean textfield
        answerTextField.text = ""
        
        // If user answer is correct
        if quizKana.correctAnswer == true {
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
            
            // Move to another part of quiz
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                switch self.quizKana.state {
                case .play:
                    self.newQuestion()
                case .end:
                    self.performSegue(withIdentifier: "segueKanaToScore", sender: self)
                }
            }
            // If user answer is wrong
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
}

