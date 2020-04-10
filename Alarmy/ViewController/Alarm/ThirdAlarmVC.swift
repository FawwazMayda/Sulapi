//
//  ThirdAlarmVC.swift
//  Alarmy
//
//  Created by Muhammad Fawwaz Mayda on 07/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import Foundation
class ThirdAlarmVC: UIViewController {
    
    var delegate : AlarmDelegate?
    var editAlarm : Alarm?
    var index : Int?
    //var newAlarm : Alarm = Alarm()
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "en_US")
        //newAlarm.hour = 19
        //newAlarm.minute = 22
        //newAlarm.isOn = true
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
        
        if let anAlarm = editAlarm,let id = index {
            //We are going to edit an Alarm
            let (hour,minute) = parseAlarm(d: datePicker.date)
            anAlarm.hour = hour
            anAlarm.minute = minute
            delegate?.editAlarm(index: id, e: anAlarm)
        } else {
            let (hour,minute) = parseAlarm(d: datePicker.date)
            let newAlarm = Alarm()
            newAlarm.hour = hour
            newAlarm.minute = minute
            newAlarm.isOn = true
            delegate?.newAlarm(e: newAlarm)
        }
        print("Sending Alarm")
        performSegue(withIdentifier: "ThirdToSecondAlarmUnwind", sender: nil)
        
    }
    
    
    @IBAction func datePickerScrolled(_ sender: UIDatePicker) {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        let strDate =  df.string(from: datePicker.date)
        print("Picker: \(strDate))")
    }
    
    func parseAlarm(d : Date)-> (Int,Int) {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        let strDate = df.string(from: d)
        let arr = strDate.components(separatedBy: ":")
        return (Int(arr[0])!, Int(arr[1])!)
    }
    
}
