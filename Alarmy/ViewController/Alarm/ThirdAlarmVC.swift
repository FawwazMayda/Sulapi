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
    //1 - 7
    var chosenWeekday = [Int]()
    //var newAlarm : Alarm = Alarm()
    var dayList = [1,2,3,4,5,6,7]
    var currentWeekday = 0
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dayTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get the auto Weekday
        let date = Date()
        let calender = Calendar.current
        currentWeekday = calender.component(.weekday, from: date)
        chosenWeekday.append(currentWeekday)
        //Set a picker
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "en_US")
        dayTable.delegate = self
        dayTable.dataSource = self
        //Set the label
        if let oldAlarm = editAlarm {
            let hourLabel = (oldAlarm.hour>=10) ? String(oldAlarm.hour) : "0\(oldAlarm.hour)"
            let minuteLabel = (oldAlarm.minute>=10) ? String(oldAlarm.minute) : "0\(oldAlarm.minute)"
            timeLabel.text = "\(hourLabel):\(minuteLabel)"
            chosenWeekday = oldAlarm.onDay
        } else {
            let (h,m) = self.parseAlarm(d: datePicker.date)
            let hourLabel = (h>=10) ? String(h) : "0\(h)"
            let minuteLabel = (m>=10) ? String(m) : "0\(m)"
            timeLabel.text = "\(hourLabel):\(minuteLabel)"
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
    //MARK: - Sending Alarm
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        
        if let anAlarm = editAlarm,let id = index {
            //We are going to edit an Alarm
            let (hour,minute) = parseAlarm(d: datePicker.date)
            anAlarm.hour = hour
            anAlarm.minute = minute
            chosenWeekday.sort()
            anAlarm.onDay = chosenWeekday
            delegate?.editAlarm(index: id, e: anAlarm)
        } else {
            let (hour,minute) = parseAlarm(d: datePicker.date)
            let newAlarm = Alarm()
            newAlarm.hour = hour
            newAlarm.minute = minute
            newAlarm.isOn = true
            chosenWeekday.sort()
            newAlarm.onDay = chosenWeekday
            delegate?.newAlarm(e: newAlarm)
        }
        print("Sending Alarm")
        performSegue(withIdentifier: "ThirdToSecondAlarmUnwind", sender: nil)
        
    }
    
    //MARK: - UIRelated
    @IBAction func datePickerScrolled(_ sender: UIDatePicker) {
        let (hour,min) = parseAlarm(d: datePicker.date)
        let hourLabel = (hour>=10) ? String(hour) : "0\(hour)"
        let minuteLabel = (min>=10) ? String(min) : "0\(min)"
        timeLabel.text = "\(hourLabel):\(minuteLabel)"
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
   
        cell.textLabel?.text = "Every \(Helper.dayToWeekdaInt(dayList[indexPath.row]))"
        cell.accessoryType = (chosenWeekday.firstIndex(of: dayList[indexPath.row])==nil) ? .none : .checkmark
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = dayTable.cellForRow(at: indexPath)
        if selectedCell?.accessoryType==UITableViewCell.AccessoryType.none {
            selectedCell?.accessoryType = .checkmark
            chosenWeekday.append(indexPath.row+1)
            print("Repeat at \(Helper.dayToWeekdaInt(indexPath.row+1))")
        } else {
            chosenWeekday = chosenWeekday.filter {$0 != (indexPath.row+1)}
            print("Not Repeat at \(Helper.dayToWeekdaInt(indexPath.row+1))")
            selectedCell?.accessoryType = .none
        }
    }
    
    
}
