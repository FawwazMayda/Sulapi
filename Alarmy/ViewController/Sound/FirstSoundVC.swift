//
//  FirstSoundVC.swift
//  Alarmy
//
//  Created by Muhammad Fawwaz Mayda on 07/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class FirstSoundVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var position = 1
    var selectedIndex = Int()
    var allSound = [Sound]()
    
    @IBAction func didChangeSegmented(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            position = 1
            self.tableView.reloadData()
        case 1:
            position = 2
            self.tableView.reloadData()
        case 2:
            position = 3
            self.tableView.reloadData()
        default:
            break
        }
    }
    
    struct Sound {
        var soundTitle: String
        var soundDuration: String
        var soundImage:String
        
    }

    let instrumentSounds = [
        Sound(soundTitle: "Always", soundDuration: "30 Min", soundImage: "guitar"),
        Sound(soundTitle: "Bedtime Lullaby", soundDuration: "30 Min", soundImage: "sleep"),
        Sound(soundTitle: "Bright Future", soundDuration: "30 Min", soundImage: "guitar"),
        Sound(soundTitle: "Early Morning", soundDuration: "30 Min", soundImage: "sleep"),
        Sound(soundTitle: "Enjoy Light", soundDuration: "30 Min", soundImage: "guitar"),
        Sound(soundTitle: "Happy Time", soundDuration: "30 Min", soundImage: "sleep"),
        Sound(soundTitle: "Lovely Journey", soundDuration: "30 Min", soundImage: "guitar"),
        Sound(soundTitle: "Missing You", soundDuration: "30 Min", soundImage: "sleep"),
        Sound(soundTitle: "Peaceful Night", soundDuration: "30 Min", soundImage: "guitar"),
        Sound(soundTitle: "Sleep Tight", soundDuration: "30 Min", soundImage: "sleep"),
        Sound(soundTitle: "Sunny Day", soundDuration: "30 Min", soundImage: "guitar")
    ]
    
    let natureSounds = [
        Sound(soundTitle: "Bird Sound", soundDuration: "15 Min", soundImage: "sleep"),
        Sound(soundTitle: "Camfire", soundDuration: "15 Min", soundImage: "guitar"),
        Sound(soundTitle: "Delta Waves", soundDuration: "15 Min", soundImage: "sleep"),
        Sound(soundTitle: "Flowing Water", soundDuration: "15 Min", soundImage: "guitar"),
        Sound(soundTitle: "Heavy Thunder", soundDuration: "15 Min", soundImage: "sleep"),
        Sound(soundTitle: "Magic Elf", soundDuration: "15 Min", soundImage: "guitar"),
     Sound(soundTitle: "Ocean Waves", soundDuration: "15 Min", soundImage: "guitar"),
     Sound(soundTitle: "Rainfall", soundDuration: "15 Min", soundImage: "guitar"),
     Sound(soundTitle: "River Flows", soundDuration: "15 Min", soundImage: "guitar"),
   Sound(soundTitle: "Tropical Forest", soundDuration: "15 Min", soundImage: "guitar"),
     Sound(soundTitle: "Waterfall", soundDuration: "15 Min", soundImage: "guitar"),
       
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FirstSoundVC:UITableViewDelegate{
   // MARK - TableView Delegate Method
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //deselect row animation
    tableView.deselectRow(at: indexPath, animated: true)
    
        if position == 1 {
            self.selectedIndex = indexPath.row
            let sound = allSound[indexPath.row]
            performSegue(withIdentifier: "playMusic", sender: sound)
        }
        else if position == 2 {
            self.selectedIndex = indexPath.row
            let sound = instrumentSounds[indexPath.row]
            performSegue(withIdentifier: "playMusic", sender: sound)
        }
        else if position == 3 {
            self.selectedIndex = indexPath.row
            let sound = natureSounds[indexPath.row]
            performSegue(withIdentifier: "playMusic", sender: sound)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playMusic"{
            let vc : SecondSoundVC = segue.destination as! SecondSoundVC
            if position == 1 {
                let sound = allSound[selectedIndex]
                vc.titleTemp = sound.soundTitle
                vc.durationTemp = sound.soundDuration
                vc.imageTemp = sound.soundImage
            }
            else if position == 2 {
                let sound = instrumentSounds[selectedIndex]
                vc.titleTemp = sound.soundTitle
                vc.durationTemp = sound.soundDuration
                vc.imageTemp = sound.soundImage
            }
            else if position == 3 {
                let sound = natureSounds[selectedIndex]
                vc.titleTemp = sound.soundTitle
                vc.durationTemp = sound.soundDuration
                vc.imageTemp = sound.soundImage
            }
        }
    }

}


extension FirstSoundVC:UITableViewDataSource{
    // MARK - TableView Data Source Method
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if position == 1 {
            allSound = instrumentSounds + natureSounds
            return allSound.count
        }
        else if position == 2 {
            return instrumentSounds.count
        }
        else if position == 3 {
            return natureSounds.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if position == 1 {
            let allSound = instrumentSounds+natureSounds
            let sound = allSound[indexPath.row]
            cell.textLabel?.text = sound.soundTitle
            cell.detailTextLabel?.text = sound.soundDuration
            cell.imageView?.image = UIImage(named: sound.soundImage)
            
        } else if position == 2{
            let sound = instrumentSounds[indexPath.row]
            print("sound")
            cell.textLabel?.text = sound.soundTitle
            cell.detailTextLabel?.text = sound.soundDuration
            cell.imageView?.image = UIImage(named: sound.soundImage)
            
        } else if position == 3{
            let sound = natureSounds[indexPath.row]
            cell.textLabel?.text = sound.soundTitle
            cell.detailTextLabel?.text = sound.soundDuration
            cell.imageView?.image = UIImage(named: sound.soundImage)
        }
        
        return cell
    }
    
}
