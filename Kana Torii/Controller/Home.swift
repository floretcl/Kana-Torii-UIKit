//
//  Home.swift
//  Kana Torii
//
//  Created by clément floret on 25/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class Home: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var homeImage: UIImageView!
    
    // MARK: - Actions
    @IBAction func unwindToHome(segue:UIStoryboardSegue) {
    }
    
    // Button Reset data : Reset lesson data from CoreData
    @IBAction func didTapResetData(_ sender: Any) {
        for lesson in LessonData.all {
            AppDelegate.viewContext.delete(lesson)
        }
        do {
            try AppDelegate.viewContext.save()
        } catch {
            fatalError("Error reset lesson data")
        }
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelsSize()
        overrideUserInterfaceStyle = .light
        createCharts()
    }
}

// MARK: - Extensions

extension Home {
    
    private func setLabelsSize() {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight < 667 {
            appTitle.font = UIFont(name: appTitle.font.fontName, size: 45.0)
            subTitle.font = UIFont(name: subTitle.font.fontName, size: 26.0)
        } else if screenHeight >= 667 && screenHeight < 736 {
            appTitle.font = UIFont(name: appTitle.font.fontName, size: 50.0)
            subTitle.font = UIFont(name: subTitle.font.fontName, size: 28.0)
        } else if screenHeight >= 736 {
            appTitle.font = UIFont(name: appTitle.font.fontName, size: 60.0)
            subTitle.font = UIFont(name: subTitle.font.fontName, size: 33.0)
        }
    }
    
    // Create Charts for Hiragana and Katakana pages
    private func createCharts() {
        for chart in Chart.chartHiraganaGojuon {
            ChartService.shared.addToHiraganaOne(chart: chart)
        }
        for chart in Chart.chartHiraganaDakuonHandakuon {
            ChartService.shared.addToHiraganaTwo(chart: chart)
        }
        for chart in Chart.chartHiraganaYoon {
            ChartService.shared.addToHiraganaThree(chart: chart)
        }
        for chart in Chart.chartKatakanaGojuon {
            ChartService.shared.addToKatakanaOne(chart: chart)
        }
        for chart in Chart.chartKatakanaDakuonHandakuon {
            ChartService.shared.addToKatakanaTwo(chart: chart)
        }
        for chart in Chart.chartKatakanaYoon {
            ChartService.shared.addToKatakanaThree(chart: chart)
        }
    }
}
