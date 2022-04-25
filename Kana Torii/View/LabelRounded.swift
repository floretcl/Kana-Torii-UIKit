//
//  LabelRounded.swift
//  Kana Torii
//
//  Created by clément floret on 16/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class LabelRounded: UILabel {

    //Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //Rounded corners
        layer.cornerRadius = 7
        layer.masksToBounds = true
        
    }

    /*override func drawText(in rect: CGRect) {
        //Padding
        let insets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        super.drawText(in: rect.inset(by: insets))
    }*/
}
