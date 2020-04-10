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
    
    init() {
        hour = 0
        minute = 0
        isOn = false
    }
}

protocol AlarmDelegate {
    mutating func newAlarm(e : Alarm)
}
