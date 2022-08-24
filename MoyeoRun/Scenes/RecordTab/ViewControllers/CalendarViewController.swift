//
//  CalendarViewController.swift
//  MoyeoRun
//
//  Created by 김상현 on 2022/06/24.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var completeButton: UIButton!
    @IBOutlet var calendarView: FSCalendar!
    @IBOutlet var calendarBackgroundView: UIView!
    let calendar = Calendar.current
    let gregorian = Calendar(identifier: .gregorian)
    lazy var currentPage = calendarView.currentPage
    lazy var today: Date = {
        return Date()
    }()
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 YYYY년"
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.setUI()
            self.cancelButton.layer.borderWidth = 1
            self.cancelButton.layer.borderColor = DefinedColor.borderColor1?.cgColor
            self.cancelButton.layer.cornerRadius = 4
            self.completeButton.layer.cornerRadius = 4
        }
    }

    private func setUI() {
        self.setCalendar()
    }

    private func setCalendar() {
        calendarBackgroundView.layer.cornerRadius = 12
        calendarView.locale = Locale(identifier: "ko_KR")

        // MARK: Custom Header
        calendarView.appearance.headerDateFormat = "M월 YYYY년"
        calendarView.appearance.headerMinimumDissolvedAlpha = 0
        calendarView.placeholderType = .none

        calendarView.headerHeight = Screen.height * 0.08
        calendarView.weekdayHeight = Screen.height * 0.04
        calendarView.appearance.headerTitleOffset = .init(x: -Screen.width * 0.15, y: 0)

        calendarView.today = nil
        calendarView.appearance.headerTitleFont = .systemFont(ofSize: 22, weight: .semibold)
        calendarView.appearance.titleFont = .systemFont(ofSize: 15, weight: .medium)
        calendarView.appearance.weekdayFont = .systemFont(ofSize: 18, weight: .bold)
        calendarView.register(CalendarCell.self, forCellReuseIdentifier: "cell")
    }

    @IBAction func moveToNextMonth(_ sender: Any) {
        var dateComponents = DateComponents()
            dateComponents.month = 1
        guard let calendarDate = calendar.date(byAdding: dateComponents, to: self.currentPage) else { return }
        self.currentPage = calendarDate
        self.calendarView.setCurrentPage(self.currentPage, animated: true)
    }

    @IBAction func moveToPreviousMonth(_ sender: Any) {
        var dateComponents = DateComponents()
            dateComponents.month = -1
        guard let calendarDate = calendar.date(byAdding: dateComponents, to: self.currentPage) else { return }
        self.currentPage = calendarDate
        self.calendarView.setCurrentPage(self.currentPage, animated: true)
    }

    @IBAction func onTapBackground(_ sender: Any) {
        self.dismiss(animated: false)
    }

    // MARK: private func
    internal func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.currentPage = calendar.currentPage
    }
}

extension CalendarViewController {
    func configureVisibleCells() {
        self.calendarView.visibleCells().forEach { cell in
            let date = self.calendarView.date(for: cell)
            let position = self.calendarView.monthPosition(for: cell)
            self.configureCell(cell, for: date, at: position)
        }
    }

    func configureCell(_ cell: FSCalendarCell?, for date: Date?, at position: FSCalendarMonthPosition) {
        guard let diyCell = cell as? CalendarCell else { return }
        guard let date = date else { return }
        if position == .current {
            var selectionType = SelectionType.none

            if calendarView.selectedDates.count == 2 {
                var first = calendarView.selectedDates[0]
                var second = calendarView.selectedDates[1]
                if second <= first {
                    let temp = first
                    first = second
                    second = temp
                }
                if date == first {
                    selectionType = .leftBorder
                } else if date == second {
                    selectionType = .rightBorder
                } else if date >= first && date <= second {
                    selectionType = .middle
                }
            } else {
                for selectedDate in calendarView.selectedDates {
                    if date == today {
                        selectionType = .today
                        diyCell.appearance.todayColor = UIColor(named: "DarkGray")
                    }
                    if date == selectedDate {
                        selectionType = .single
                    }
                }
            }

            diyCell.selectionLayer?.isHidden = false
            diyCell.selectionType = selectionType
        } else {
            diyCell.selectionLayer?.isHidden = true
            diyCell.titleLabel.textColor = DefinedColor.lightGray
        }
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarView.frame.size.height = bounds.height
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if calendar.selectedDates.count == 3 {
            var first = calendar.selectedDates[0]
            var second = calendar.selectedDates[1]
            if second <= first {
                let temp = first
                first = second
                second = temp
            }
            if date > second {
                calendar.deselect(second)
            } else if date < first {
                calendar.deselect(first)
            } else if date > first && date < second {
                if date.timeIntervalSince(first) > second.timeIntervalSince(date) {
                    calendar.deselect(second)
                } else {
                    calendar.deselect(first)
                }
            }
        }
        configureVisibleCells()
    }

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }

    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.configureCell(cell, for: date, at: monthPosition)
    }

    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == FSCalendarMonthPosition.current
    }

    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return true
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        configureVisibleCells()
    }
}

enum SelectionType {
    case none
    case today
    case single
    case leftBorder
    case middle
    case rightBorder
}

class CalendarCell: FSCalendarCell {
    weak var circleImageView: UIImageView?
    weak var selectionLayer: CAShapeLayer?
    weak var roundedLayer: CAShapeLayer?
    weak var todayLayer: CAShapeLayer?

    var selectionType: SelectionType = .none {
        didSet {
            setNeedsLayout()
        }
    }

    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    private func commonInit() {
        let selectionLayer = CAShapeLayer()
        selectionLayer.fillColor = DefinedColor.runBlue2?.cgColor
        selectionLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(selectionLayer, below: self.titleLabel?.layer)
        self.selectionLayer = selectionLayer

        let roundedLayer = CAShapeLayer()
        roundedLayer.fillColor = DefinedColor.runBlue?.cgColor
        roundedLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(roundedLayer, below: self.titleLabel?.layer)
        self.roundedLayer = roundedLayer

        let todayLayer = CAShapeLayer()
        todayLayer.fillColor = DefinedColor.lightGray?.cgColor
        todayLayer.strokeColor = UIColor.lightGray.cgColor
        todayLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(todayLayer, below: self.titleLabel?.layer)
        self.todayLayer = todayLayer

        self.shapeLayer.isHidden = true
        let view = UIView(frame: self.bounds)
        self.backgroundView = view
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.selectionLayer?.frame = self.titleLabel.bounds
        self.roundedLayer?.frame = self.titleLabel.bounds
        self.todayLayer?.frame = self.titleLabel.bounds

        let contentHeight = self.titleLabel.frame.height
        let contentWidth = self.titleLabel.frame.width

        let selectionLayerBounds = selectionLayer?.bounds ?? .zero
        let selectionLayerWidth = selectionLayer?.bounds.width ?? .zero
        let roundedLayerHeight = roundedLayer?.frame.height ?? .zero
        let roundedLayerWidth = roundedLayer?.frame.width ?? .zero

        switch selectionType {
        case .middle:
            self.selectionLayer?.isHidden = false
            self.roundedLayer?.isHidden = true
            self.todayLayer?.isHidden = true

            let selectionRect = selectionLayerBounds
                .insetBy(dx: 0.0, dy: 4)
            self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath

        case .leftBorder:
            self.selectionLayer?.isHidden = false
            self.roundedLayer?.isHidden = false
            self.todayLayer?.isHidden = true

            let selectionRect = selectionLayerBounds
                .insetBy(dx: selectionLayerWidth / 4, dy: 4)
                .offsetBy(dx: selectionLayerWidth / 4, dy: 0.0)
            self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath

            let diameter: CGFloat = min(roundedLayerHeight, roundedLayerWidth)
            let rect = CGRect(x: contentWidth / 2 - diameter / 2, y: contentHeight / 2 - diameter / 2, width: diameter, height: diameter)
                .insetBy(dx: 2.5, dy: 2.5)
            self.roundedLayer?.path = UIBezierPath(ovalIn: rect).cgPath

        case .rightBorder:
            self.selectionLayer?.isHidden = false
            self.roundedLayer?.isHidden = false
            self.todayLayer?.isHidden = true

            let selectionRect = selectionLayerBounds
                .insetBy(dx: selectionLayerWidth / 4, dy: 4)
                .offsetBy(dx: -selectionLayerWidth / 4, dy: 0.0)
            self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath

            let diameter: CGFloat = min(roundedLayerHeight, roundedLayerWidth)
            let rect = CGRect(x: contentWidth / 2 - diameter / 2, y: contentHeight / 2 - diameter / 2, width: diameter, height: diameter)
                .insetBy(dx: 2.5, dy: 2.5)
            self.roundedLayer?.path = UIBezierPath(ovalIn: rect).cgPath

        case .single:
            self.selectionLayer?.isHidden = true
            self.roundedLayer?.isHidden = false
            self.todayLayer?.isHidden = true

            let diameter: CGFloat = min(roundedLayerHeight, roundedLayerWidth)
            let rect = CGRect(x: contentWidth / 2 - diameter / 2, y: contentHeight / 2 - diameter / 2, width: diameter, height: diameter)
                .insetBy(dx: 2.5, dy: 2.5)
            self.roundedLayer?.path = UIBezierPath(ovalIn: rect).cgPath

        case .today:
            self.selectionLayer?.isHidden = true
            self.roundedLayer?.isHidden = true
            self.todayLayer?.isHidden = true

            let diameter: CGFloat = min(roundedLayerHeight, roundedLayerWidth)
            let rect = CGRect(x: contentWidth / 2 - diameter / 2, y: contentHeight / 2 - diameter / 2, width: diameter, height: diameter)
                .insetBy(dx: 2.5, dy: 2.5)
            self.todayLayer?.path = UIBezierPath(ovalIn: rect).cgPath

        case .none:
            self.selectionLayer?.isHidden = true
            self.roundedLayer?.isHidden = true
            self.todayLayer?.isHidden = true
        }
    }
}
