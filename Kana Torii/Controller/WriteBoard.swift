//
//  WriteBoard.swift
//  Kana Torii
//
//  Created by Clément FLORET on 13/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class WriteBoard: UIViewController {
    
    // MARK: - Properties
    var hiraganaOrKatakana: String!
    var detail: Detail!
    
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
    @IBOutlet weak var kanaLabel: UILabel!
    @IBOutlet weak var viewWriteBoard: UIView!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var linesImage: UIImageView!
    @IBOutlet weak var buttonPenSmaller: UIButton!
    @IBOutlet weak var buttonPenLarger: UIButton!
    @IBOutlet weak var buttonPrevious: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    // MARK: - Actions
    @IBAction func didTapButtonPenSmaller() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            brushWidth = 7.0
        } else if screenHeight >= 667 && screenHeight < 736 {
            brushWidth = 10.0
        } else if screenHeight >= 736 && screenHeight < 812 {
            brushWidth = 10.0
        } else if screenHeight >= 812 && screenHeight < 896 {
            brushWidth = 10.0
        } else if screenHeight >= 896 {
            brushWidth = 10.0
        }
        buttonPenSmaller.alpha = 0.5
        buttonPenLarger.alpha = 1
    }
    @IBAction func didTapButtonPenLarger() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            brushWidth = 10.0
        } else if screenHeight >= 667 && screenHeight < 736 {
            brushWidth = 15.0
        } else if screenHeight >= 736 && screenHeight < 812 {
            brushWidth = 17.0
        } else if screenHeight >= 812 && screenHeight < 896 {
            brushWidth = 20.0
        } else if screenHeight >= 896 {
            brushWidth = 20.0
        }
        buttonPenLarger.alpha = 0.5
        buttonPenSmaller.alpha = 1
    }
    @IBAction func didTapButtonErase() {
        erase()
    }
    @IBAction func didTapButtonPrevious() {
        erase()
        goBackward()
    }
    @IBAction func didTapButtonNext() {
        erase()
        goForward()
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonNext()
        
        setView()
        setBrushWidth()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindWriteboardToDetailKana" {
            let detailVC = segue.destination as! DetailKana
            detailVC.detail = detail
        }
    }
}

// MARK: - Extensions

extension WriteBoard {
        
    // Fix problem with display of button next in storyboard
    private func setButtonNext() {
        buttonNext.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        buttonNext.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        buttonNext.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    // Set display view
    private func setView() {
        kanaLabel.text = detail.kana + " " + detail.romaji
        linesImage.image = detail.linesImage
        
        if yoonRomaji.contains(detail.romaji.lowercased()) {
            buttonPenSmaller.alpha = 0.5
            buttonPenLarger.alpha = 1
        } else {
            buttonPenLarger.alpha = 0.5
            buttonPenSmaller.alpha = 1
        }
    }
    
    // Set Brush width by type
    private func setBrushWidth() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            if yoonRomaji.contains(detail.romaji.lowercased()) {
                brushWidth = 5.0
            } else {
                brushWidth = 10.0
            }
        } else if screenHeight >= 667 && screenHeight < 736 {
            if yoonRomaji.contains(detail.romaji.lowercased()) {
                brushWidth = 10.0
            } else {
                brushWidth = 15.0
            }
        } else if screenHeight >= 736 && screenHeight < 812 {
            if yoonRomaji.contains(detail.romaji.lowercased()) {
                brushWidth = 10.0
            } else {
                brushWidth = 17.0
            }
        } else if screenHeight >= 812 && screenHeight < 896 {
            if yoonRomaji.contains(detail.romaji.lowercased()) {
                brushWidth = 10.0
            } else {
                brushWidth = 20.0
            }
        } else if screenHeight >= 896 {
            if yoonRomaji.contains(detail.romaji.lowercased()) {
                brushWidth = 10.0
            } else {
                brushWidth = 20.0
            }
        }
    }
}

extension WriteBoard {
    
    // Set previous kana to display
    private func goBackward() {
        if hiraganaOrKatakana == "hiragana" {
            var index: Int = hiragana.firstIndex(of: detail.kana)!
            if index <= 0 {
                index = hiragana.count - 1
            } else {
                index -= 1
            }
            let newKana = hiragana[index]
            detail = Detail(romaji: hiraganaAllToRomaji[newKana]!, kana: newKana, linesImage:  UIImage(imageLiteralResourceName: linesHiraganaAllNameFile[newKana]!))
        } else {
            var index: Int = katakana.firstIndex(of: detail.kana)!
            if index <= 0 {
                index = katakana.count - 1
            } else {
                index -= 1
            }
            let newKana = katakana[index]
            detail = Detail(romaji: katakanaAllToRomaji[newKana]!, kana: newKana, linesImage: UIImage(imageLiteralResourceName: linesKatakanaAllNameFile[newKana]!))
        }
        setView()
        setBrushWidth()
    }
    
    // Set next kana to display
    private func goForward() {
        if hiraganaOrKatakana == "hiragana" {
            var index: Int = hiragana.firstIndex(of: detail.kana)!
            if index >= hiragana.count - 1 {
                index = 0
            } else {
                index += 1
            }
            let newKana = hiragana[index]
            detail = Detail(romaji: hiraganaAllToRomaji[newKana]!, kana: newKana, linesImage: UIImage(imageLiteralResourceName: linesHiraganaAllNameFile[newKana]!))
            
        } else if hiraganaOrKatakana == "katakana" {
            var index: Int = katakana.firstIndex(of: detail.kana)!
            if index >= katakana.count - 1{
                index = 0
            } else {
                index += 1
            }
            let newKana = katakana[index]
            detail = Detail(romaji: katakanaAllToRomaji[newKana]!, kana: newKana, linesImage: UIImage(imageLiteralResourceName: linesKatakanaAllNameFile[newKana]!))
            
        }
        setView()
        setBrushWidth()
    }
}

extension WriteBoard {

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
