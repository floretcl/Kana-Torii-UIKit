//
//  CircledButtonYellow.swift
//  Kana Torii
//
//  Created by clément floret on 16/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class CircledButtonYellow: UIButton {
    
    //Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //Rounded corners
        layer.cornerRadius = 5

        layer.borderColor = #colorLiteral(red: 1, green: 0.8387047813, blue: 0.05212004859, alpha: 1)

        layer.borderWidth = 2

        //Text color
        setTitleColor(#colorLiteral(red: 1, green: 0.8387047813, blue: 0.05212004859, alpha: 1), for: .normal)

        //Padding
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
    }
}
