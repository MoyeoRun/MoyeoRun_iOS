//
//  RunningRecordCell.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/23.
//

import Foundation
import UIKit

class RunningRecordCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var adminProfileImageView: UIImageView!

    func setUI() {
        imageView.layer.cornerRadius = 4
        adminProfileImageView.layer.cornerRadius = adminProfileImageView.layer.bounds.width * 0.5
        self.layer.cornerRadius = 4
    }
}

extension RunningRecordCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ProfileImageCell", for: indexPath
        ) as? ProfileImageCell else {
            return UICollectionViewCell()
        }
        cell.setUI()

        return cell
    }
}

extension RunningRecordCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 25, height: 25)
    }
}

class ProfileImageCell: UICollectionViewCell {
    @IBOutlet var profileImageView: UIImageView!
    func setUI() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width * 0.5
    }
}
