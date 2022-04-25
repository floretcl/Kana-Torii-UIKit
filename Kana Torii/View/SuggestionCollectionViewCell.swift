//
//  SuggestionCollectionViewCell.swift
//  Kana Torii
//
//  Created by clément floret on 02/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

protocol SuggestionCollectionViewCellDelegate: AnyObject {
    func didTapButton(with name: String, self: SuggestionCollectionViewCell)
}

class SuggestionCollectionViewCell: UICollectionViewCell {
    
    static public let reuseID = "SuggestionCellKana"
    weak var delegate: SuggestionCollectionViewCellDelegate?
    
    @IBOutlet weak var kanaLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func didTapButton() {
        if let label = kanaLabel.text {
            delegate?.didTapButton(with: label, self: self)
        }
    }
    
    //Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //Rounded corners
        layer.cornerRadius = 2

        layer.borderColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.4).cgColor

        layer.borderWidth = 2
        
    }
}

extension SuggestionCollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabelsSize()
    }
    func setColorToGreen() {
        button.backgroundColor = UIColor.green
        kanaLabel.textColor = UIColor.white
    }
    func setColorToRed() {
        button.backgroundColor = UIColor.red
        kanaLabel.textColor = UIColor.white
    }
    func setdefaultColor() {
        button.backgroundColor = UIColor.clear
        kanaLabel.textColor = nil
    }
    func setSuggestionCell(with kana: String) {
        kanaLabel.text = kana
    }
    
    // Resize labels for different screen size
    private func setLabelsSize() {
        let screenWidth = UIScreen.main.bounds.width
        if screenWidth < 375 {
            kanaLabel.font = UIFont(name: kanaLabel.font.fontName, size: 23.0)
        } else if screenWidth >= 375 && screenWidth < 414 {
            kanaLabel.font = UIFont(name: kanaLabel.font.fontName, size: 28.0)
        } else if screenWidth >= 414 {
            kanaLabel.font = UIFont(name: kanaLabel.font.fontName, size: 32.0)
        }
    }

}
