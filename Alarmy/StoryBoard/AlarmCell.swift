//
//  AlarmCell.swift
//  Alarmy
//
//  Created by Muhammad Fawwaz Mayda on 08/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class AlarmCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var switchAlarm: UISwitch!
    var delegate : AlarmDelegate?
    
    var alarmData : Alarm? {
        didSet {
            if let alarm = alarmData {
                let hourLabel = alarm.hour>=10 ? String(alarm.hour): "0\(alarm.hour)"
                let minuteLabel = alarm.minute>=10 ? String(alarm.minute) : "0\(alarm.minute)"
                timeLabel.text = "\(hourLabel):\(minuteLabel)"
                switchAlarm.isOn = self.alarmData?.isOn ?? false
                var repeatl = ""
                for d in alarm.onDay {
                    repeatl += "\(Helper.dayToWeekdaInt(d)) "
                }
                repeatLabel.text = repeatl
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func alarmSwitched(_ sender: UISwitch) {
        self.alarmData?.isOn = !self.alarmData!.isOn
        print("Alarm is \(self.alarmData!.hour):\(self.alarmData!.minute) is \(self.alarmData!.isOn ? "On" : "Off")")
        
        if self.alarmData!.isOn {
            if let realAlarm = alarmData {
                delegate?.setAlarm(e: realAlarm)
            }
        } else {
            if let realAlarm = alarmData {
                delegate?.unSetAlarm(e: realAlarm)
            }
        }
        
    }
    
    
}
