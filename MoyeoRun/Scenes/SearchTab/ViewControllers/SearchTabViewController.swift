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
        DispatchQueue.main.async {
            self.setUI()
        }
    }

    func setUI() {
        setSearchBarUI()
        setRecentRunningButton()
        func setSearchBarUI() {
            self.searchBar.layer.borderWidth = 1
            self.searchBar.layer.borderColor = UIColor.black.cgColor
            self.searchBar.layer.cornerRadius = 4
        }

        func setRecentRunningButton() {
            self.recentRunningButton.setTitleColor(.black, for: .normal)
            self.recentRunningButton.layer.addUnderLine(color: .black, width: 2)
        }
    }

    @IBAction func onTapRecentRunningButton(_ sender: Any) {
        DispatchQueue.main.async {
            if self.selectedButton != .recentRunningButton {
                self.unSetUIDeselectedButton()
                self.selectedButton = .recentRunningButton
                self.setUISelectedButton()
            }
        }
    }

    @IBAction func onTapPaceButton(_ sender: Any) {
        DispatchQueue.main.async {
            if self.selectedButton != .paceButton {
                self.unSetUIDeselectedButton()
                self.selectedButton = .paceButton
                self.setUISelectedButton()
            }
        }
    }

    @IBAction func onTapDistanceButton(_ sender: Any) {
        DispatchQueue.main.async {
            if self.selectedButton != .distanceButton {
                self.unSetUIDeselectedButton()
                self.selectedButton = .distanceButton
                self.setUISelectedButton()
            }
        }
    }

    @IBAction func onTapNumOfPeopleButton(_ sender: Any) {
        DispatchQueue.main.async { [self] in
            if self.selectedButton != .numOfPeopleButton {
                self.unSetUIDeselectedButton()
                self.selectedButton = .numOfPeopleButton
                setUISelectedButton()
            }
        }
    }

    func unSetUIDeselectedButton() {
        switch self.selectedButton {
        case .recentRunningButton:
            recentRunningButton.setTitleColor(.gray, for: .normal)
            recentRunningButton.layer.removeUnderLine()

        case .paceButton:
            paceButton.setTitleColor(.gray, for: .normal)
            paceButton.layer.removeUnderLine()

        case .distanceButton:
            distanceButton.setTitleColor(.gray, for: .normal)
            distanceButton.layer.removeUnderLine()

        case .numOfPeopleButton:
            numOfPeopleButton.setTitleColor(.gray, for: .normal)
            numOfPeopleButton.layer.removeUnderLine()
        }
    }

    func setUISelectedButton() {
        switch self.selectedButton {
        case .recentRunningButton:
            recentRunningButton.setTitleColor(.black, for: .normal)
            recentRunningButton.layer.addUnderLine(color: .black, width: 2)

        case .paceButton:
            paceButton.setTitleColor(.black, for: .normal)
            paceButton.layer.addUnderLine(color: .black, width: 2)

        case .distanceButton:
            distanceButton.setTitleColor(.black, for: .normal)
            distanceButton.layer.addUnderLine(color: .black, width: 2)

        case .numOfPeopleButton:
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

enum SelectedButton {
    case recentRunningButton
    case paceButton
    case distanceButton
    case numOfPeopleButton
}
