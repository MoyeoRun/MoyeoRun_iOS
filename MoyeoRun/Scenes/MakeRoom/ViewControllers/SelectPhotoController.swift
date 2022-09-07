//
//  SelectPhotoController.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/04/18.
//

import UIKit

class SelectPhotoController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    var selectedImage = "IMAGE2"
    weak var dataDelegate: SendDataDelegate?

    let photos = [
        "IMAGE1", "IMAGE2", "IMAGE3", "IMAGE4", "IMAGE5", "IMAGE6", "IMAGE7", "IMAGE8", "IMAGE9"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func clickComplete(_ sender: UIButton) {
        self.dataDelegate?.sendImage(image: selectedImage)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension SelectPhotoController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
            as? PhotoCell
        else {
            return UICollectionViewCell()
        }
        cell.setData(with: photos[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imgView.image = UIImage(named: photos[indexPath.row])
        selectedImage = photos[indexPath.row]
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewCellWidth = collectionView.frame.width / 3
        return CGSize(width: collectionViewCellWidth - 4, height: collectionViewCellWidth - 4)
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
