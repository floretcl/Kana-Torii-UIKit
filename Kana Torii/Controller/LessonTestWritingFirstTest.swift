//
//  LessonTestWritingFirstTest.swift
//  Kana Torii
//
//  Created by Clément FLORET on 13/08/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit
import AudioToolbox
import GradientButtonSwift
import CoreML

class LessonTestWritingFirstTest: UIViewController {

    // MARK: - Properties
    var currentLesson: Lesson!
    var test: Test!
    var detail: Detail = Detail(romaji: "", kana: "", linesImage: UIImage())
    var choiceKanaType: Lessons.KanaType!
    var arrayKana: [String] = []
    let generator = UINotificationFeedbackGenerator() // Feedback vibrations
    var hiraganaRecognizer: HiraganaRecognizer! // CoreML model
    var katakanaRecognizer: KatakanaRecognizer! // CoreML model
    
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
    var opacity: CGFloat = 1
    var swiped = false
    
    // MARK: - Outlets
    @IBOutlet weak var partLesson: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLesson: UILabel!
    @IBOutlet weak var romaji: UILabel!
    @IBOutlet weak var eraseButton: UIButton!
    @IBOutlet weak var thinButton: UIButton!
    @IBOutlet weak var thickButton: UIButton!
    @IBOutlet weak var buttonSubmit: GradientButton!
    @IBOutlet weak var buttonContinue: GradientButton!
    @IBOutlet weak var viewCorrection: UIView!
    @IBOutlet weak var seeCorrection: UIButton!
    @IBOutlet weak var switchCorrection: UISwitch!
    @IBOutlet weak var annotationCorrection: UILabel!
    @IBOutlet weak var viewWriteBoard: WriteBoardView!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var linesKana: UIImageView!
    @IBOutlet weak var subtitle: LabelRounded!
    @IBOutlet weak var labelButtonCorrection: UILabel!
    
    
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
    @IBAction func didTapSubmitButton(_ sender: Any) {
        var imageView: UIImageView?
        var prediction: String = ""
        
        switch traitCollection.userInterfaceStyle {
        case .dark: //dark mode
            imageView = ImageProcessor.invertColorsImage(forImageView: mainImageView!)
        default:
            imageView = mainImageView
        }
        
        if let imageToAnalyse = imageView?.image {
            if let predictionString = classLabel(forImage: imageToAnalyse) {
                prediction = predictionString
            }
        }
        switch traitCollection.userInterfaceStyle {
        case .dark: //dark mode
            mainImageView = ImageProcessor.invertColorsImage(forImageView: imageView!)
        default:
            break
        }
        
        if prediction == test.currentKana {
            answerQuestion(prediction: true)
        } else {
            alert(title: NSLocalizedString("AutoDetectionFailed", comment: ""), message: NSLocalizedString("ManualCorrection", comment: "") )
            setCorrectionView()
        }
    }
    @IBAction func didTapContinueButton(_ sender: Any) {
        answerQuestion(prediction: false)
    }
    @IBAction func touchUpCorrectionButton(_ sender: Any) {
        linesKana.alpha = 0
        mainImageView.alpha = 1
        viewCorrection.alpha = 1
    }

    @IBAction func touchDownCorrectionButton(_ sender: Any) {
        linesKana.alpha = 1
        mainImageView.alpha = 0
        viewCorrection.alpha = 0
    }
    
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelsSize()
        setLessonTitle()
        newQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let mlconfiguration = MLModelConfiguration()
        if test.hiraganaOrKatakana == .hiragana {
            do {
                try hiraganaRecognizer = HiraganaRecognizer(configuration: mlconfiguration)
            } catch {
                fatalError("Error to init model")
            }
        } else {
            do {
                try katakanaRecognizer = KatakanaRecognizer(configuration: mlconfiguration)
            } catch {
                fatalError("Error to init model")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        resetTempImage()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "segueFirstTestToTestWriting" {
             let testWritingVC = segue.destination as! LessonTestWriting
             testWritingVC.currentLesson = currentLesson
             testWritingVC.test = test
         } else if segue.identifier == "segueToLessonLearnWriting" {
            let testPracticeVC = segue.destination as! LessonLearnWriting
            testPracticeVC.currentLesson = currentLesson
         }
     }
}

// MARK: - Extensions
extension LessonTestWritingFirstTest {
    
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
    
    // Play kana reading
    private func readKana() {
        detail.readTextInJapanese(text: detail.kana)
    }
}

extension LessonTestWritingFirstTest {
    
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
    
    // Set Detail instance
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
        
        buttonSubmit.alpha = 1
        buttonContinue.alpha = 0
        viewCorrection.alpha = 0
        switchCorrection.alpha = 0
        annotationCorrection.alpha = 0
        romaji.alpha = 1
        linesKana.alpha = 0
        
        switchCorrection.isOn = false

        partLesson.text = NSLocalizedString("Part", comment: "") + " \(currentLesson.currentPart) / \(currentLesson.totalParts)"
        progressBar.progress = (Float(currentLesson.currentPart) / Float(currentLesson.totalParts))
    }
    
    private func setCorrectionView() {
        buttonSubmit.alpha = 0
        buttonContinue.alpha = 1
        viewCorrection.alpha = 1
        seeCorrection.alpha = 1
        switchCorrection.alpha = 1
        annotationCorrection.alpha = 1
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
    
}

extension LessonTestWritingFirstTest {
    
    private func newQuestion() {
        
        test.correctAnswer = false
        setView()
        setBrushWidth()
        readKana()
        setDetail()
        currentLesson.nextPart()
    }
    
    private func answerQuestion(prediction: Bool) {
        
        var answer: String
        if (switchCorrection.isOn || prediction == true) {
            answer = test.currentKana
        } else {
            answer = ""
        }
        // Answer question
        test.answerCurrentQuestion(with: answer, kanaToRomajiOrRomajiToKana: false, score: false)
        
        // If user answer is correct
        if test.correctAnswer == true {
            // Haptic feedback correct answer
            generator.notificationOccurred(.success)
            
            // Play sound correct answer
            playSound(sound: "Correct Beep", ext: "mp3")
            
            UIView.animate(withDuration: 1.0) {
                self.romaji.alpha = 0
            }
            // If user answer is wrong
        } else {
            // Haptic feedback wrong answer
            generator.notificationOccurred(.error)
            
            // Play sound wrong answer
            playSound(sound: "Wrong Beep", ext: "mp3")
        }
        // Move to another part of lesson
        let seconds = 0.3
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            self.erase()
            switch self.currentLesson.state {
            case .play:
                self.alertIfStartNotedTest()
                if self.currentLesson.partType == "Test" {
                    self.createTestInstance()
                    self.performSegue(withIdentifier: "segueFirstTestToTestWriting", sender: self)
                } else if self.currentLesson.partType == "Learn" {
                    self.performSegue(withIdentifier: "segueToLessonLearnWriting", sender: self)
                }
            case .end:
                break
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
        test = Test(hiraganaOrKatakana: hiraganaOrKatakana, arrayKana: arrayKana, allKana: currentLesson.kanaArray )
    }
    
    // display alert if user start noted tests
    private func alertIfStartNotedTest() {
        if currentLesson.EndOfTests(reading: false) {
            let alert = UIAlertController(title: NSLocalizedString("Note", comment: ""), message: NSLocalizedString("EndOfLearning", comment: ""), preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in 
                if self.currentLesson.partType == "Test" {
                    self.createTestInstance()
                    self.performSegue(withIdentifier: "segueFirstTestToTestWriting", sender: self)
                }
            }
            alert.view.tintColor = #colorLiteral(red: 1, green: 0.4045273066, blue: 0, alpha: 1)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension LessonTestWritingFirstTest {
    
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
    
    private func fillImageView(imageView : UIImageView) {
        UIGraphicsBeginImageContext(viewWriteBoard.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
          return
        }
        imageView.image?.draw(in: viewWriteBoard.bounds)
        switch traitCollection.userInterfaceStyle {
        case .dark: //dark mode
            context.setFillColor(UIColor.black.cgColor)
        default:
            context.setFillColor(UIColor.white.cgColor)
        }
        context.fill(viewWriteBoard.bounds)
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    private func clearTempImage() {
        tempImageView.image = nil
    }
    
    private func resetTempImage() {
        clearTempImage()
        fillImageView(imageView: tempImageView)
    }
    
    private func erase() {
        resetTempImage()
        mainImageView.image = nil
    }
}

extension LessonTestWritingFirstTest {
    func classLabel(forImage: UIImage) -> String? {
        if let pixelbuffer = ImageProcessor.pixelBuffer(forImage: forImage.cgImage!) {
            if test.hiraganaOrKatakana == .hiragana {
                guard let prediction = try? hiraganaRecognizer.prediction(image: pixelbuffer)
                else {
                    fatalError("Unexpected runtime error.")
                }
                return prediction.classLabel
            } else {
                guard let prediction = try? katakanaRecognizer.prediction(image: pixelbuffer)
                else {
                    fatalError("Unexpected runtime error.")
                }
                return prediction.classLabel
            }
        }
        return nil
    }
    
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path.first!
    }
}
