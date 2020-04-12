//
//  SecondAlarmVC.swift
//  Alarmy
//
//  Created by Muhammad Fawwaz Mayda on 07/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit
import UserNotifications

class SecondAlarmVC: UIViewController, AlarmDelegate {
    var alarmType : String = ""
    let userNotif = UNUserNotificationCenter.current()
    var dataFilePath : URL?
    //var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Alarm.plist")
    
    var alarmies = [Alarm]()
    var editAlarm : Alarm?
    var editAlarmIndex : Int?

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = alarmType=="Bedtime.plist" ? "Bedtime" : "Waketime"
        self.requestNotificationAuthorization()
        userNotif.delegate = self
        dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(alarmType)
        // Do any additional setup after loading the view.
        tableview.register(UINib(nibName: "AlarmCell", bundle: nil), forCellReuseIdentifier: "AlarmCell")
        tableview.delegate = self
        tableview.dataSource = self
        print(dataFilePath)
        /*
        alarmies.append(Alarm())
        var nAlarm = Alarm()
        nAlarm.hour = 18
        nAlarm.minute = 28
        alarmies.append(nAlarm)
        var nAlarm2 = Alarm()
        nAlarm2.hour = 22
        nAlarm2.minute = 56
        nAlarm2.isOn = true
        alarmies.append(nAlarm2)
        //saveData()
        */
        loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        saveData()
        //setAlarm()
    }
    
    //MARK: - Miscellaneous
    func requestNotificationAuthorization() {
        // Code here
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotif.requestAuthorization(options: authOptions) { (Bool, Error) in
            if let error = Error {
                print("Error: ",error)
            }
        }
    }
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "SecondToThirdAlarm", sender: self)
    }
    
    @IBAction func unwindToSecond(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        print("Unwind from Third Alarm VC")
        
        // Use data from the view controller which initiated the unwind segue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="SecondToThirdAlarm" {
            let vc = segue.destination as! ThirdAlarmVC
            vc.delegate = self
            if let sendedAlarm = editAlarm,let sendedIndex = editAlarmIndex {
                vc.editAlarm = sendedAlarm
                vc.index = sendedIndex
            }
        }
    }
    
    func newAlarm(e: Alarm) {
        self.alarmies.append(e)
        print("Get new alarm")
        setAlarm(e: e)
        self.tableview.reloadData()
        saveData()
    }
    
    func editAlarm(index : Int,e : Alarm) {
        self.alarmies[index] = e
        print("Edit an alarm")
        self.editAlarm = nil
        self.editAlarmIndex = nil
        self.saveData()
        setAlarm(e: e)
        self.tableview.reloadData()
    }

    // MARK: PersistData
    
    func saveData() {
        do {
            let data = try PropertyListEncoder().encode(self.alarmies)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error Encoding data")
        }
    }
    
    func loadData() {
        do {
            if let data = try? Data(contentsOf: dataFilePath!) {
                self.alarmies = try PropertyListDecoder().decode([Alarm].self, from: data)
            }
        } catch {
            print("Error Decoding data")
        }
    }
    
    //MARK: - Alarm Delegate
    func setAlarm(e : Alarm) {
    
      //Set the alarm
        for day in e.onDay {
            e.onDayUUID.append(UUID().uuidString)
            setAlarm(e: e,weekday: day)
        }
    }
    func setAlarm(e : Alarm, weekday : Int) {
        // set the alarm on specific weekday
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "Its Notif"
            notificationContent.body = "Time to \(title!)"
            notificationContent.badge = NSNumber(value: 1)
            if title!=="Bedtime" {
                notificationContent.sound = .default
            } else {
                notificationContent.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "Bell.wav"))
            }
            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
            var dateComponent = DateComponents()
            dateComponent.calendar = Calendar.current
            dateComponent.hour = e.hour
            dateComponent.minute = e.minute
            // 1 Sunday, 2 Monday and so on
            //let wd = e.dayToWeekday[e.onDay[0]]
            dateComponent.weekday = weekday
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        let req = UNNotificationRequest(identifier: e.onDayUUID.last!, content: notificationContent, trigger: trigger)
            
            self.userNotif.add(req) { (Error) in
                if let e = Error {
                    print(e)
                } else {
                    print("Alarm Setted at \(e.strDate)")
                }
            }
        }
    func unSetAlarm(e : Alarm) {
        userNotif.removePendingNotificationRequests(withIdentifiers: e.onDayUUID)
        e.onDayUUID = [String]()
        print("Unset the alarm \(e.strDate)")
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

//MARK: - UIRelated
extension SecondAlarmVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell", for: indexPath) as! AlarmCell
        cell.alarmData = alarmies[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if alarmies[indexPath.row].isOn {
            print("Bisa di edit")
            editAlarm = alarmies[indexPath.row]
            editAlarmIndex = indexPath.row
            unSetAlarm(e: alarmies[indexPath.row])
            performSegue(withIdentifier: "SecondToThirdAlarm", sender: self)
        } else {
            print("Tidak bisa di edit")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            unSetAlarm(e: alarmies[indexPath.row])
            alarmies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension SecondAlarmVC: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
