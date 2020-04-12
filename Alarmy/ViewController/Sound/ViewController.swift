//
//  ViewController.swift
//  Alarmy
//
//  Created by Iswandi Saputra on 09/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var playingNumber = 0
    let musicArray = ["music1.mp3","music2.mp3","music3.mp3","music4.mp3"]
    let songArray = ["The Winter Song", "The Spring Song", "The Summer Song", "The Autumn Song"]
    let singerArray = ["Jack Frost", "Easter Bunny", "Sandman", "Bogeyman"]
    let imageArray = ["guitar","guitar","guitar","guitar"]
    
    var audioPlayer = AVAudioPlayer()
    var musicPath = Bundle.main.bundleURL.appendingPathComponent("music1.mp3")
    
    var playStatus: Bool = true
    var playTime = 0.0
    
    let playImage = UIImage(named: "play_btn")
    let pauseImage = UIImage(named: "pause_btn")
    
    
    
    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var volume: UISlider!
    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var singerName: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMusic()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMusic() {
        
        artworkImage.image = UIImage(named: imageArray[playingNumber])
        songName.text = songArray[playingNumber]
        singerName.text = singerArray[playingNumber]
        
        musicPath = Bundle.main.bundleURL.appendingPathComponent(musicArray[playingNumber])
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: musicPath, fileTypeHint: nil)
            
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
        let imageForVolume = UIImage(named: "img_volume")
        slider.setThumbImage(imageForThumb, for: .normal)
        slider.minimumTrackTintColor = UIColor.orange
        slider.maximumTrackTintColor = UIColor.gray
        slider.maximumValue = Float(audioPlayer.duration)
        volume.setThumbImage(imageForVolume, for: .normal)
        volume.minimumTrackTintColor = UIColor.gray
    }

    @IBAction func playTapped(_ sender: UIButton) {
        
        if playStatus == true {
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
            audioPlayer.stop()
            playTime = audioPlayer.currentTime
            playButton.setImage(playImage, for: .normal)
            playStatus = false
        } else {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: musicPath, fileTypeHint: nil)
                audioPlayer.currentTime = playTime
                audioPlayer.play()
                playButton.setImage(pauseImage, for: .normal)
                playStatus = true
            } catch {
                print("Terjadi kesalahan selama pemutaran")
            }
        }
    }
    

    @objc func updateSlider() {
        slider.value = Float(audioPlayer.currentTime)
        

        if slider.value >= slider.maximumValue - 0.15 {
            playingNumber += 1
            setMusic()
        }
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        audioPlayer.currentTime = TimeInterval(slider.value)
    }
    
    
    @IBAction func volumeController(_ sender: UISlider) {
        audioPlayer.volume = volume.value
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        if playingNumber >= musicArray.count - 1 {
            playingNumber = 0
        } else {
            playingNumber += 1
        }
        setMusic()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        if playingNumber <= 0 {
            playingNumber = musicArray.count - 1
        } else {
            playingNumber -= 1
        }
        setMusic()
    }
    
    
}

