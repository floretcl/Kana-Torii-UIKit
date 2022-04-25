//
//  CircledButtonRed.swift
//  Kana Torii
//
//  Created by clément floret on 12/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class CircledButtonRed: UIButton {
    
    //Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //Border corners
        layer.cornerRadius = 5

        layer.borderColor = UIColor.red.cgColor

        layer.borderWidth = 2

        //Text color
        setTitleColor(UIColor.red, for: .normal)

        //Padding
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
    }
}
