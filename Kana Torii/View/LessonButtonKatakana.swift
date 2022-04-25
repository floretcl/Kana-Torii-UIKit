//
//  LessonButtonKatakana.swift
//  Kana Torii
//
//  Created by clément floret on 25/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class LessonButtonKatakana: UIButton {
    
    //Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //Rounded corners
        layer.cornerRadius = 20

        layer.borderColor = UIColor(red: 255/255, green: 115/255, blue: 64/255, alpha: 1).cgColor

        layer.borderWidth = 5
        
        //Text color
        setTitleColor(UIColor(red: 255/255, green: 115/255, blue: 64/255, alpha: 1), for: .normal)
        
        //Padding
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        
    }
}
