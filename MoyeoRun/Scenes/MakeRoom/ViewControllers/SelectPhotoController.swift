//
//  SelectPhotoController.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/04/18.
//

import UIKit

class SelectPhotoController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    let photos = [
        UIImage(named: "Image-1.png"), UIImage(named: "Image-2.png"), UIImage(named: "Image-3.png"),
        UIImage(named: "Image-4.png"), UIImage(named: "Image-5.png"), UIImage(named: "Image-6.png"),
        UIImage(named: "Image-7.png"), UIImage(named: "Image-8.png")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SelectPhotoController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
            as? PhotoCell
        else {
            return UICollectionViewCell()
        }
        guard let img = photos[indexPath.row] else { return UICollectionViewCell() }
        cell.setData(with: img)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imgView.image = photos[indexPath.row]
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewCellWidth = collectionView.frame.width / 3
        return CGSize(width: collectionViewCellWidth - 4, height: collectionViewCellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension SelectPhotoController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
}
