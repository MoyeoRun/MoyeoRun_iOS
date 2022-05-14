//
//  SearchTabViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/13.
//

import UIKit

class SearchTabViewController: UIViewController {
    @IBOutlet weak var searchBar: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    func setUI() {
        setSearchBarUI()
        func setSearchBarUI() {
            searchBar.layer.borderWidth = 1
            searchBar.layer.borderColor = UIColor.black.cgColor
            searchBar.layer.cornerRadius = 4
        }
    }
}
