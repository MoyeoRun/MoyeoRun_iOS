//
//  CalendarViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/06/24.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var calendarView: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.setUI()
        }
        setBackgroundView()
    }

    private func setUI() {
        self.calendarView.layer.cornerRadius = 12
    }

    private func setBackgroundView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissView))
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(tapGesture)
    }

    @objc func dismissView(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.dismiss(animated: false)
        }
    }
}
