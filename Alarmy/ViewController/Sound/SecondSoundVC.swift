//
//  SecondSoundVC.swift
//  Alarmy
//
//  Created by Muhammad Fawwaz Mayda on 07/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import AVFoundation

class SecondSoundVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var musicPlayerSlider: UISlider!
    
    var titleTemp = ""
    var durationTemp = ""
    var imageTemp = ""
    
    var musicDuration:TimeInterval = 0
    var player: AVAudioPlayer?
    var currentTime: TimeInterval = 0
    
    @IBAction func scrubSlider(_ sender: Any) {
        if let player = player{
            player.stop()
            player.currentTime =        TimeInterval(musicPlayerSlider.value)
            player.prepareToPlay()
            player.play()
        }
    }
    @IBAction func didTapButton() {
        let urlString = Bundle.main.path(forResource: "\(titleTemp)", ofType: "mp3")

        if let player = player, player.isPlaying {
            //stop playback
            musicDuration = player.duration
            button.setImage(UIImage(named: "playBtn"), for: .normal)
            currentTime = player.currentTime
            player.pause()

        }else {
            button.setImage(UIImage(named: "pauseBtn"), for: .normal)
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else {
                    return
                }
                
                if currentTime == 0 {
                    player.play()
                } else {
                    player.currentTime = currentTime
                    player.play()
                    //print(currentTime)
                }
            } catch  {
                print("Something went wrong")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleTemp
        durationLabel.text = durationTemp
        image.image = UIImage(named: imageTemp)
        
    }
    
}
