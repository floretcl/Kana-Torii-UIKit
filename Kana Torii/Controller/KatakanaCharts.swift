//
//  KatakanaCharts.swift
//  Kana Torii
//
//  Created by clément floret on 25/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class KatakanaCharts: UIViewController {
    
    // MARK: - Properties
    var hiraganaOrKatakana: String! = "katakana"
    var kanaChoice: String!
    
    // MARK: - Outlets
    @IBOutlet weak var collectionViewGojuon: UICollectionView!
    @IBOutlet weak var collectionViewHandakuon: UICollectionView!
    @IBOutlet weak var collectionViewYoon: UICollectionView!

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionViewGojuon.reloadData()
        collectionViewHandakuon.reloadData()
        collectionViewYoon.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailKana" {
            if let detailKanaVC = segue.destination as? DetailKana {
                detailKanaVC.hiraganaOrKatakana = hiraganaOrKatakana
                detailKanaVC.kanaChoice = kanaChoice
            }
        }
    }
}

// MARK: - Extensions

extension KatakanaCharts: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewGojuon {
            return ChartService.shared.chartKatakanaOne.count
        } else if collectionView == collectionViewHandakuon {
            return ChartService.shared.chartKatakanaTwo.count
        } else {
            return ChartService.shared.chartKatakanaThree.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewGojuon {
            if indexPath.row <= 4 {
                guard let cell = collectionViewGojuon.dequeueReusableCell(withReuseIdentifier: "ChartCellHeaderKatakanaGojuon", for: indexPath) as? HeaderChartViewCell else {
                    return UICollectionViewCell()
                }
                // Configure the cell
                let chart: Chart
                chart = ChartService.shared.chartKatakanaOne[indexPath.item]
                cell.setChartCell(with: chart.label)
                
                return cell
            } else {
                guard let cell = collectionViewGojuon.dequeueReusableCell(withReuseIdentifier: "ChartCellKatakanaGojuon", for: indexPath) as? MyKanaCollectionViewCell else {
                    return UICollectionViewCell()
                }
                // Configure the cell
                let chart: Chart
                chart = ChartService.shared.chartKatakanaOne[indexPath.item]
                cell.setChartCell(with: chart.label, romaji: chart.labelromaji)
                cell.delegate = self
                return cell
            }

        } else if collectionView == collectionViewHandakuon {
            if indexPath.row <= 4 {
                guard let cell = collectionViewHandakuon.dequeueReusableCell(withReuseIdentifier: "ChartCellHeaderKatakanaHandakuon", for: indexPath) as? HeaderChartViewCell else {
                    return UICollectionViewCell()
                }
                // Configure the cell
                let chart: Chart
                chart = ChartService.shared.chartKatakanaTwo[indexPath.item]
                cell.setChartCell(with: chart.label)
                
                return cell
            } else {
                guard let cell = collectionViewHandakuon.dequeueReusableCell(withReuseIdentifier: "ChartCellKatakanaHandakuon", for: indexPath) as? MyKanaCollectionViewCell else {
                    return UICollectionViewCell()
                }
                // Configure the cell
                let chart: Chart
                chart = ChartService.shared.chartKatakanaTwo[indexPath.item]
                cell.setChartCell(with: chart.label, romaji: chart.labelromaji)
                cell.delegate = self

                return cell
            }
        } else {
            if indexPath.row <= 2 {
                guard let cell = collectionViewYoon.dequeueReusableCell(withReuseIdentifier: "ChartCellHeaderKatakanaYoon", for: indexPath) as? HeaderChartViewCell else {
                    return UICollectionViewCell()
                }
                // Configure the cell
                let chart: Chart
                chart = ChartService.shared.chartKatakanaThree[indexPath.item]
                cell.setChartCell(with: chart.label)
                
                return cell
            } else {
                guard let cell = collectionViewYoon.dequeueReusableCell(withReuseIdentifier: "ChartCellKatakanaYoon", for: indexPath) as? MyKanaCollectionViewCell else {
                    return UICollectionViewCell()
                }
                // Configure the cell
                let chart: Chart
                chart = ChartService.shared.chartKatakanaThree[indexPath.item]
                cell.setChartCell(with: chart.label, romaji: chart.labelromaji)
                cell.delegate = self

                return cell
            }
        }
    }
}

extension KatakanaCharts: MyKanaCollectionViewCellDelegate {
    
    // When tap on a cell : go to detail page
    func didTapButton(with name: String) {
        kanaChoice = name
        performSegue(withIdentifier: "segueToDetailKana", sender: self)
    }
}
