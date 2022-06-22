//
//  RecordDetailViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/06/22.
//

import UIKit

class RecordDetailViewController: UIViewController {
    @IBOutlet var backgroundGrayView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    func setUI() {
        backgroundGrayView.layer.cornerRadius = 4
    }
}
