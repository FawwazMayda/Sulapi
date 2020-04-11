//
//  Model.swift
//  Alarmy
//
//  Created by Muhammad Fawwaz Mayda on 08/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Foundation

class Alarm: Codable {
    var hour : Int
    var minute : Int
    var isOn : Bool
    var onDay = [String]()
    var dayToWeekday : [String:Int] =
        ["Sunday":1,"Monday":2,"Tuesday":3,"Wednesday":4,"Thursday":5,"Friday":6,"Saturday":7]
    var strDate : String {
        let hourLabel = self.hour>=10 ? String(self.hour): "0\(self.hour)"
        let minuteLabel = self.minute>=10 ? String(self.minute) : "0\(self.minute)"
       return "\(hourLabel):\(minuteLabel)"
    }
    
    init() {
        hour = 0
        minute = 0
        isOn = false
    }
    
    func setAlarm() {
        //Fungsi untuk membuat Notif
        print("Set Alarm")
    }
    
    func unSetAlarm() {
        //Fungsi untuk menghapus notif
        print("Unset Alarm")
    }
}

protocol AlarmDelegate {
    mutating func newAlarm(e : Alarm)
    mutating func editAlarm(index : Int,e : Alarm)
    func setAlarm(e : Alarm)
    func unSetAlarm(e : Alarm)
}
