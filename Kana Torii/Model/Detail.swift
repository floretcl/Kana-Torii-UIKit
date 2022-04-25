//
//  Detail.swift
//  Kana Torii
//
//  Created by clément floret on 24/06/2020.
//  Copyright © 2020 Clément FLORET. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

struct Detail {
    
    let romaji: String
    let kana: String
    let linesImage: UIImage
    
    private let synthesizer = AVSpeechSynthesizer()
    
    func readTextInJapanese(text: String) {
       
        let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
                try audioSession.setMode(AVAudioSession.Mode.default)
                try audioSession.setActive(true)
                try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            } catch {
                fatalError("Error with AVaudiosession")
            }
       
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        } else {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
            utterance.rate = 0.1
            utterance.pitchMultiplier = 1
            utterance.volume = 1
            DispatchQueue.main.async {
                self.synthesizer.speak(utterance)
            }
        }
    }
}
