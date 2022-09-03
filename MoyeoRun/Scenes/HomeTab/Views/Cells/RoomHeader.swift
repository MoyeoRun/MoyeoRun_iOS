//
//  RoomHeader.swift
//  MoyeoRun
//
//  Created by 마경미 on 2022/08/25.
//

import UIKit

class RoomHeader: UICollectionReusableView {
    static let headerId = "roomHeaderId"
    @IBOutlet weak var currentRunning: UIButton!
    @IBOutlet weak var joining: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func touchCurrentRunning(_ sender: UIButton) {
        currentRunning.backgroundColor = UIColor(hexString: "#1162FF")
        currentRunning.tintColor = .white
        joining.backgroundColor = UIColor.clear
        joining.tintColor = UIColor(hexString: "#1162FF")
    }

    @IBAction func touchJoining(_ sender: UIButton) {
        joining.backgroundColor = UIColor(hexString: "#1162FF")
        joining.tintColor = .white
        currentRunning.backgroundColor = UIColor.clear
        currentRunning.tintColor = UIColor(hexString: "#1162FF")
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: CGFloat(alpha) / 255)
    }
}
