//
//  PeopleNumPickerView.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/03/27.
//

import UIKit

class PeopleNumPicker: UIPickerView {
    var availablePN = [Int] (0 ... 10)
    var selectedPN = 0

    convenience init(value: Bool) {
        self.init(frame: CGRect.zero)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PeopleNumPicker: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availablePN.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(availablePN[row])"
    }
    /// 피커뷰에서 선택된 행을 처리할 수 있는 메서드
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPN = availablePN[row]
    }
}
