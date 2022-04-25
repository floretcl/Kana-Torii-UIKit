//
//  HomeQuiz.swift
//  Kana Torii
//
//  Created by clément floret on 16/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class HomeQuiz: UIViewController {
    
    // MARK: - Properties
    var quizKana: Quiz!
    var difficulty : Quiz.Difficulty {
        var mode: Quiz.Difficulty
        if selectorDifficulty.selectedSegmentIndex == 0 {
            mode = .easy
        } else {
            mode = .hard
        }
        return mode
    }
    var mode: Quiz.Mode {
        var mode: Quiz.Mode
        if selectorKanaToRomajiOrRomajiToKana.selectedSegmentIndex == 0 {
            mode = .romajiToKana
        } else {
            mode = .kanaToRomaji
        }
        return mode
    }
    var hiraganaOrKatakana: Quiz.HiraganaOrKatakana {
        var mode: Quiz.HiraganaOrKatakana
        if selectorKana.selectedSegmentIndex == 0 {
            mode = .hiragana
        } else {
            mode = .katakana
        }
        return mode
    }
    var kanaType: Quiz.TypeKana {
        var mode: Quiz.TypeKana?
        switch controlWichKana.selectedSegmentIndex {
        case 0:
            mode = .gojuon
        case 1:
            mode = .handakuon
        case 2:
            mode = .yoon
        default:
            break
        }
        return mode!
    }
    var stateSwitchAllKana: Bool {
        return switchWichKana.isOn
    }
    var feedbackGenerator: UISelectionFeedbackGenerator? = nil
    
    // MARK: - Outlets
    @IBOutlet weak var selectorDifficulty: UISegmentedControl!
    @IBOutlet weak var selectorKanaToRomajiOrRomajiToKana: UISegmentedControl!
    @IBOutlet weak var selectorKana: UISegmentedControl!
    @IBOutlet weak var switchWichKana: UISwitch!
    @IBOutlet weak var controlWichKana: UISegmentedControl!
    @IBOutlet weak var hiragana: UILabel!
    @IBOutlet weak var hiraganaGa: UILabel!
    @IBOutlet weak var hiraganaKya: UILabel!
    @IBOutlet weak var katakana: UILabel!
    @IBOutlet weak var katakanaGa: UILabel!
    @IBOutlet weak var katakanaKya: UILabel!
    
    // MARK: - Actions
    @IBAction func actionSelectorDifficulty(_ sender: Any) {
        feedbackGenerator?.selectionChanged()
    }
    @IBAction func actionSelectorMode(_ sender: Any) {
        feedbackGenerator?.selectionChanged()
    }
    @IBAction func submitOkButton() {
        createQuiz()
        if selectorKanaToRomajiOrRomajiToKana.selectedSegmentIndex == 0 {
            if selectorDifficulty.selectedSegmentIndex == 0 {
                performSegue(withIdentifier: "segueToRomajiMCQTest", sender: self)
            } else {
                performSegue(withIdentifier: "segueToRomajiTest", sender: self)
            }
        } else {
            if selectorDifficulty.selectedSegmentIndex == 0 {
                performSegue(withIdentifier: "segueToKanaMCQTest", sender: self)
            } else {
                performSegue(withIdentifier: "segueToKanaTest", sender: self)
            }
        }
    }
    
    @IBAction func actionSelectorKana() {
         if selectorKana.selectedSegmentIndex == 0 {
            selectorKanaToRomajiOrRomajiToKana.setTitle("a -> あ", forSegmentAt: 0)
            selectorKanaToRomajiOrRomajiToKana.setTitle("あ -> a", forSegmentAt: 1)
            if switchWichKana.isOn {
                hiragana.isHidden = false
                katakana.isHidden = true
                hiraganaGa.isHidden = true
                hiraganaKya.isHidden = true
                katakanaGa.isHidden = true
                katakanaKya.isHidden = true
            } else {
                actionSelectorWichKanaType()
            }
         } else {
            selectorKanaToRomajiOrRomajiToKana.setTitle("a -> ア", forSegmentAt: 0)
            selectorKanaToRomajiOrRomajiToKana.setTitle("ア -> a", forSegmentAt: 1)
             if switchWichKana.isOn {
                hiragana.isHidden = true
                katakana.isHidden = false
                hiraganaGa.isHidden = true
                hiraganaKya.isHidden = true
                katakanaGa.isHidden = true
                katakanaKya.isHidden = true
             } else {
                actionSelectorWichKanaType()
            }
        }
        feedbackGenerator?.selectionChanged()
    }

    @IBAction func actionSwitchAllKana() {
        if switchWichKana.isOn {
            controlWichKana.isEnabled = false
            
            if selectorKana.selectedSegmentIndex == 0 {
                    hiragana.isHidden = false
                    katakana.isHidden = true
                    hiraganaGa.isHidden = true
                    hiraganaKya.isHidden = true
                    katakanaGa.isHidden = true
                    katakanaKya.isHidden = true
            } else {
                    hiragana.isHidden = true
                    katakana.isHidden = false
                    hiraganaGa.isHidden = true
                    hiraganaKya.isHidden = true
                    katakanaGa.isHidden = true
                    katakanaKya.isHidden = true
            }
        } else {
            controlWichKana.isEnabled = true
            actionSelectorWichKanaType()
        }
        feedbackGenerator?.selectionChanged()
    }
    
    @IBAction func actionSelectorWichKanaType() {
        let stateControlWichKana = controlWichKana.selectedSegmentIndex
        
        if selectorKana.selectedSegmentIndex == 0 {
            switch stateControlWichKana {
            case 0:
                hiragana.isHidden = false
                katakana.isHidden = true
                hiraganaGa.isHidden = true
                hiraganaKya.isHidden = true
                katakanaGa.isHidden = true
                katakanaKya.isHidden = true
            case 1:
                hiragana.isHidden = true
                katakana.isHidden = true
                hiraganaGa.isHidden = false
                hiraganaKya.isHidden = true
                katakanaGa.isHidden = true
                katakanaKya.isHidden = true
            case 2:
                hiragana.isHidden = true
                katakana.isHidden = true
                hiraganaGa.isHidden = true
                hiraganaKya.isHidden = false
                katakanaGa.isHidden = true
                katakanaKya.isHidden = true
            default:
                break
            }
        } else {
            switch stateControlWichKana {
            case 0:
                hiragana.isHidden = true
                katakana.isHidden = false
                hiraganaGa.isHidden = true
                hiraganaKya.isHidden = true
                katakanaGa.isHidden = true
                katakanaKya.isHidden = true
            case 1:
                hiragana.isHidden = true
                katakana.isHidden = true
                hiraganaGa.isHidden = true
                hiraganaKya.isHidden = true
                katakanaGa.isHidden = false
                katakanaKya.isHidden = true
            case 2:
                hiragana.isHidden = true
                katakana.isHidden = true
                hiraganaGa.isHidden = true
                hiraganaKya.isHidden = true
                katakanaGa.isHidden = true
                katakanaKya.isHidden = false
            default:
                break
            }
        }
        feedbackGenerator?.selectionChanged()
    }
    
    @IBAction func unwindToHomeQuiz(segue:UIStoryboardSegue) { }
    
    // MARK: -  Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabelsSize()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Back", comment: ""), style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        feedbackGenerator = UISelectionFeedbackGenerator()
    }

    override func viewDidDisappear(_ animated: Bool) {
        feedbackGenerator = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToKanaTest" {
            let kanaTestVC = segue.destination as! KanaQuiz
            kanaTestVC.quizKana = quizKana
        } else if segue.identifier == "segueToRomajiMCQTest" {
            let kanaMCQTestRomajiVC = segue.destination as! KanaQuizRomajiMCQ
            kanaMCQTestRomajiVC.quizKana = quizKana
        } else if segue.identifier == "segueToKanaMCQTest" {
            let kanaMCQTestVC = segue.destination as! KanaQuizKanaMCQ
            kanaMCQTestVC.quizKana = quizKana
        } else if segue.identifier == "segueToRomajiTest" {
            let kanaTestRomajiVC = segue.destination as! KanaQuizWriting
            kanaTestRomajiVC.quizKana = quizKana
        }
    }
}

// MARK: - Extensions

extension HomeQuiz {
    
    // Resize labels for different screen size
    private func setLabelsSize() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            hiragana.font = UIFont(name: hiragana.font.fontName, size: 130.0)
            hiraganaGa.font = UIFont(name: hiraganaGa.font.fontName, size: 130.0)
            hiraganaKya.font = UIFont(name: hiraganaKya.font.fontName, size: 130.0)
            katakana.font = UIFont(name: katakana.font.fontName, size: 130.0)
            katakanaGa.font = UIFont(name: katakanaGa.font.fontName, size: 130.0)
            katakanaKya.font = UIFont(name: katakanaKya.font.fontName, size: 130.0)
        } else if screenHeight >= 667 && screenHeight < 736 {
            hiragana.font = UIFont(name: hiragana.font.fontName, size: 160.0)
            hiraganaGa.font = UIFont(name: hiraganaGa.font.fontName, size: 160.0)
            hiraganaKya.font = UIFont(name: hiraganaKya.font.fontName, size: 160.0)
            katakana.font = UIFont(name: katakana.font.fontName, size: 160.0)
            katakanaGa.font = UIFont(name: katakanaGa.font.fontName, size: 160.0)
            katakanaKya.font = UIFont(name: katakanaKya.font.fontName, size: 160.0)
        } else if screenHeight >= 736 && screenHeight < 812 {
            hiragana.font = UIFont(name: hiragana.font.fontName, size: 190.0)
            hiraganaGa.font = UIFont(name: hiraganaGa.font.fontName, size: 190.0)
            hiraganaKya.font = UIFont(name: hiraganaKya.font.fontName, size: 190.0)
            katakana.font = UIFont(name: katakana.font.fontName, size: 190.0)
            katakanaGa.font = UIFont(name: katakanaGa.font.fontName, size: 190.0)
            katakanaKya.font = UIFont(name: katakanaKya.font.fontName, size: 190.0)
        } else if screenHeight >= 812 && screenHeight < 896 {
            hiragana.font = UIFont(name: hiragana.font.fontName, size: 190.0)
            hiraganaGa.font = UIFont(name: hiraganaGa.font.fontName, size: 190.0)
            hiraganaKya.font = UIFont(name: hiraganaKya.font.fontName, size: 190.0)
            katakana.font = UIFont(name: katakana.font.fontName, size: 190.0)
            katakanaGa.font = UIFont(name: katakanaGa.font.fontName, size: 190.0)
            katakanaKya.font = UIFont(name: katakanaKya.font.fontName, size: 190.0)
        } else if screenHeight >= 896 {
            hiragana.font = UIFont(name: hiragana.font.fontName, size: 220.0)
            hiraganaGa.font = UIFont(name: hiraganaGa.font.fontName, size: 220.0)
            hiraganaKya.font = UIFont(name: hiraganaKya.font.fontName, size: 220.0)
            katakana.font = UIFont(name: katakana.font.fontName, size: 220.0)
            katakanaGa.font = UIFont(name: katakanaGa.font.fontName, size: 220.0)
            katakanaKya.font = UIFont(name: katakanaKya.font.fontName, size: 220.0)
        }
    }
    
    // Create quiz instance with all settings
    private func createQuiz() {
        quizKana = Quiz(difficulty: difficulty,mode: mode,hiraganaOrKatakana: hiraganaOrKatakana, all: stateSwitchAllKana, kanaType: kanaType)
    }
}
