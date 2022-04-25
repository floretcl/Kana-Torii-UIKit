//
//  MyLessonViewCell.swift
//  Kana Torii
//
//  Created by clément floret on 24/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit
import CoreData

protocol MyLessonViewCellDelegate: AnyObject {
    func didTapButton(with name: String)
}

class MyLessonViewCell: UITableViewCell {
    
    weak var delegate:  MyLessonViewCellDelegate?
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var kanaTitleCell: UILabel!
    @IBOutlet weak var lessonTitleCell: UILabel!
    @IBOutlet weak var textDetailCell: UILabel!
    @IBOutlet weak var redViewCell: UIView!
    @IBOutlet weak var buttonCell: UIButton!
    
    @IBAction func didTapButton(_ sender: Any) {
        if let label = lessonTitleCell.text {
            delegate?.didTapButton(with: label)
        }
    }
}

extension MyLessonViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(with textKanaTitle: String, textLessonTitle: String, textDetail: String, mode: String) {
        kanaTitleCell.text = textKanaTitle
        lessonTitleCell.text = textLessonTitle
        textDetailCell.text = textDetail
        imageCell.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        for lesson in LessonData.all {
            if (lesson.name == textLessonTitle) {
                if (lesson.type == textKanaTitle.lowercased()) && (lesson.mode == mode.lowercased()) && (lesson.completed == true) {
                    imageCell.tintColor = .systemGreen
                }
            }
        }
    }
}
