//
//  DistancePickerView.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/03/27.
//

import UIKit

class DistancePicker: UIPickerView {
    var selectedKM = 0
    var availableKM: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var availableM = [Int](0...99)
    let KMLabel: UILabel = {
        let label = UILabel()
        label.text = "KM"
        label.font = label.font.withSize(20)
        label.sizeToFit()
        return label
    }()
    convenience init(value: Bool) {
        self.init(frame: CGRect.zero)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let labelY: CGFloat = 72
        let labelX: CGFloat = 140
        KMLabel.frame = CGRect(x: labelX, y: labelY, width: 30, height: 15)
        // self.addSubview(labelList[0])
        self.addSubview(KMLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DistancePicker: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableKM.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(availableKM[row])"
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60
    }
    /// 피커뷰에서 선택된 행을 처리할 수 있는 메서드
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedKM = availableKM[row]
    }
}
