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
    @IBOutlet weak var switchAlarm: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func alarmSwitched(_ sender: UISwitch) {
        
        print("Alarm is Switched")
    }
    
    
}
