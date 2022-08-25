//
//  HomeTopCell.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/08/25.
//

import UIKit

class HomeTopCell: UICollectionViewCell {

    static let cellId = "homeTopCellId"

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var makeRoomButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        xibSetup()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        xibSetup()
//    }
//
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        xibSetup()
//    }
//
//    func xibSetup() {
//        guard let view = loadViewFromNib(nib: "HomeTopCell") else {
//            return
//        }
//        view.frame = bounds
//        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        addSubview(view)
//    }
//
//    func loadViewFromNib(nib: String) -> UICollectionViewCell? {
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: nib, bundle: bundle)
//        return nib.instantiate(withOwner: self, options: nil).first as? UICollectionViewCell
//    }
}
