//
//  LessonTestWritingPractice.swift
//  Kana Torii
//
//  Created by clément floret on 01/08/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit
import AudioToolbox
import GradientButtonSwift

class LessonTestWritingPractice: UIViewController {

    // MARK: - Properties
    var currentLesson: Lesson!
    var test: Test!
    var detail: Detail = Detail(romaji: "", kana: "", linesImage: UIImage())
    var choiceKanaType: Lessons.KanaType!
    var arrayKana: [String] = []
    
    // To draw
    var lastPoint = CGPoint.zero
    var color = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
          return UIColor(white: 1, alpha: 1.0)
        default:
          return UIColor(white: 0, alpha: 1.0)
        }
      }
    var brushWidth: CGFloat?
    var opacity: CGFloat = 1.0
    var swiped = false

    // MARK: - Outlets
    @IBOutlet weak var partLesson: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLesson: UILabel!
    @IBOutlet weak var romaji: UILabel!
    @IBOutlet weak var eraseButton: UIButton!
    @IBOutlet weak var thinButton: UIButton!
    @IBOutlet weak var thickButton: UIButton!
    @IBOutlet weak var buttonContinue: GradientButton!
    @IBOutlet weak var viewWriteBoard: WriteBoardView!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var linesKana: UIImageView!
    @IBOutlet weak var subtitle: LabelRounded!
    
    
    //MARK: - Actions
    @IBAction func didTapEraseButton(_ sender: Any) {
        erase()
    }
    @IBAction func didTapThinButton(_ sender: Any) {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            brushWidth = 5.0
        } else if screenHeight >= 667 && screenHeight < 736 {
            brushWidth = 8.0
        } else if screenHeight >= 736 && screenHeight < 812 {
            brushWidth = 10.0
        } else if screenHeight >= 812 && screenHeight < 896 {
            brushWidth = 10.0
        } else if screenHeight >= 896 {
            brushWidth = 10.0
        }
        thinButton.alpha = 0.5
        thickButton.alpha = 1
    }
    @IBAction func didTapThickButton(_ sender: Any) {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            brushWidth = 8.0
        } else if screenHeight >= 667 && screenHeight < 736 {
            brushWidth = 12.0
        } else if screenHeight >= 736 && screenHeight < 812 {
            brushWidth = 14.0
        } else if screenHeight >= 812 && screenHeight < 896 {
            brushWidth = 16.0
        } else if screenHeight >= 896 {
            brushWidth = 18.0
        }
        thickButton.alpha = 0.5
        thinButton.alpha = 1
    }
    @IBAction func didTapContinueButton(_ sender: Any) {
        continuePractice()
    }
   
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelsSize()
        setLessonTitle()
        newPractice()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "segueTestPracticeToFirstTestWriting" {
             let firstTestVC = segue.destination as! LessonTestWritingFirstTest
             firstTestVC.currentLesson = currentLesson
             firstTestVC.test = test
             firstTestVC.choiceKanaType = choiceKanaType
             firstTestVC.arrayKana = arrayKana
         }
     }
}

// MARK: - Extensions

extension LessonTestWritingPractice {
    
    // Resize labels for different screen size
    private func setLabelsSize() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 12.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 16.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 16.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 25.0)
        } else if screenHeight >= 667 && screenHeight < 736 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 14.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 18.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 18.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 32.0)
        } else if screenHeight >= 736 && screenHeight < 812 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 16.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 20.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 20.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 40.0)
        } else if screenHeight >= 812 && screenHeight < 896 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 16.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 20.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 20.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 43.0)
        } else if screenHeight >= 896 {
            partLesson.font = UIFont(name: partLesson.font.fontName, size: 16.0)
            titleLesson.font = UIFont(name: titleLesson.font.fontName, size: 20.0)
            subtitle.font = UIFont(name: subtitle.font.fontName, size: 20.0)
            romaji.font = UIFont(name: romaji.font.fontName, size: 45.0)
        }
    }
    
    // Set detail instance
    private func setDetail() {
        detail = Detail(romaji: currentLesson.currentRomaji, kana: currentLesson.currentKana, linesImage: UIImage())
    }
    
    // Set lesson title
    private func setLessonTitle() {
        var kanaTypeTitle: String
        if currentLesson.hiraganaOrKatakana == .hiragana {
            kanaTypeTitle = "Hiragana"
        } else {
            kanaTypeTitle = "Katakana"
        }
        
        titleLesson.text = kanaTypeTitle + " " + currentLesson.title + NSLocalizedString("Writing", comment: "")
    }
    
    // Set display
    private func setView() {
        var image: String
        if currentLesson.hiraganaOrKatakana == .hiragana {
            image = linesHiraganaAllNameFile[currentLesson.currentKana]!
        } else {
            image = linesKatakanaAllNameFile[currentLesson.currentKana]!
        }
        romaji.text = currentLesson.currentRomaji
        linesKana.image = UIImage(named: image)
        
        let text = String(romaji.text!)
        if yoonRomaji.contains(text.lowercased()) {
            thinButton.alpha = 0.5
            thickButton.alpha = 1
        } else {
            thickButton.alpha = 0.5
            thinButton.alpha = 1
        }
        
        partLesson.text = NSLocalizedString("Part", comment: "") + " \(currentLesson.currentPart) / \(currentLesson.totalParts)"
        progressBar.progress = (Float(currentLesson.currentPart) / Float(currentLesson.totalParts))
    }
    
    // Set Brush width by type
    private func setBrushWidth() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            if yoonRomaji.contains(currentLesson.currentRomaji.lowercased()) {
                brushWidth = 5.0
            } else {
                brushWidth = 8.0
            }
        } else if screenHeight >= 667 && screenHeight < 736 {
            if yoonRomaji.contains(currentLesson.currentRomaji.lowercased()) {
                brushWidth = 8.0
            } else {
                brushWidth = 12.0
            }
        } else if screenHeight >= 736 && screenHeight < 812 {
            if yoonRomaji.contains(currentLesson.currentRomaji.lowercased()) {
                brushWidth = 10.0
            } else {
                brushWidth = 14.0
            }
        } else if screenHeight >= 812 && screenHeight < 896 {
            if yoonRomaji.contains(currentLesson.currentRomaji.lowercased()) {
                brushWidth = 12.0
            } else {
                brushWidth = 16.0
            }
        } else if screenHeight >= 896 {
            if yoonRomaji.contains(currentLesson.currentRomaji.lowercased()) {
                brushWidth = 12.0
            } else {
                brushWidth = 18.0
            }
        }
    }
    
    // Play kana reading
    private func readKana() {
        detail.readTextInJapanese(text: detail.kana)
    }
}

extension LessonTestWritingPractice {
    
    // New practice part
    private func newPractice() {
        setView()
        setBrushWidth()
        setDetail()
        readKana()
        currentLesson.nextPart()
    }
    
    
    
    // Continue : Move to another part of lesson
    private func continuePractice() {
        let seconds = 0.3
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            self.erase()
            if self.currentLesson.partType == "FirstTest" {
                self.createTestInstance()
                self.performSegue(withIdentifier: "segueTestPracticeToFirstTestWriting", sender: self)
            }
        }
    }
    
    // Create test instance for next view controllers
    private func createTestInstance() {
        var hiraganaOrKatakana: Test.HiraganaOrKatakana
        
        if choiceKanaType == .hiragana {
            hiraganaOrKatakana = .hiragana
        } else {
            hiraganaOrKatakana = .katakana
        }
        let arrayFirstTest = [(currentLesson.currentKana)]
        test = Test(hiraganaOrKatakana: hiraganaOrKatakana, arrayKana: arrayFirstTest, allKana: currentLesson.kanaArray )
    }
}

extension LessonTestWritingPractice {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      guard let touch = touches.first else {
        return
      }
      swiped = false
        lastPoint = touch.location(in: viewWriteBoard)
        
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
      UIGraphicsBeginImageContext(viewWriteBoard.frame.size)
      guard let context = UIGraphicsGetCurrentContext() else {
        return
      }
      tempImageView.image?.draw(in: viewWriteBoard.bounds)
        
      context.move(to: fromPoint)
      context.addLine(to: toPoint)

      context.setLineCap(.round)
      context.setBlendMode(.normal)
      context.setLineWidth(brushWidth!)
      context.setStrokeColor(color.cgColor)
      
      context.strokePath()
      
      tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
      tempImageView.alpha = opacity
      UIGraphicsEndImageContext()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
          guard let touch = touches.first else {
            return
          }

          swiped = true
          let currentPoint = touch.location(in: viewWriteBoard)
          drawLine(from: lastPoint, to: currentPoint)
            
          lastPoint = currentPoint
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
          if !swiped {
            // draw a single point
            drawLine(from: lastPoint, to: lastPoint)
          }
            
          // Merge tempImageView into mainImageView
          UIGraphicsBeginImageContext(mainImageView.frame.size)
          mainImageView.image?.draw(in: viewWriteBoard.bounds, blendMode: .normal, alpha: 1.0)
          tempImageView?.image?.draw(in: viewWriteBoard.bounds, blendMode: .normal, alpha: opacity)
          mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
            
          tempImageView.image = nil
    }
    
    private func erase() {
        mainImageView.image = nil
    }
}

