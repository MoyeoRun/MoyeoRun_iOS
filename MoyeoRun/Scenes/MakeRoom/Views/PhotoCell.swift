//
//  PhotoCell.swift
//  Moyeorun
//
//  Created by 마경미 on 2022/04/18.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet var photo: UIImageView!
    
    func setData(with data: UIImage){
        photo.image = data
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder : aDecoder)
    
    }
}
