//
//  KanaQuizKanaMCQ.swift
//  Kana Torii
//
//  Created by Clément FLORET on 28/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit
import AudioToolbox
import GradientButtonSwift

class KanaQuizKanaMCQ: UIViewController {
    
    
    // MARK: - Properties
    var quizKana: Quiz!
    var detail: Detail = Detail(romaji: "", kana: "", linesImage: UIImage())
    let generator = UINotificationFeedbackGenerator()
    
    // MARK: - Outlets
    @IBOutlet weak var titleTest: UILabel!
    @IBOutlet weak var kana: UILabel!
    @IBOutlet weak var annotationAnswer: UILabel!
    @IBOutlet weak var kanaNumber: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var correction: CorrectionLabel!
    @IBOutlet weak var suggestionCollection: UICollectionView!
    @IBOutlet weak var continueButton: GradientButton!
    
    // MARK: - Actions
    @IBAction func submitCorrectionButton(_ sender: Any) {
        switch self.quizKana.state {
        case .play:
                self.newQuestion()
        case .end:
                self.performSegue(withIdentifier:"segueKanaMCQToScore", sender: self)
        }
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelsSize()
        self.annotationAnswer.alpha = 0
        newQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        suggestionCollection.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueKanaMCQToScore" {
            let scoreQuizRomajiVC = segue.destination as! EndQuiz
            scoreQuizRomajiVC.quizKana = quizKana
            
        }
    }
}

// MARK: - Extensions

extension KanaQuizKanaMCQ {
    
    private func playSound(sound: String, ext: String) {
        if let soundURL = Bundle.main.url(forResource: sound, withExtension: ext) {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);
        }
    }
}

extension KanaQuizKanaMCQ {
    
    // Resize labels for different screen size
    private func setLabelsSize() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            kanaNumber.font = UIFont(name: kanaNumber.font.fontName, size: 12.0)
            titleTest.font = UIFont(name: titleTest.font.fontName, size: 16.0)
            kana.font = UIFont(name: kana.font.fontName, size: 60.0)
            correction.font = UIFont(name: correction.font.fontName, size: 23.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 14.0)
        } else if screenHeight >= 667 && screenHeight < 736 {
            kanaNumber.font = UIFont(name: kanaNumber.font.fontName, size: 14.0)
            titleTest.font = UIFont(name: titleTest.font.fontName, size: 18.0)
            kana.font = UIFont(name: kana.font.fontName, size: 70.0)
            correction.font = UIFont(name: correction.font.fontName, size: 34.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 16.0)
        } else if screenHeight >= 736 && screenHeight < 812 {
            kanaNumber.font = UIFont(name: kanaNumber.font.fontName, size: 16.0)
            titleTest.font = UIFont(name: titleTest.font.fontName, size: 20.0)
            kana.font = UIFont(name: kana.font.fontName, size: 90.0)
            correction.font = UIFont(name: correction.font.fontName, size: 38.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 18.0)
        } else if screenHeight >= 812 && screenHeight < 896 {
            kanaNumber.font = UIFont(name: kanaNumber.font.fontName, size: 16.0)
            titleTest.font = UIFont(name: titleTest.font.fontName, size: 20.0)
            kana.font = UIFont(name: kana.font.fontName, size: 110.0)
            correction.font = UIFont(name: correction.font.fontName, size: 42.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 18.0)
        } else if screenHeight >= 896 {
            kanaNumber.font = UIFont(name: kanaNumber.font.fontName, size: 16.0)
            titleTest.font = UIFont(name: titleTest.font.fontName, size: 22.0)
            kana.font = UIFont(name: kana.font.fontName, size: 120.0)
            correction.font = UIFont(name: correction.font.fontName, size: 46.0)
            annotationAnswer.font = UIFont(name: annotationAnswer.font.fontName, size: 20.0)
        }
    }
    
    // Set display
    private func setView() {
        annotationAnswer.alpha = 0
        correction.alpha = 0
        continueButton.alpha = 0
        suggestionCollection.alpha = 1
        kana.alpha = 1
        correction.text = quizKana.currentRomaji
        suggestionCollection.reloadData()
        kana.text = quizKana.currentKana
        if quizKana.hiraganaOrKatakana == .hiragana {
            titleTest.text = NSLocalizedString("FindCorrectRomajiForHiragana", comment: "")
        } else {
            titleTest.text = NSLocalizedString("FindCorrectRomajiForKatakana", comment: "")
        }
        kanaNumber.text = NSLocalizedString("Question", comment: "") + " \(quizKana.numberQuestion) / \(quizKana.numberTotalKana)"
        progressBar.progress = (Float(quizKana.numberQuestion) / Float(quizKana.numberTotalKana))
    }
    
    private func newQuestion() {
        
        quizKana.correctAnswer = false
        setView()
    }
    
    
    private func answerQuestion(with name: String, cell: SuggestionCollectionViewCell) {
        
        // Answer question
        quizKana.answerCurrentQuestion(with: name)
        
        // If user answer is correct
        if quizKana.correctAnswer == true {
            // Haptic feedback correct answer
            generator.notificationOccurred(.success)
            
            // Change display settings for correct answer
            annotationAnswer.text = NSLocalizedString("GoodAnswer", comment: "")
            annotationAnswer.textColor = .green
            annotationAnswer.alpha = 1
            cell.setColorToGreen()
            
            // Play sound correct answer
            playSound(sound: "Correct Beep", ext: "mp3")
            
            // Animation for correct answer
            UIView.animate(withDuration: 1.0) {
                self.annotationAnswer.alpha = 0
                self.kana.alpha = 0
            }
            
            // Move to another part of quiz
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                // Put your code which should be executed with a delay here
                cell.setdefaultColor()
                switch self.quizKana.state {
                case .play:
                        self.newQuestion()
                case .end:
                        self.performSegue(withIdentifier: "segueKanaMCQToScore", sender: self)
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
            
            // Play sound wrong answer
            playSound(sound: "Wrong Beep", ext: "mp3")
            
            // Animation for wrong answer
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

extension KanaQuizKanaMCQ: UICollectionViewDataSource {


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
        cell.setSuggestionCell(with: suggestion.romaji)
        cell.delegate = self
        
        return cell
    }
    
    
    
}

extension KanaQuizKanaMCQ: SuggestionCollectionViewCellDelegate {
    
    // When tap on cell: answer question
    func didTapButton(with name: String, self cell: SuggestionCollectionViewCell) {
        answerQuestion(with: name, cell: cell)
    }
}
