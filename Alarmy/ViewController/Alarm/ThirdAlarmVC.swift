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
    var chosenWeekday : String = ""
    //var newAlarm : Alarm = Alarm()
    var dayList = ["Everyday","Every Monday","Every Tuesday","Every Wednesday","Every Thursday","Every Friday","Every Saturday","Every Sunday"]
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dayTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "en_US")
        dayTable.delegate = self
        dayTable.dataSource = self
        if let oldAlarm = editAlarm {
            timeLabel.text = "\(oldAlarm.hour):\(oldAlarm.minute)"
        }
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
            anAlarm.onDay.append(chosenWeekday)
            delegate?.editAlarm(index: id, e: anAlarm)
        } else {
            let (hour,minute) = parseAlarm(d: datePicker.date)
            let newAlarm = Alarm()
            newAlarm.hour = hour
            newAlarm.minute = minute
            newAlarm.isOn = true
            newAlarm.onDay.append(chosenWeekday)
            delegate?.newAlarm(e: newAlarm)
        }
        print("Sending Alarm")
        performSegue(withIdentifier: "ThirdToSecondAlarmUnwind", sender: nil)
        
    }
    
    
    @IBAction func datePickerScrolled(_ sender: UIDatePicker) {
        let (hour,min) = parseAlarm(d: datePicker.date)
        timeLabel.text = "\(hour):\(min)"
    }
    
    func parseAlarm(d : Date)-> (Int,Int) {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        let strDate = df.string(from: d)
        let arr = strDate.components(separatedBy: ":")
        return (Int(arr[0])!, Int(arr[1])!)
    }
    
}

extension ThirdAlarmVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dayTable.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        cell.textLabel?.text = dayList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = dayTable.cellForRow(at: indexPath)
        if selectedCell?.accessoryType==UITableViewCell.AccessoryType.none {
            selectedCell?.accessoryType = .checkmark
            chosenWeekday = dayList[indexPath.row]
            
        } else {
            chosenWeekday = ""
            selectedCell?.accessoryType = .none
        }
    }
    
    
}
