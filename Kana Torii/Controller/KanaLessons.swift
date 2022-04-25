//
//  KanaLessons.swift
//  Kana Torii
//
//  Created by Clément FLORET on 23/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit

class KanaLessons: UIViewController {
    
    // MARK: - Properties
    var choiceKanaType: Lessons.KanaType!
    var lessonType: Lessons.LessonType!
    var currentLesson: Lesson!
    var arrayKana: [String]! = []
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Actions
    @IBAction func unwindToKanaLesson(segue:UIStoryboardSegue) {
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
         super.viewDidLoad()
     
     if (choiceKanaType == .hiragana && lessonType == .reading) {
         self.navigationItem.title = NSLocalizedString("HiraganaReadingLessons", comment: "")
     } else if (choiceKanaType == .katakana && lessonType == .reading) {
         self.navigationItem.title = NSLocalizedString("KatakanaReadingLessons", comment: "")
     } else if (choiceKanaType == .hiragana && lessonType == .writing) {
         self.navigationItem.title = NSLocalizedString("HiraganaWritingLessons", comment: "")
     } else if (choiceKanaType == .katakana && lessonType == .writing) {
         self.navigationItem.title = NSLocalizedString("KatakanaWritingLessons", comment: "")
     }
     
     }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
         tableView.reloadData()
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "segueToLessonLearn" {
             if let lessonLearnVC = segue.destination as? LessonLearn {
                 lessonLearnVC.currentLesson = currentLesson
                 lessonLearnVC.choiceKanaType = choiceKanaType
             }
         } else if segue.identifier == "segueToLessonWritingLearn" {
             if let lessonLearnWritingVC = segue.destination as? LessonLearnWriting {
                 lessonLearnWritingVC.currentLesson = currentLesson
                 lessonLearnWritingVC.choiceKanaType = choiceKanaType
             }
         }
     }
}


// MARK: - Extensions

extension KanaLessons {
    
    // Set kanaArray by lesson
    private func setKanaArray(with choiceLesson: String) -> [String] {
        var kanaArray: [String] = []
         if let kanaType = choiceKanaType {
            if kanaType == .hiragana {
                 switch choiceLesson {
                 case NSLocalizedString("Lesson", comment: "") + " 1":
                     kanaArray = lessonHiragana[0]
                 case NSLocalizedString("Lesson", comment: "") + " 2":
                     kanaArray = lessonHiragana[1]
                 case NSLocalizedString("Lesson", comment: "") + " 3":
                     kanaArray = lessonHiragana[2]
                 case NSLocalizedString("Lesson", comment: "") + " 4":
                     kanaArray = lessonHiragana[3]
                 case NSLocalizedString("Lesson", comment: "") + " 5":
                     kanaArray = lessonHiragana[4]
                 case NSLocalizedString("Lesson", comment: "") + " 6":
                     kanaArray = lessonHiragana[5]
                 case NSLocalizedString("Lesson", comment: "") + " 7":
                     kanaArray = lessonHiragana[6]
                 case NSLocalizedString("Lesson", comment: "") + " 8":
                     kanaArray = lessonHiragana[7]
                 case NSLocalizedString("Lesson", comment: "") + " 9":
                     kanaArray = lessonHiragana[8]
                 case NSLocalizedString("Lesson", comment: "") + " 10":
                     kanaArray = lessonHiragana[9]
                 case NSLocalizedString("Lesson", comment: "") + " 11":
                     kanaArray = lessonHiragana[10]
                 case NSLocalizedString("Lesson", comment: "") + " 12":
                     kanaArray = lessonHiragana[11]
                 case NSLocalizedString("Lesson", comment: "") + " 13":
                     kanaArray = lessonHiragana[12]
                 case NSLocalizedString("Lesson", comment: "") + " 14":
                     kanaArray = lessonHiragana[13]
                 case NSLocalizedString("Lesson", comment: "") + " 15":
                     kanaArray = lessonHiragana[14]
                 case NSLocalizedString("Lesson", comment: "") + " 16":
                     kanaArray = lessonHiragana[15]
                 case NSLocalizedString("Lesson", comment: "") + " 17":
                     kanaArray = lessonHiragana[16]
                 case NSLocalizedString("Lesson", comment: "") + " 18":
                     kanaArray = lessonHiragana[17]
                 case NSLocalizedString("Lesson", comment: "") + " 19":
                     kanaArray = lessonHiragana[18]
                 case NSLocalizedString("Lesson", comment: "") + " 20":
                     kanaArray = lessonHiragana[19]
                 case NSLocalizedString("Lesson", comment: "") + " 21":
                     kanaArray = lessonHiragana[20]
                 case NSLocalizedString("Lesson", comment: "") + " 22":
                     kanaArray = lessonHiragana[21]
                 case NSLocalizedString("Lesson", comment: "") + " 23":
                     kanaArray = lessonHiragana[22]
                 case NSLocalizedString("Lesson", comment: "") + " 24":
                     kanaArray = lessonHiragana[23]
                 case NSLocalizedString("Lesson", comment: "") + " 25":
                     kanaArray = lessonHiragana[24]
                 case NSLocalizedString("Lesson", comment: "") + " 26":
                     kanaArray = lessonHiragana[25]
                 default:
                     break
                }
                 
            } else if kanaType == .katakana {
                 switch choiceLesson {
                 case NSLocalizedString("Lesson", comment: "") + " 1":
                     kanaArray = lessonKatakana[0]
                 case NSLocalizedString("Lesson", comment: "") + " 2":
                     kanaArray = lessonKatakana[1]
                 case NSLocalizedString("Lesson", comment: "") + " 3":
                     kanaArray = lessonKatakana[2]
                 case NSLocalizedString("Lesson", comment: "") + " 4":
                     kanaArray = lessonKatakana[3]
                 case NSLocalizedString("Lesson", comment: "") + " 5":
                     kanaArray = lessonKatakana[4]
                 case NSLocalizedString("Lesson", comment: "") + " 6":
                     kanaArray = lessonKatakana[5]
                 case NSLocalizedString("Lesson", comment: "") + " 7":
                     kanaArray = lessonKatakana[6]
                 case NSLocalizedString("Lesson", comment: "") + " 8":
                     kanaArray = lessonKatakana[7]
                 case NSLocalizedString("Lesson", comment: "") + " 9":
                     kanaArray = lessonKatakana[8]
                 case NSLocalizedString("Lesson", comment: "") + " 10":
                     kanaArray = lessonKatakana[9]
                 case NSLocalizedString("Lesson", comment: "") + " 11":
                     kanaArray = lessonKatakana[10]
                 case NSLocalizedString("Lesson", comment: "") + " 12":
                     kanaArray = lessonKatakana[11]
                 case NSLocalizedString("Lesson", comment: "") + " 13":
                     kanaArray = lessonKatakana[12]
                 case NSLocalizedString("Lesson", comment: "") + " 14":
                     kanaArray = lessonKatakana[13]
                 case NSLocalizedString("Lesson", comment: "") + " 15":
                     kanaArray = lessonKatakana[14]
                 case NSLocalizedString("Lesson", comment: "") + " 16":
                     kanaArray = lessonKatakana[15]
                 case NSLocalizedString("Lesson", comment: "") + " 17":
                     kanaArray = lessonKatakana[16]
                 case NSLocalizedString("Lesson", comment: "") + " 18":
                     kanaArray = lessonKatakana[17]
                 case NSLocalizedString("Lesson", comment: "") + " 19":
                     kanaArray = lessonKatakana[18]
                 case NSLocalizedString("Lesson", comment: "") + " 20":
                     kanaArray = lessonKatakana[19]
                 case NSLocalizedString("Lesson", comment: "") + " 21":
                     kanaArray = lessonKatakana[20]
                 case NSLocalizedString("Lesson", comment: "") + " 22":
                     kanaArray = lessonKatakana[21]
                 case NSLocalizedString("Lesson", comment: "") + " 23":
                     kanaArray = lessonKatakana[22]
                 case NSLocalizedString("Lesson", comment: "") + " 24":
                     kanaArray = lessonKatakana[23]
                 case NSLocalizedString("Lesson", comment: "") + " 25":
                     kanaArray = lessonKatakana[24]
                 case NSLocalizedString("Lesson", comment: "") + " 26":
                    kanaArray = lessonKatakana[25]
                 default:
                     break
                 }
             }
         }
        return kanaArray
    }
    
    // Create Lesson instance for next view controllers
    private func createLesson(with kanaArray: [String], name: String) {
        
        var hiraganaOrKatakana: Lesson.HiraganaOrKatakana?
        var mode: Lesson.Mode?
        
        switch choiceKanaType {
        case .hiragana:
            hiraganaOrKatakana = .hiragana
        case .katakana:
            hiraganaOrKatakana = .katakana
        default:
            break
        }
        switch lessonType {
        case .reading:
            mode = .reading
        case .writing:
            mode = .writing
        default:
            break
        }
        
        currentLesson = Lesson(with: kanaArray, name: name, hiraganaOrKatakana: hiraganaOrKatakana!, mode: mode!)
    }
}

extension KanaLessons: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return Lessons.SectionName.gojuon.rawValue
        } else if section == 1 {
            return Lessons.SectionName.handakuon.rawValue
        } else {
            return Lessons.SectionName.yoon.rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if choiceKanaType == .hiragana {
                return LessonsService.shared.lessHiraganaOne.count
            } else {
                return LessonsService.shared.lessKatakanaOne.count
            }
        } else if section == 1 {
            if choiceKanaType == .hiragana {
                return LessonsService.shared.lessHiraganaTwo.count
            } else {
                return LessonsService.shared.lessKatakanaTwo.count
            }
        } else {
            if choiceKanaType == .katakana {
                return LessonsService.shared.lessHiraganaThree.count
            } else {
                return LessonsService.shared.lessKatakanaThree.count
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as? MyLessonViewCell else {
            return UITableViewCell()
        }
        
        let lessons: Lessons
        var kanaTitle: String {
            if choiceKanaType == .hiragana {
                return "Hiragana"
            } else {
                return "Katakana"
            }
        }
        var mode: String
        if lessonType == .reading {
            mode = "Reading"
        } else {
            mode = "Writing"
        }
        
        if indexPath.section == 0 {
            
            if choiceKanaType == .hiragana {
                lessons = LessonsService.shared.lessHiraganaOne[indexPath.row]
            } else {
                lessons = LessonsService.shared.lessKatakanaOne[indexPath.row]
            }
            cell.setCell(with: kanaTitle, textLessonTitle: lessons.name, textDetail: lessons.detail, mode: mode)
            
        } else if indexPath.section == 1 {
            if choiceKanaType == .hiragana {
                lessons = LessonsService.shared.lessHiraganaTwo[indexPath.row]
            } else {
                lessons = LessonsService.shared.lessKatakanaTwo[indexPath.row]
            }
            cell.setCell(with: kanaTitle, textLessonTitle: lessons.name, textDetail: lessons.detail, mode: mode)
            
        } else if indexPath.section == 2 {
            if choiceKanaType == .hiragana {
                lessons = LessonsService.shared.lessHiraganaThree[indexPath.row]
            } else {
                lessons = LessonsService.shared.lessKatakanaThree[indexPath.row]
            }
            cell.setCell(with: kanaTitle, textLessonTitle: lessons.name, textDetail: lessons.detail, mode: mode)
            
        }
        cell.delegate = self
        return cell
    }
}

extension KanaLessons: MyLessonViewCellDelegate {
    
    // When tap on a cell : create a new lesson and go to lesson page
    func didTapButton(with name: String) {
        let choiceLesson = name
        let kanaArray = setKanaArray(with: choiceLesson)
        createLesson(with: kanaArray, name: choiceLesson)
        if lessonType == .reading {
            performSegue(withIdentifier: "segueToLessonLearn", sender: self)
        } else if lessonType == .writing {
            performSegue(withIdentifier: "segueToLessonWritingLearn", sender: self)
        }
        
    }
}
