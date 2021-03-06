//
//  TabBarViewControllers.swift
//  MoyeoRun
//
//  Created by κΉμν on 2022/03/27.
//


import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    func setUI() {
        setTabBarShadow()
    }

    func setTabBarShadow() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
}
