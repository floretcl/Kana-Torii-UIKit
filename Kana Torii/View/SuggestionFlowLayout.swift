//
//  SuggestionFlowLayout.swift
//  Kana Torii
//
//  Created by Clément FLORET on 15/09/2020.
//

import UIKit

class SuggestionFlowLayout: UICollectionViewFlowLayout {

    private var cellHeight: CGFloat = 55.0
    private let maxColumn: Int = 3
        
    override func prepare() {
        super.prepare()
        cellHeight = setHeight()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumColumns = maxColumn + 1
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        
        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
        self.sectionInsetReference = .fromSafeArea
    }

    // Resize height for different screen size
    private func setHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            return 55.0
        } else if screenHeight >= 667 && screenHeight < 736 {
            return 75.0
        } else if screenHeight >= 736 && screenHeight < 812 {
            return 85.0
        } else if screenHeight >= 812 && screenHeight < 896 {
            return 85.0
        } else {
            return 95.0
        }
    }
}
