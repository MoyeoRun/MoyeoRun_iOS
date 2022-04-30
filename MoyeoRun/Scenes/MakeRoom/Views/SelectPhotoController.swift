//
//  SelectPhotoController.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/04/18.
//

import UIKit

class SelectPhotoController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    let photos = [#imageLiteral(resourceName: "Image-7"), #imageLiteral(resourceName: "Image-2"), #imageLiteral(resourceName: "Image-4"), #imageLiteral(resourceName: "Image-7"), #imageLiteral(resourceName: "Image-3"), #imageLiteral(resourceName: "Image-6"), #imageLiteral(resourceName: "Image-5"), #imageLiteral(resourceName: "Image"), #imageLiteral(resourceName: "Image-1")]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SelectPhotoController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as?
                PhotoCell else {
                    return UICollectionViewCell()
                }
        cell.setData(with: photos[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imgView.image = photos[indexPath.row]
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.frame.width)
        let collectionViewCellWithd = collectionView.frame.width / 3 - 1
        return CGSize(width: collectionViewCellWithd, height: collectionViewCellWithd)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
