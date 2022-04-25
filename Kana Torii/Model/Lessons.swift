//
//  Lessons.swift
//  Kana Torii
//
//  Created by clément floret on 24/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import Foundation

struct Lessons {
    var name: String = ""
    var detail: String = ""
    
    enum KanaType {
        case hiragana
        case katakana
    }
    enum LessonType {
        case reading
        case writing
    }
    enum SectionName: String {
        case gojuon
        case handakuon
        case yoon
    }

    static let lessonsHiraganaGojuon = [
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 1"), detail: "あ　い　う　え　お"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 2"), detail: "か　き　く　け　こ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 3"), detail: "さ　し　す　せ　そ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 4"), detail: "た　ち　つ　て　と"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 5"), detail: "な　に　ぬ　ね　の"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 6"), detail: "は　ひ　ふ　へ　ほ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 7"), detail: "ま　み　む　め　も"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 8"), detail: "や　ゆ　よ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 9"), detail: "ら　り　る　れ　ろ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 10"), detail: "わ　を　ん")
    ]
    
    static let lessonsHiraganaDakuonHandakuon = [
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 11"), detail: "が　ぎ　ぐ　げ　ご"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 12"), detail: "ざ　じ　ず　ぜ　ぞ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 13"), detail: "だ　ぢ　づ　で　ど"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 14"), detail: "ば　び　ぶ　べ　ぼ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 15"), detail: "ぱ　ぴ　ぷ　ぺ　ぽ")
    ]
    
    static let lessonsHiraganaYoon = [
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 16"), detail: "きゃ　きゅ　きょ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 17"), detail: "しゃ　しゅ　しょ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 18"), detail: "ちゃ　ちゅ　ちょ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 19"), detail: "にゃ　にゅ　にょ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 20"), detail: "ひゃ　ひゅ　ひょ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 21"), detail: "みゃ　みゅ　みょ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 22"), detail: "りゃ　りゅ　りょ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 23"), detail: "ぎゃ　ぎゅ　ぎょ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 24"), detail: "じゃ　じゅ　じょ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 25"), detail: "びゃ　びゅ　びょ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 26"), detail: "ぴゃ　ぴゅ　ぴょ")
    ]
    
    static let lessonsKatakanaGojuon = [
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 1"), detail: "ア　イ　ウ　エ　オ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 2"), detail: "カ　キ　ク　ケ　コ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 3"), detail: "サ　シ　ス　セ　ソ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 4"), detail: "タ　チ　ツ　テ　ト"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 5"), detail: "ナ　ニ　ヌ　ネ　ノ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 6"), detail: "ハ　ヒ　フ　ヘ　ホ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 7"), detail: "マ　ミ　ム　メ　モ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 8"), detail: "ヤ　ユ　ヨ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 9"), detail: "ラ　リ　ル　レ　ロ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 10"), detail: "ワ　ヲ　ン")
    ]
    
    static let lessonsKatakanaDakuonHandakuon = [
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 11"), detail: "ガ　ギ　グ　ゲ　ゴ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 12"), detail: "ザ　ジ　ズ　ゼ　ゾ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 13"), detail: "ダ　ヂ　ヅ　デ　ド"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 14"), detail: "バ　ビ　ブ　ベ　ボ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 15"), detail: "パ　ピ　プ　ペ　ポ")
    ]
    
    static let lessonsKatakanaYoon = [
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 16"), detail: "キャ　キュ　キョ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 17"), detail: "シャ　シュ　ショ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 18"), detail: "チャ　チュ　チョ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 19"), detail: "ニャ　ニュ　ニョ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 20"), detail: "ヒャ　ヒュ　ヒョ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 21"), detail: "ミャ　ミュ　ミョ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 22"), detail: "リャ　リュ　リョ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 23"), detail: "ギャ　ギュ　ギョ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 24"), detail: "ジャ　ジュ　ジョ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 25"), detail: "ビャ　ビョ　ビョ"),
        Lessons(name: (NSLocalizedString("Lesson", comment: "") + " 26"), detail: "ピャ　ピュ　ピョ")
    ]
    
}
