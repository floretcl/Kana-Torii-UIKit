//
//  MyKanaYoonFlowLayout.swift
//  Kana Torii
//
//  Created by Clément FLORET on 09/09/2020.
//

import UIKit

class MyKanaYoonFlowLayout: UICollectionViewFlowLayout {

    private let cellHeight: CGFloat = 60
    private let maxColumn: Int = 3
        
    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumColumns = maxColumn + 1
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        
        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
        self.sectionInsetReference = .fromSafeArea
    }
}
