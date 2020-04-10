

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
     var audioPlayer = AVAudioPlayer()
       var musicPath = Bundle.main.bundleURL.appendingPathComponent("music1.mp3")
    var playingNumber = 0
   var playStatus: Bool = true
     var playTime = 0.0
    
       let playImage = UIImage(named: "play_btn")
       let pauseImage = UIImage(named: "pause_btn")
       
    @objc func updateSlider() {
          musicPlayerSlider.value = Float(audioPlayer.currentTime)
          

          if musicPlayerSlider.value >= musicPlayerSlider.maximumValue - 0.15 {
              playingNumber += 1
              setMusic()
          }
      }
    
    
    func setMusic() {
     button.setImage(pauseImage, for: .normal)
       var  s = Bundle.main.path(forResource: "\(titleTemp)", ofType: "mp3")
      let url = Bundle.main.url(forResource: "\(titleTemp)", withExtension: "mp3")
        musicPath = url!
        do {
            
             audioPlayer = try AVAudioPlayer(contentsOf: url!)
            
        } catch {
            print("Terjadi kesalahan selama pemutaran")
        }
        audioPlayer.prepareToPlay()
        setStatusBar()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
        audioPlayer.play()
        
    }
    
    func setStatusBar() {
          let imageForThumb = UIImage(named: "img_circle.png")
           musicPlayerSlider.setThumbImage(imageForThumb, for: .normal)
          musicPlayerSlider.minimumTrackTintColor = UIColor.orange
          musicPlayerSlider.maximumTrackTintColor = UIColor.gray
          musicPlayerSlider.maximumValue = Float(audioPlayer.duration)
 
      }
    
    @IBAction func scrubSlider(_ sender: Any) {
 
        audioPlayer.currentTime = TimeInterval(musicPlayerSlider.value)
    }
    @IBAction func didTapButton() {
        
              if playStatus == true {
                  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
                  audioPlayer.stop()
                  playTime = audioPlayer.currentTime
                  button.setImage(playImage, for: .normal)
                  playStatus = false
              } else {
                  do {
                      audioPlayer = try AVAudioPlayer(contentsOf: musicPath, fileTypeHint: nil)
                      audioPlayer.currentTime = playTime
                      audioPlayer.play()
                      button.setImage(pauseImage, for: .normal)
                      playStatus = true
                  } catch {
                      print("Terjadi kesalahan selama pemutaran")
                  }
              }
        let urlString = Bundle.main.path(forResource: "\(titleTemp)", ofType: "mp3")
        print("test \(urlString)")
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
       titleLabel.text = titleTemp
                   durationLabel.text = durationTemp
 
           setMusic()
    }
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)

        if parent == nil {
            // The view is being removed from the stack, so call your function here
            audioPlayer.stop()  
        }
    }
    
}
