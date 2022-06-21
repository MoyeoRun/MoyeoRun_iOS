//
//  SearchTabViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/13.
//

import UIKit

class SearchTabViewController: UIViewController {
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var recentRunningButton: UIButton!
    @IBOutlet weak var paceButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var numOfPeopleButton: UIButton!
    var selectedButton: SelectedButton = .recentRunningButton

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    func setUI() {
        setSearchBarUI()
        setRecentRunningButton()
        func setSearchBarUI() {
            searchBar.layer.borderWidth = 1
            searchBar.layer.borderColor = UIColor.black.cgColor
            searchBar.layer.cornerRadius = 4
        }

        func setRecentRunningButton() {
            recentRunningButton.titleLabel?.textColor = .black
            DispatchQueue.main.async {
                self.recentRunningButton.layer.addUnderLine(color: .black, width: 2)
            }
        }
    }

    @IBAction func onTapRecentRunningButton(_ sender: Any) {
        if self.selectedButton != .recentRunningButton {
            removeUnderLine()
            self.selectedButton = .recentRunningButton
            setUnderLine()
        }
    }

    @IBAction func onTapPaceButton(_ sender: Any) {
        if self.selectedButton != .paceButton {
            removeUnderLine()
            self.selectedButton = .paceButton
            setUnderLine()
        }
    }

    @IBAction func onTapDistanceButton(_ sender: Any) {
        if self.selectedButton != .distanceButton {
            removeUnderLine()
            self.selectedButton = .distanceButton
            setUnderLine()
        }
    }

    @IBAction func onTapNumOfPeopleButton(_ sender: Any) {
        if self.selectedButton != .numOfPeopleButton {
            removeUnderLine()
            self.selectedButton = .numOfPeopleButton
            setUnderLine()
        }
    }

    enum SelectedButton {
        case recentRunningButton
        case paceButton
        case distanceButton
        case numOfPeopleButton
    }

    func removeUnderLine() {
        switch self.selectedButton {
        case .recentRunningButton:
            recentRunningButton.titleLabel?.textColor =  .gray
            recentRunningButton.layer.removeUnderLine()
        case .paceButton:
            paceButton.titleLabel?.textColor =  .gray
            paceButton.layer.removeUnderLine()
        case .distanceButton:
            distanceButton.titleLabel?.textColor =  .gray
            distanceButton.layer.removeUnderLine()
        case .numOfPeopleButton:
            numOfPeopleButton.titleLabel?.textColor =  .gray
            numOfPeopleButton.layer.removeUnderLine()
        }
    }

    func setUnderLine() {
        switch self.selectedButton {
        case .recentRunningButton:
            //recentRunningButton.titleLabel?.textColor =  .black
            recentRunningButton.setTitleColor(.black, for: .normal)
            recentRunningButton.layer.addUnderLine(color: .black, width: 2)
        case .paceButton:
            //paceButton.titleLabel?.textColor =  .black
            paceButton.setTitleColor(.black, for: .normal)
            paceButton.layer.addUnderLine(color: .black, width: 2)
        case .distanceButton:
            //distanceButton.titleLabel?.textColor =  .black
            distanceButton.setTitleColor(.black, for: .normal)
            distanceButton.layer.addUnderLine(color: .black, width: 2)
        case .numOfPeopleButton:
            //numOfPeopleButton.titleLabel?.textColor =  .black
            numOfPeopleButton.setTitleColor(.black, for: .normal)
            numOfPeopleButton.layer.addUnderLine(color: .black, width: 2)
        }
    }
}

extension SearchTabViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "RunningContentCell", for: indexPath
        ) as? RunningContentCell else {
            return UICollectionViewCell()
        }
        cell.setUI()

        return cell
    }
}

extension SearchTabViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight: CGFloat = 200

        return CGSize(width: cellWidth, height: cellHeight)
    }
}
