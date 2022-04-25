//
//  AboutKana.swift
//  Kana Torii
//
//  Created by clément floret on 16/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class AboutKana: UIViewController {
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.text = NSLocalizedString("AboutKana", comment: "")
    }
    
}
