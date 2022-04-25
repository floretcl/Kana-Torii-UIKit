//
//  HeaderChartViewCell.swift
//  Kana Torii
//
//  Created by Clément FLORET on 08/09/2020.
//

import UIKit

class HeaderChartViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    
    //Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //layer.borderWidth = 0
    }
}

extension HeaderChartViewCell {
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setChartCell(with text: String) {
        textLabel.text = text
    }
}
