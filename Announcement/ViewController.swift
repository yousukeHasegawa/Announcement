//
//  ViewController.swift
//  Announcement
//
//  Created by Yousuke Hasegawa on 2021/12/01.
//

import UIKit

class ViewController: UIViewController {

    var playCount: Int = -1
    var messages: [Message] = []
//    let message: [String] = [
//    "操作を開始してください",
//    "操作を続けてください",
//    "操作を完了してください"
//    ]
    
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var ffButton: UIButton!
    
//    @IBAction func tappedRewindButton(_ sender: Any) {
//        playCount -= 1
//        play()
//        setDisplay()
//    }
    
    @IBAction func tappedPlayButton(_ sender: Any) {
        if playCount == -1 {
            playCount = 0
        }else{
            playCount = messages.count + 1
        }
        
        play()
        setDisplay()
    }
    
    @IBAction func tappedFfButton(_ sender: Any) {
        playCount += 1
        play()
        setDisplay()
    }
    
    //実際の発声をおこなう
    func play(){
        let speakText = SpeakText()
        
        if self.playCount == -1 {
            return
            
        }else if self.playCount == self.messages.count{
            speakText.speech("これで終了です。お疲れ様でした")
            
        }else if self.playCount > self.messages.count{
            speakText.speech("最初に戻ります。")
            self.playCount = -1
            
        }else{
            speakText.speech(self.messages[self.playCount].text)
        }
    }
    
    //画面表記を変更する
    func setDisplay(){
        if playCount == -1 {
            rewindButton.isHidden = true
            playButton.setTitle("スタート", for: .normal)
            messageLabel.text = "スタートボタンを押してください"
            ffButton.isHidden = true
            
        }else if playCount == self.messages.count{
        
            rewindButton.isHidden = true
            playButton.setTitle("スタートに戻る", for: .normal)
            messageLabel.text = "これで終了です。お疲れ様でした。"
            ffButton.isHidden = true
            
            
        }else{
            rewindButton.isHidden = false
            playButton.setTitle("停止", for: .normal)
            messageLabel.text = messages[self.playCount].text
            ffButton.isHidden = false
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        messages = Bundle.main.decodeJSON("steps.json")
        setDisplay()
        // Do any additional setup after loading the view.
    }
}
