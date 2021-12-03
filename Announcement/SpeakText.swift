import Foundation
import AVFoundation

class SpeakText {
    
    var message:String = ""
    var talker = AVSpeechSynthesizer()
    
    func speech(_ text: String){
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        self.talker.speak(utterance)
    }
}
