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

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
            pickerLabel?.textAlignment = .center
            pickerLabel?.textColor = .black
        }
        switch component {
        case 0: pickerLabel?.text = yearArray[row]
        case 1: pickerLabel?.text = "년"
        case 2: pickerLabel?.text = monthArray[row]
        case 3: pickerLabel?.text = "월"
        default: break
        }
        return pickerLabel!
    }
}
