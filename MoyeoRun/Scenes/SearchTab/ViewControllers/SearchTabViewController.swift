//
//  SearchTabViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/05/13.
//

import UIKit

class SearchTabViewController: UIViewController {
    @IBOutlet weak var searchBar: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    func setUI() {
        setSearchBarUI()
        func setSearchBarUI() {
            searchBar.layer.borderWidth = 1
            searchBar.layer.borderColor = UIColor.black.cgColor
            searchBar.layer.cornerRadius = 4
        }
    }
}

extension SearchTabViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RunningContentCell", for: indexPath) as? RunningContentCell else {
            return UICollectionViewCell()
        }
        cell.setUI()
        
        return cell
    }
    
    
}

extension SearchTabViewController: UICollectionViewDelegateFlowLayout {
    
}
