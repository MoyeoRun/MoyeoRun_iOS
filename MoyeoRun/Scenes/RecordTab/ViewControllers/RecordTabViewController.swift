//
//  RecordTabViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/20.
//

import UIKit

class RecordTabViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    func setUI() {
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
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
}
