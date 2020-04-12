

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
    @IBOutlet var starttimerprogress: UILabel!
    @IBOutlet var endtimerprogress: UILabel!
    
    
    var remainingTime: TimeInterval = 0
    var endDate: NSDate!
    var timer = Timer()
    var isPaused = true
    var audioLength = 0.0
    var titleTemp = ""
    var durationTemp = ""
    var imageTemp = ""
    var totalLengthOfAudio = ""
    var musicDuration:TimeInterval = 0
    var player: AVAudioPlayer?
    var currentTime: TimeInterval = 0
    var audioPlayer = AVAudioPlayer()
    var musicPath = Bundle.main.bundleURL.appendingPathComponent("Always.mp3")
    var playingNumber = 0
    var playStatus: Bool = true
    var playTime = 0.0
    
    let playImage = UIImage(named: "play_btn")
    let pauseImage = UIImage(named: "pause_btn")
    
    
    //This returns song length
    func calculateTimeFromNSTimeInterval(_ duration:TimeInterval) ->(minute:String, second:String){
        let minute_ = abs(Int((duration/60).truncatingRemainder(dividingBy: 60)))
        let second_ = abs(Int(duration.truncatingRemainder(dividingBy: 60)))
        let minute = minute_ > 9 ? "\(minute_)" : "0\(minute_)"
        let second = second_ > 9 ? "\(second_)" : "0\(second_)"
        return (minute,second)
    }
    
    
    func showTotalSongLength(){
        calculateSongLength()
        
    }
    
    func calculateSongLength(){
        audioLength = audioPlayer.duration
        remainingTime =  audioPlayer.duration
        let time = calculateTimeFromNSTimeInterval(audioLength)
        
        totalLengthOfAudio = "\(time.minute):\(time.second)"
        
        
    }
    
    
    
    @objc func updateSlider() {
        if !audioPlayer.isPlaying{
            return
        }
        showTotalSongLength()
        let time = calculateTimeFromNSTimeInterval(audioPlayer.currentTime)
        musicPlayerSlider.value = Float(audioPlayer.currentTime)
        
        starttimerprogress.text  = "\(time.minute):\(time.second)"
        if musicPlayerSlider.value >= musicPlayerSlider.maximumValue - 0.15 {
            playingNumber += 1
            setMusic()
            
        }
    }
    
    @objc func updateLabel() {
        if !audioPlayer.isPlaying{
            return
        }
        endtimerprogress.text = endDate.timeIntervalSinceNow.mmss
    }
    
    func setMusic() {
        button.setImage(pauseImage, for: .normal)
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
        let time = calculateTimeFromNSTimeInterval(audioPlayer.currentTime)
    }
    
    @IBAction func scrubSlider(_ sender: Any) {
        
        audioPlayer.currentTime = TimeInterval(musicPlayerSlider.value)
    }
    @IBAction func didTapButton() {
        
        if playStatus == true {
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateLabel), userInfo: nil, repeats: true)
            
            audioPlayer.stop()
            playTime = audioPlayer.currentTime
            button.setImage(playImage, for: .normal)
            playStatus = false
        } else {
            do {
                timer.invalidate()
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
        starttimerprogress.text = "00:00"
        image.layer.cornerRadius = 12.0
        image.clipsToBounds = true
        image.image = UIImage(named: imageTemp)
        setMusic()
        showTotalSongLength()
        endDate = NSDate().addingTimeInterval(remainingTime)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateLabel), userInfo: nil, repeats: true)
        
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        if parent == nil {
            audioPlayer.stop()
        }
    }
    
}
extension TimeInterval {
    var mmss: String {
        return self < 0 ? "00:00" : String(format:"%02d:%02d", Int((self/60.0).truncatingRemainder(dividingBy: 60)), Int(self.truncatingRemainder(dividingBy: 60)))
    }
    var hmmss: String {
        return String(format:"%d:%02d:%02d", Int(self/3600.0), Int(self / 60.0.truncatingRemainder(dividingBy: 60)), Int(self.truncatingRemainder(dividingBy: 60)))
    }
}
