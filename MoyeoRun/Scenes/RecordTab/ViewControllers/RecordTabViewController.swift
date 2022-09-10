//
//  RecordTabViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/20.
//

import UIKit

class RecordTabViewController: UIViewController {
    @IBOutlet var dateCalendarButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.setCurrentDate()
        }
    }

    private func setCurrentDate() {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        let dateString = dateFormatter.string(from: now)
        self.setSelectedDate(date: dateString)
    }
    private func setSelectedDate(date: String) {
        let currentYear = date.prefix(4)
        let currentMonth = date.suffix(2)
        let resultAttributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "calendar")?.withTintColor(.white, renderingMode: .alwaysTemplate)
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 15, height: 15)

        resultAttributedString.append(NSAttributedString(attachment: imageAttachment))
        let dateString = " " + currentYear + "년 " + currentMonth + "월"
        let attributedString = NSMutableAttributedString(string: dateString)
        resultAttributedString.append(attributedString)

        self.dateCalendarButton.setAttributedTitle(resultAttributedString, for: .normal)
    }
}

extension RecordTabViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "RunningRecordCell", for: indexPath
        ) as? RunningRecordCell else {
            return UICollectionViewCell()
        }
        cell.setUI()
        return cell
    }
}

extension RecordTabViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.9
        let height = 138.0

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // MARK: 아이템 터치 처리
        let storyboard = UIStoryboard(name: "RecordDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecordDetail")
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: true)
    }
}
