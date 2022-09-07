//
//  RoomView.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/08/25.
//

import UIKit

@IBDesignable
class RoomView: UIView {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var limitTime: UILabel!
    @IBOutlet weak var pace: UILabel!
    @IBOutlet weak var limitUserCount: UILabel!
    @IBOutlet weak var currentUserCount: UILabel!
    var tapGesture: UITapGestureRecognizer?

    func setData(with data: CurrentRoomListResponse) {
        name.text = data.name
        thumbnailImage.image = UIImage(named: data.thumbnailImage)
        startTime.text = "\(data.startTime)"
        distance.text = "\(data.distance)km"
        limitTime.text = "\(data.limitTime)"
        pace.text = data.pace
        limitUserCount.text = "\(data.limitUserCount)"
        currentUserCount.text = "\(data.currentUserCount)"
        thumbnailImage.addGestureRecognizer(tapGesture ?? UITapGestureRecognizer())
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
        commonInit()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        commonInit()
    }

    func commonInit() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickView))
    }

    @objc func touchToPickView() {
    }

    func xibSetup() {
        guard let view = loadViewFromNib(nib: "Room") else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    func loadViewFromNib(nib: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
