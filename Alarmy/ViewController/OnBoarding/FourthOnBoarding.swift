//
//  FourthOnBoarding.swift
//  Alarmy
//
//  Created by I Dewa Agung Ary Aditya Wibawa on 09/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class FourthOnBoarding: UIViewController {

    override func viewDidLoad() {
           super.viewDidLoad()
           customizeButton()
           
       }
       
       @IBOutlet weak var firstButton4: UIButton!
       @IBOutlet weak var secondButton4: UIButton!
       @IBOutlet weak var thirdButton4: UIButton!
       
       func customizeButton(){
           firstButton4.layer.cornerRadius = 25
           secondButton4.layer.cornerRadius = 25
           thirdButton4.layer.cornerRadius = 25
       }
}
