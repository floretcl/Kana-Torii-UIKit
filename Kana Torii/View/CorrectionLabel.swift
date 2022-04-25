//
//  CorrectionLabel.swift
//  Kana Torii
//
//  Created by Clément FLORET on 06/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class CorrectionLabel: UILabel {
    
    //Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //Rounded corners
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        
    }
}
