//
//  FirstAlarmVC.swift
//  Alarmy
//
//  Created by Muhammad Fawwaz Mayda on 07/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class FirstAlarmVC: UIViewController {
    
    var chosenAlarmType = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func bedTimeTapped(_ sender: UIButton) {
        chosenAlarmType = "Bedtime.plist"
        performSegue(withIdentifier: "FirstToSecondAlarm", sender: self)
    }
    
    @IBAction func wakeTimeTapped(_ sender: Any) {
        chosenAlarmType = "Waketime.plist"
        performSegue(withIdentifier: "FirstToSecondAlarm", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FirstToSecondAlarm" {
            let vc = segue.destination as! SecondAlarmVC
            vc.alarmType = chosenAlarmType
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
