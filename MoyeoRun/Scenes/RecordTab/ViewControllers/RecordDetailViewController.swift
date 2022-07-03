//
//  RecordDetailViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/06/22.
//

import UIKit

class RecordDetailViewController: UIViewController {
    @IBOutlet var backgroundGrayView: UIView!
    @IBOutlet var hostProfileImageView: UIImageView!
    @IBOutlet var hostProfileNameLabel: UILabel!
    @IBOutlet var mapView: MapKitView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.async {
            self.setUI()
        }
    }

    func setUI() {
        backgroundGrayView.layer.cornerRadius = 4
        hostProfileImageView.clipsToBounds = true
        hostProfileImageView.layer.cornerRadius = hostProfileImageView.bounds.height * 0.5
        hostProfileImageView.layer.borderWidth = 2.5
        hostProfileImageView.layer.borderColor = UIColor(named: "RunBlue")?.cgColor
        mapView.layer.cornerRadius = 4
    }

    @IBAction func onTapBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension RecordDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "RecordDetailCollectionViewCell", for: indexPath
        ) as? RecordDetailCollectionViewCell else {
            return UICollectionViewCell()
        }

        DispatchQueue.main.async {
            cell.setUI()
        }

        return cell
    }
}

extension RecordDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = screenWidth * 0.15
        let cellHeight = cellWidth + 4 + hostProfileNameLabel.bounds.height

        return CGSize(width: cellWidth, height: cellHeight)
    }
}

class RecordDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var userProfileNameLabel: UILabel!

    func setUI() {
        self.userProfileImageView.image = UIImage(named: "people1")
        self.userProfileImageView.clipsToBounds = true
        self.userProfileImageView.layer.cornerRadius = self.userProfileImageView.bounds.width * 0.5
    }
}
