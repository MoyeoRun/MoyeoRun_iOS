//
//  DatePickerViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/08/15.
//

import UIKit

class DatePickerViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var datePicker: UIPickerView!
    private let yearArray: [String] = [ "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028"]
    private let monthArray: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
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
        datePicker.delegate = self
        datePicker.dataSource = self
        datePicker.backgroundColor = .white
        datePicker.tintColor = .gray
    }

    @IBAction func dateChanged(_ sender: UIDatePicker) {
        print(sender.date)
    }
    @IBAction func onTapBackground(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func onTapCancelButton(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func onTapCompleteButton(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
}

extension DatePickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return yearArray.count
        case 1: return 1
        case 2: return monthArray.count
        case 3: return 1
        default: return 10
        }
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch component {
        case 0: return NSAttributedString(string: yearArray[row])
        case 1:
            let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            let attrString = NSAttributedString(string: "년",attributes: attribute)
            
            return attrString
        case 2: return NSAttributedString(string: monthArray[row])
        case 3: return NSAttributedString(string: "월")
        default:
            return nil
        }
    }
}
