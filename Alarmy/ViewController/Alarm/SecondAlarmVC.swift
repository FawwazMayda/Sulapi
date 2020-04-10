//
//  SecondAlarmVC.swift
//  Alarmy
//
//  Created by Muhammad Fawwaz Mayda on 07/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class SecondAlarmVC: UIViewController, AlarmDelegate {
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Alarm.plist")
    
    var alarmies = [Alarm]()

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        }
    }
    
    func newAlarm(e: Alarm) {
        self.alarmies.append(e)
        print("Get new alarm")
        self.tableview.reloadData()
        saveData()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SecondAlarmVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell", for: indexPath) as! AlarmCell
        cell.alarmData = alarmies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
}
