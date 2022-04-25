//
//  EndQuiz.swift
//  Kana Torii
//
//  Created by clément floret on 17/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class EndQuiz: UIViewController {
    
    // MARK: - Properties
    var quizKana: Quiz!
    
    // MARK: - Outlets
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var annotationScore: UILabel!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setToolbarHidden(true, animated: true)
        showScore()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - Extensions

extension EndQuiz {
    
    private func showScore() {
        score.text = "\(quizKana.score) / \(quizKana.numberTotalKana)"
        let mark = Float(quizKana.score) / Float(quizKana.numberTotalKana)
        switch mark {
        case (20/20):
            annotationScore.text = NSLocalizedString("Perfect", comment: "")
        case (16/20)..<(20/20):
            annotationScore.text = NSLocalizedString("VeryGood", comment: "")
        case (13/20)..<(16/20):
            annotationScore.text = NSLocalizedString("Good", comment: "")
        case (10/20)..<(13/20):
            annotationScore.text = NSLocalizedString("GoodEnough", comment: "")
        case (8/20)..<(10/20):
            annotationScore.text = NSLocalizedString("NotTooBad", comment: "")
        case (0/20)..<(8/20):
            annotationScore.text = NSLocalizedString("Bad", comment: "")
        default:
            annotationScore.text = NSLocalizedString("Error", comment: "") + " \(mark * 20)"
        }
    }
}

