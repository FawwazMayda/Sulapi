//
//  ThirdOnBoarding.swift
//  Alarmy
//
//  Created by I Dewa Agung Ary Aditya Wibawa on 09/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class ThirdOnBoarding: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customButton()
    }
    
    @IBAction func button3Action(_ sender: Any) {
        let next : UIViewController = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(identifier: "fourthOnBoarding") as! FourthOnBoarding
        next.modalPresentationStyle = .fullScreen
        present(next, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var button3: UIButton!
    
    func customButton(){
        button3.layer.cornerRadius = 25
    }

}
