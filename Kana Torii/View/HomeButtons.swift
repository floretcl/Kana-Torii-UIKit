//
//  HomeButtons.swift
//  Kana Torii
//
//  Created by Clément FLORET on 14/09/2020.
//

import UIKit

class HomeButtons: UIButton {

    //Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //Rounded corners
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        //Padding
        contentEdgeInsets = UIEdgeInsets(top: 2.0, left: 4.0, bottom: 2.0, right: 4.0)
        
    }

}
