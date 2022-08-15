//
//  DatePickerViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/08/15.
//

import UIKit

class DatePickerViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.setStackView()
            self.setDatePicker()
        }
    }
    private func setStackView() {
        stackView.layer.cornerRadius = 12
    }
    private func setDatePicker() {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.date = Date()
        datePicker.setDate(Date(), animated: true)
        datePicker.backgroundColor = .white
        datePicker.tintColor = .gray
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        print(sender.date)
    }
}
