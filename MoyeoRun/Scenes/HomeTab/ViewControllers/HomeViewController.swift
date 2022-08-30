//
//  HomeViewController.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/08/25.
//

import UIKit
import CoreAudio

class HomeTabViewController: UIViewController {
    @IBOutlet weak var roomCollectionView: UICollectionView! {
        didSet {
            roomCollectionView.collectionViewLayout = createLayout()
        }
    }

    let roomList: [CurrentRoomListResponse] = [
        CurrentRoomListResponse(
            roomId: 0,
            name: "바람 부는 날 함께 뛰어요",
            thumbnailImage: "Image-1",
            startTime: "10분전",
            distance: 5,
            limitTime: "30분",
            pace: "3'33''",
            limitUserCount: 4,
            currentUserCount: 3),
        CurrentRoomListResponse(
            roomId: 1,
            name: "바람 부는 날 함께 뛰어요",
            thumbnailImage: "Image-2",
            startTime: "10분전",
            distance: 5,
            limitTime: "30분",
            pace: "3'33''",
            limitUserCount: 4,
            currentUserCount: 3),
        CurrentRoomListResponse(
            roomId: 2,
            name: "바람 부는 날 함께 뛰어요",
            thumbnailImage: "Image-3",
            startTime: "10분전",
            distance: 5,
            limitTime: "30분",
            pace: "3'33''",
            limitUserCount: 4,
            currentUserCount: 3),
        CurrentRoomListResponse(
            roomId: 3,
            name: "바람 부는 날 함께 뛰어요",
            thumbnailImage: "Image-4",
            startTime: "10분전",
            distance: 5,
            limitTime: "30분",
            pace: "3'33''",
            limitUserCount: 4,
            currentUserCount: 3)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
    }

    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, _ -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(72)),
                    subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            } else if sectionNumber == 1 {
                let item = NSCollectionLayoutItem(layoutSize: .init(
                    widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)),
                    subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 24
                return section
            } else {
                let item = NSCollectionLayoutItem.init(layoutSize: .init(
                    widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.bottom = 12
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(196)),
                    subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(38)),
                    elementKind: RoomHeader.headerId,
                    alignment: .topLeading)
                section.boundarySupplementaryItems = [
                    header
                ]
                section.contentInsets.top = 24
                return section
            }
        }
    }

    @objc func touchMakeRoomButton(sender: UIButton) {
        let storyboard = UIStoryboard(name: "MakeRoom", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "makeRoomController")
        present(viewController, animated: true)
    }

    private func registerNib() {
        let nibName1 = UINib(nibName: "HomeTopCell", bundle: nil)
        let nibName2 = UINib(nibName: "CurrentJoinRoomCell", bundle: nil)
        let nibname3 = UINib(nibName: "CurrentRoomListCell", bundle: nil)
        let nibname4 = UINib(nibName: "RoomHeader", bundle: nil)
        roomCollectionView.register(nibName1, forCellWithReuseIdentifier: HomeTopCell.cellId)
        roomCollectionView.register(nibName2, forCellWithReuseIdentifier: CurrentJoinRoomCell.cellId)
        roomCollectionView.register(nibname3, forCellWithReuseIdentifier: CurrentRoomListCell.cellId)
        roomCollectionView.register(
            nibname4,
            forSupplementaryViewOfKind: RoomHeader.headerId,
            withReuseIdentifier: "headerId")
    }
}

extension HomeTabViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 2 {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as? RoomHeader
            else { return UICollectionReusableView() }
            return header
        } else {
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return roomList.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeTopCell.cellId, for: indexPath) as? HomeTopCell
            else { return UICollectionViewCell() }
            cell.makeRoomButton.addTarget(self, action: #selector(self.touchMakeRoomButton), for: .touchUpInside)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CurrentJoinRoomCell.cellId, for: indexPath) as?  CurrentJoinRoomCell
            else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CurrentRoomListCell.cellId, for: indexPath) as? CurrentRoomListCell
            else { return UICollectionViewCell() }

            cell.setData(with: roomList[indexPath.row])
            return cell
        }
    }
}
