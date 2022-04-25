//
//  WriteBoardView.swift
//  Kana Torii
//
//  Created by clément floret on 17/07/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class WriteBoardView: UIView {

    //Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //Rounded corners
        layer.cornerRadius = 20

        layer.borderColor = UIColor.orange.cgColor

        layer.borderWidth = 2
        
        
    }
}
