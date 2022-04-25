//
//  MyKatakanaCollectionViewCell.swift
//  Kana Torii
//
//  Created by clément floret on 26/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

protocol MyKanaCollectionViewCellDelegate: AnyObject {
    func didTapButton(with name: String)
}

class MyKanaCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: MyKanaCollectionViewCellDelegate?
    
    @IBOutlet weak var textLabele: UILabel!
    @IBOutlet weak var romajiLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func didTapButton(_ sender: Any) {
        if let label = textLabele.text {
            if label != " " {
                delegate?.didTapButton(with: label)
            }
        }
    }
    
    //Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //Rounded corners
        layer.cornerRadius = 2

        layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1).cgColor

        layer.borderWidth = 2
    }
}

extension MyKanaCollectionViewCell {
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setChartCell(with text: String, romaji: String) {
        textLabele.text = text
        romajiLabel.text = romaji
    }
}
