//
//  HomeTabLastRecordContainer.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/03/29.
//

import UIKit

class HomeTabLastRecordContainer: UIViewController {
}

extension HomeTabLastRecordContainer: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "HomeTabLastRecordCell"

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            as? HomeTabLastRecordCell
        else {
            return UICollectionViewCell()
        }
        cell.setUI(forIndex: indexPath.item)
        return cell
    }
}

extension HomeTabLastRecordContainer: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height * 0.49
        return CGSize(width: width, height: height)
    }
}
