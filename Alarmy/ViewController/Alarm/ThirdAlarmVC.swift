//
//  ThirdAlarmVC.swift
//  Alarmy
//
//  Created by Muhammad Fawwaz Mayda on 07/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class ThirdAlarmVC: UIViewController {
    
    var delegate : AlarmDelegate?
    var newAlarm : Alarm = Alarm()
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .time
        newAlarm.hour = 19
        newAlarm.minute = 22
        newAlarm.isOn = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        delegate?.newAlarm(e: newAlarm)
        print("Sending Alarm")
        performSegue(withIdentifier: "ThirdToSecondAlarmUnwind", sender: nil)
        
    }
    
    
    @IBAction func datePickerScrolled(_ sender: UIDatePicker) {
        
        print("Picker: \(datePicker.date)")
    }
    
}
