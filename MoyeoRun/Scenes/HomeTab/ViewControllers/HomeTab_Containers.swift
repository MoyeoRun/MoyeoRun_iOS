//
//  HomeTab_NowPopularViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/03/27.
//

import Foundation
import UIKit

class HomeTabNowPopularContainer: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeTabNowPopularCell", for: indexPath) as? HomeTabNowPopularCell else {
            return UICollectionViewCell()
        }
        cell.setUI(forIndex: indexPath.item)
        return cell
    }
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.8
        let height = collectionView.bounds.height * 0.95
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
class HomeTabNewMissionContainer: UIViewController, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeTabNewMissionCell", for: indexPath) as? HomeTabNewMissionCell else {
            return UICollectionViewCell()
        }
        cell.setUI(forIndex: indexPath.item)
        return cell
    }
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.49
        let height = collectionView.bounds.height * 0.49
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = collectionView.bounds.width * 0.49
        let totalWidth = width * 2
        let totalSpacingWidth: CGFloat = 10
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}
class HomeTabLastRecordContainer: UIViewController, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeTabLastRecordCell", for: indexPath) as? HomeTabLastRecordCell else {
            return UICollectionViewCell()
        }
        cell.setUI(forIndex: indexPath.item)
        return cell
    }
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height * 0.49
        return CGSize(width: width, height: height)
    }
}
