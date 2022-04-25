//
//  DetailKana.swift
//  Kana Torii
//
//  Created by clément floret on 27/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class DetailKana: UIViewController {

    // MARK: - Properties
    var detail: Detail!
    var hiraganaOrKatakana: String!
    var kanaChoice: String!
    var titleKana: String?
    let screenWidth = UIScreen.main.bounds.width

    //MARK: - Outlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var frontView: UIView!
    
    @IBOutlet weak var titleKanaTypeLabelFront: LabelRounded!
    @IBOutlet weak var romajiLabelFront: UILabel!
    @IBOutlet weak var kanaLabelFront: UILabel!
    @IBOutlet weak var linesImageFront: UIImageView!
    
    @IBOutlet weak var titleKanaTypeLabelBack: LabelRounded!
    @IBOutlet weak var romajiLabelBack: UILabel!
    @IBOutlet weak var kanaLabelBack: UILabel!
    @IBOutlet weak var linesImageBack: UIImageView!
    
    //MARK: - Actions
    @IBAction func didTapListenButton(_ sender: Any) {
        detail.readTextInJapanese(text: detail.kana)
    }
    
    @IBAction func didTapWriteButton(_ sender: Any) {
        performSegue(withIdentifier: "segueDetailToWriteBoard", sender: self)
    }

    @IBAction func didTapBackwardButton(_ sender: Any) {
        goBackward()
    }
    
    @IBAction func didTapForwardButton(_ sender: Any) {
        goForward()
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            swipeDetailView(gesture: sender)
        case .ended, .cancelled:
            resetSwipeDetailView(gesture: sender)
            changeDetailView(gesture: sender)
        default:
            break
        }
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelSize()
        backView.transform = CGAffineTransform(translationX: -screenWidth, y: 0.0)
        setDetails(with: kanaChoice)
        setView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetailToWriteBoard" {
            if let writeboardVC = segue.destination as? WriteBoard {
                writeboardVC.hiraganaOrKatakana = hiraganaOrKatakana
                writeboardVC.detail = detail
            }
        }
    }
    
    @IBAction func unwindToDetailKana(_ unwindSegue: UIStoryboardSegue) {
        setView()
        kanaChoice = detail.kana
    }
}

//MARK: - Extensions

extension DetailKana {
    
    // Resize labels for different screen size
    private func setLabelSize() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            kanaLabelFront.font = UIFont(name: kanaLabelFront.font.fontName, size: 70.0)
            kanaLabelBack.font = UIFont(name: kanaLabelBack.font.fontName, size: 70.0)
            romajiLabelFront.font = UIFont(name: romajiLabelFront.font.fontName, size: 25.0)
            romajiLabelBack.font = UIFont(name: romajiLabelBack.font.fontName, size: 25.0)
        } else if screenHeight >= 667 && screenHeight < 736 {
            kanaLabelFront.font = UIFont(name: kanaLabelFront.font.fontName, size: 110.0)
            kanaLabelBack.font = UIFont(name: kanaLabelBack.font.fontName, size: 110.0)
            romajiLabelFront.font = UIFont(name: romajiLabelFront.font.fontName, size: 32.0)
            romajiLabelBack.font = UIFont(name: romajiLabelBack.font.fontName, size: 32.0)
        } else if screenHeight >= 736 && screenHeight < 812 {
            kanaLabelFront.font = UIFont(name: kanaLabelFront.font.fontName, size: 140.0)
            kanaLabelBack.font = UIFont(name: kanaLabelBack.font.fontName, size: 140.0)
            romajiLabelFront.font = UIFont(name: romajiLabelFront.font.fontName, size: 40.0)
            romajiLabelBack.font = UIFont(name: romajiLabelBack.font.fontName, size: 40.0)
        } else if screenHeight >= 812 && screenHeight < 896 {
            kanaLabelFront.font = UIFont(name: kanaLabelFront.font.fontName, size: 140.0)
            kanaLabelBack.font = UIFont(name: kanaLabelBack.font.fontName, size: 140.0)
            romajiLabelFront.font = UIFont(name: romajiLabelFront.font.fontName, size: 40.0)
            romajiLabelBack.font = UIFont(name: romajiLabelBack.font.fontName, size: 40.0)
        } else if screenHeight >= 896 {
            kanaLabelFront.font = UIFont(name: kanaLabelFront.font.fontName, size: 160.0)
            kanaLabelBack.font = UIFont(name: kanaLabelBack.font.fontName, size: 160.0)
            romajiLabelFront.font = UIFont(name: romajiLabelFront.font.fontName, size: 44.0)
            romajiLabelBack.font = UIFont(name: romajiLabelBack.font.fontName, size: 44.0)
        }
    }
    
    // Set Detail instance and title
    private func setDetails(with kana: String) {
        if hiraganaOrKatakana == "hiragana" {
            detail = Detail(romaji: hiraganaAllToRomaji[kana]!, kana: kana, linesImage: UIImage(imageLiteralResourceName: linesHiraganaAllNameFile[kana]!))
            titleKana = "Hiragana"
        } else {
            detail = Detail(romaji: katakanaAllToRomaji[kana]!, kana: kana, linesImage: UIImage(imageLiteralResourceName: linesKatakanaAllNameFile[kana]!))
            titleKana = "Katakana"
        }
    }
    
    // Set display of frontView
    private func setView() {
        titleKanaTypeLabelFront.text = titleKana
        kanaLabelFront.text = detail.kana
        romajiLabelFront.text = detail.romaji
        linesImageFront.image = detail.linesImage
    }
}

extension DetailKana {
    
    // Set previous kana to display
    private func goBackward() {
        var newKanaChoice: String
        if hiraganaOrKatakana == "hiragana" {
            var index = hiragana.firstIndex(of: kanaChoice)!
            if index <= 0 {
                index = hiragana.count - 1
            } else {
                index -= 1
            }
            newKanaChoice = hiragana[index]
        } else {
            var index = katakana.firstIndex(of: kanaChoice)!
            if index <= 0 {
                index = katakana.count - 1
            } else {
                index -= 1
            }
            newKanaChoice = katakana[index]
        }
        kanaChoice = newKanaChoice
        setDetails(with: kanaChoice)
        setView()
    }
    
    // Set next kana to display
    private func goForward() {
        var newKanaChoice: String
        if hiraganaOrKatakana == "hiragana" {
            var index = hiragana.firstIndex(of: kanaChoice)!
            if index >= hiragana.count - 1 {
                index = 0
            } else {
                index += 1
            }
            newKanaChoice = hiragana[index]
        } else {
            var index = katakana.firstIndex(of: kanaChoice)!
            if index >= katakana.count - 1{
                index = 0
            } else {
                index += 1
            }
            newKanaChoice = katakana[index]
        }
        kanaChoice = newKanaChoice
        setDetails(with: kanaChoice)
        setView()
    }
}

extension DetailKana {
    
    // Set swipe effect (start)
    private func swipeDetailView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: frontView)
        var positionBackView: CGFloat
        var kanaforBackView: String
        
        // if swipe to the left: set back view to next kana
        if translation.x < 0 {
            
            // If hiragana
            if hiraganaOrKatakana == "hiragana" {
                var index = hiragana.firstIndex(of: kanaChoice)!
                if index >= hiragana.count - 1 {
                    index = 0
                } else {
                    index += 1
                }
                // set back view
                kanaforBackView = hiragana[index]
                titleKanaTypeLabelBack.text = titleKana
                romajiLabelBack.text = hiraganaAllToRomaji[kanaforBackView]
                linesImageBack.image = UIImage(imageLiteralResourceName: linesHiraganaAllNameFile[kanaforBackView]!)
                // If katakana
            } else {
                var index = katakana.firstIndex(of: kanaChoice)!
                if index >= katakana.count - 1{
                    index = 0
                } else {
                    index += 1
                }
                //set back view
                kanaforBackView = katakana[index]
                titleKanaTypeLabelBack.text = titleKana
                romajiLabelBack.text = katakanaAllToRomaji[kanaforBackView]
                linesImageBack.image = UIImage(imageLiteralResourceName: linesKatakanaAllNameFile[kanaforBackView]!)
            }
            
            kanaLabelBack.text = kanaforBackView
            positionBackView = screenWidth
            // if swipe to the right: set back view to previous kana
        } else {
            if hiraganaOrKatakana == "hiragana" {
                var index = hiragana.firstIndex(of: kanaChoice)!
                if index <= 0 {
                    index = hiragana.count - 1
                } else {
                    index -= 1
                }
                // set back view
                kanaforBackView = hiragana[index]
                titleKanaTypeLabelBack.text = titleKana
                romajiLabelBack.text = hiraganaAllToRomaji[kanaforBackView]
                linesImageBack.image = UIImage(imageLiteralResourceName: linesHiraganaAllNameFile[kanaforBackView]!)
            } else {
                var index = katakana.firstIndex(of: kanaChoice)!
                if index <= 0 {
                    index = katakana.count - 1
                } else {
                    index -= 1
                }
                // set back view
                kanaforBackView = katakana[index]
                titleKanaTypeLabelBack.text = titleKana
                romajiLabelBack.text = katakanaAllToRomaji[kanaforBackView]
                linesImageBack.image = UIImage(imageLiteralResourceName: linesKatakanaAllNameFile[kanaforBackView]!)
            }
            
            kanaLabelBack.text = kanaforBackView
            positionBackView = -screenWidth
        }
        // swipe effect
        frontView.transform = CGAffineTransform(translationX: translation.x, y: 0.0)
        backView.transform = CGAffineTransform(translationX: translation.x + positionBackView, y: 0.0)
    }

    // Set end of swipe effect
    private func resetSwipeDetailView(gesture: UIPanGestureRecognizer) {
        var translationTransform: CGAffineTransform
        let translation = gesture.translation(in: frontView)
        if translation.x < 0 {
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
        } else {
            translationTransform = CGAffineTransform(translationX: screenWidth, y: 0)
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.frontView.transform = translationTransform
        })
        self.frontView.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
    }
    
    // Change display of frontView after swipe effect
    private func changeDetailView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: frontView)
        if translation.x < 0 {
            goForward()
        } else {
            goBackward()
        }
    }
}
