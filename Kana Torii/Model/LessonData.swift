//
//  LessonData.swift
//  Kana Torii
//
//  Created by Clément FLORET on 22/08/2020.
//

import Foundation
import CoreData

class LessonData: NSManagedObject {
    static var all: [LessonData] {
        let request: NSFetchRequest<LessonData> = LessonData.fetchRequest()
        guard let lessonsdt = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return lessonsdt
    }
}
