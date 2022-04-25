//
//  KanaChartButton.swift
//  Kana Torii
//
//  Created by clément floret on 27/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class KanaChartButton: UIButton {
    
    //Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //Rounded corners
        layer.cornerRadius = 20

        layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor

        layer.borderWidth = 1
        
        //Padding
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
    }

}
