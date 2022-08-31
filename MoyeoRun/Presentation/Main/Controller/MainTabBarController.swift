//
//  MainTabBarController.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/08/31.
//


import UIKit

class MainTabBarController: UITabBarController {
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
