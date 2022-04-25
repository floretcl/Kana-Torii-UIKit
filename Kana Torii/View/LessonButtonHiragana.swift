//
//  LessonButtonHiragana.swift
//  Kana Torii
//
//  Created by clément floret on 25/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class LessonButtonHiragana: UIButton {
    
    //Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        //rounded corners
        layer.cornerRadius = 20

        layer.borderColor = UIColor(red: 255/255, green: 168/255, blue: 62/255, alpha: 1).cgColor

        layer.borderWidth = 5
        
        //Text color
        setTitleColor(UIColor(red: 255/255, green: 168/255, blue: 62/255, alpha: 1), for: .normal)
        
        //Padding
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        
    }
}
