//
//  PageViewOnBoarding.swift
//  Alarmy
//
//  Created by I Dewa Agung Ary Aditya Wibawa on 09/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class PageViewOnBoarding: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //Declare an Array with member of the viewControllers
    lazy var subViewControllers:[UIViewController] = {
        return [
            UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "firstOnBoarding") as! FirstOnBoarding,
            UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "secondOnBoarding") as! SecondOnBoarding,
            UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "thirdOnBoarding") as! ThirdOnBoarding
        ]
    }()
    
    var pageController = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
        configurePageControl()
    }

    //Set the transition style
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    //Set the Display of Page Control
    func configurePageControl(){
        pageController = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 175, width: UIScreen.main.bounds.width, height: 50))
        pageController.numberOfPages = subViewControllers.count
        pageController.currentPage = 0
        pageController.tintColor = UIColor.black
        pageController.pageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        pageController.currentPageIndicatorTintColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        self.view.addSubview(pageController)
    }
    
    // Set the movement of Page Control
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let contentPageViewController = pageViewController.viewControllers![0]
        self.pageController.currentPage = subViewControllers.index(of: contentPageViewController)!
        
    }
    
    
    //Set Before or Past View Controller
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewControllers.index(of: viewController) ?? 0
        if (currentIndex <= 0){ return nil}
        return subViewControllers[currentIndex-1]
    }
    
    //Set After or Next View Controller
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewControllers.index(of: viewController) ?? 0
        if (currentIndex >= subViewControllers.count-1){ return nil}
        return subViewControllers[currentIndex+1]
    }
    

}

