//
//  FirstViewController.swift
//  Alarmy
//
//  Created by Muhammad Fawwaz Mayda on 07/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class FirstOnBoarding: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        moveCloud1()
    }
    
    
    @IBOutlet weak var firstCloud1: UIImageView!
    @IBOutlet weak var secondCloud1: UIImageView!
    
    func moveCloud1 () {
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat, .autoreverse] ,animations: {
            self.firstCloud1.frame.origin.x += 420
        }, completion: nil)
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat, .autoreverse] ,animations: {
            self.secondCloud1.frame.origin.x -= 420
        }, completion: nil)

    }
    
}

