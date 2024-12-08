//
//  BettingViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/1/24.
//

import Foundation
import UIKit
import PinLayout

class BettingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var currentCoinLabel = UILabel()
    private var askingSelectionLabel = UILabel()
    private var groupListTableView = UITableView()
    private var selectedTargetLabel = UILabel()
    private var amountPlaceHolder = UILabel()
    private var amountString = ""
    private var amountLabels = Array<UILabel>()
    private var amountLabelContainer = UIView()
    private var amountKeyboardView = AmountKeyboardView()
    private var bettingButton = UIButton()
    private var backButton = UIButton()
    
    private var commaLabels = Array<UILabel>()
    private var digitLabels = Array<UILabel>()
    
    private enum NeedAnimation {
        static let none = 0
        static let needInsertAnim = 1
    }
    
    private enum AskingStatus {
        case askingTarget
        case askingAmount
        case typingAmount
    }
    private var askingStatus: AskingStatus? {
        didSet {
            switch askingStatus {
            case .askingTarget:
                askingSelectionLabel.isHidden = false
                groupListTableView.isHidden = false
                selectedTargetLabel.isHidden = true
                amountPlaceHolder.isHidden = true
                amountKeyboardView.isHidden = true
                amountLabelContainer.isHidden = true
                bettingButton.isHidden = true
            case .askingAmount:
                askingSelectionLabel.isHidden = true
                groupListTableView.isHidden = true
                selectedTargetLabel.isHidden = false
                amountPlaceHolder.isHidden = false
                amountKeyboardView.isHidden = false
                amountLabelContainer.isHidden = true
                bettingButton.isHidden = true
            case .typingAmount:
                askingSelectionLabel.isHidden = true
                groupListTableView.isHidden = true
                selectedTargetLabel.isHidden = false
                amountPlaceHolder.isHidden = true
                amountKeyboardView.isHidden = false
                amountLabelContainer.isHidden = false
                bettingButton.isHidden = false
            default:
                break
            }
        }
    }
    
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        groupListTableView.estimatedRowHeight = GroupItemCell.cellHeight
        groupListTableView.delegate = self
        groupListTableView.dataSource = self
        groupListTableView.register(GroupItemCell.self, forCellReuseIdentifier: GroupItemCell.reuseIdentifier)
        groupListTableView.separatorStyle = .none
        groupListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 6.0, right: 0)
        
        amountKeyboardView.delegate = self
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        askingStatus = .askingTarget
        
        currentCoinLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        currentCoinLabel.numberOfLines = 0
        currentCoinLabel.text = "현재 1,000,000 AMC 보유 중!"
        self.view.addSubview(currentCoinLabel)
        
        askingSelectionLabel.text = "누구에게 베팅할까요?"
        askingSelectionLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        askingSelectionLabel.numberOfLines = 0
        self.view.addSubview(askingSelectionLabel)
        
        self.view.addSubview(groupListTableView)
        
        selectedTargetLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        selectedTargetLabel.numberOfLines = 0
        let target = "애교가 넘치는 사랑의 하츄핑"
        let selectedTargetString = "\(target)에게"
        let targetAttrString = NSMutableAttributedString(string: selectedTargetString)
        let targetRange = (selectedTargetString as NSString).range(of: target)
        targetAttrString.addAttribute(.foregroundColor, value: UIColor(named: "DarkPink") as Any, range: targetRange)
        selectedTargetLabel.attributedText = targetAttrString
        self.view.addSubview(selectedTargetLabel)
        
        amountPlaceHolder.text = "얼마나 베팅할까요?"
        amountPlaceHolder.font = .systemFont(ofSize: 25, weight: .semibold)
        amountPlaceHolder.numberOfLines = 0
        amountPlaceHolder.textColor = .systemGray2
        self.view.addSubview(amountPlaceHolder)
        
        let amcLabel = UILabel()
        amcLabel.text = " AMC"
        amcLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        amcLabel.sizeToFit()
        amountLabels.append(amcLabel)
        amountLabelContainer.addSubview(amcLabel)
        self.view.addSubview(amountLabelContainer)
        
        bettingButton.setTitle("베팅하기", for: .normal)
        bettingButton.setTitleColor(.white, for: .normal)
        bettingButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        bettingButton.backgroundColor = UIColor(named: "DarkPink")
        self.view.addSubview(bettingButton)
        
        self.view.addSubview(amountKeyboardView)
        
        backButton.setImage(UIImage(systemName: "chevron.left",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)),
                              for: .normal)
        backButton.tintColor = .darkGray
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.view.addSubview(backButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
        layoutAmountLabels()
    }
    
}

// MARK: - TableView DataSource

extension BettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupItemCell.reuseIdentifier, for: indexPath) as? GroupItemCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.cellIndex = indexPath.row
        return cell
    }
}

// MARK: - TableView Delegate

extension BettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GroupItemCell.cellHeight
    }
}

// MARK: - GroupItemCellDelegate

extension BettingViewController: GroupItemCellDelegate {
    func cellContentsTouched(cellIndex: Int) {
        askingStatus = .askingAmount
        layout()
    }
}

// MARK: - AnimalKeyboardViewDelegate

extension BettingViewController: AmountKeyboardViewDelegate {
    func digitStringTouched(string: String) {
        if amountString.count == 0 && Int(string) == 0 { return }
        if amountString.count >= 9 { return }
        amountString.append(string)
        
        let pos = amountLabels.count - 1
        if pos >= 0 {
            let newLabel = popDigitLabel(digit: string)
            newLabel.tag = NeedAnimation.needInsertAnim
            amountLabels.insert(newLabel, at: pos)
        }
        setCommaLabels()
        if askingStatus == .askingAmount {
            askingStatus = .typingAmount
            layout()
            layoutAmountLabels()
        }
        else {
            layoutAmountLabels()
        }
    }
    
    func eraseDigitTouched() {
        if amountString.count == 0 { return }
        _ = amountString.popLast()
        
        let pos = amountLabels.count - 2
        if pos >= 0 {
            pushDigitLabel(digitLabel: amountLabels[pos])
            amountLabels.remove(at: pos)
        }
        setCommaLabels()
        if amountString.count == 0 {
            askingStatus = .askingAmount
            layout()
        }
        else {
            layoutAmountLabels()
        }
    }
}

// MARK: - Private Extensions

private extension BettingViewController {
    func layout() {
        currentCoinLabel.pin.top(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
            .marginTop(60).marginHorizontal(20).sizeToFit(.width)
        backButton.pin.top(self.view.pin.safeArea).left(self.view.pin.safeArea)
            .size(40).marginLeft(10)
        
        if askingStatus == .askingTarget {
            askingSelectionLabel.pin.below(of: currentCoinLabel).horizontally(self.view.pin.safeArea)
                .marginTop(15).marginHorizontal(20).sizeToFit(.width)
            groupListTableView.pin.below(of: askingSelectionLabel).horizontally(self.view.pin.safeArea).bottom()
                .marginTop(110)
        }
        if askingStatus == .askingAmount {
            selectedTargetLabel.pin.below(of: currentCoinLabel).horizontally(self.view.pin.safeArea)
                .marginTop(15).marginHorizontal(20).sizeToFit(.width)
            amountPlaceHolder.pin.below(of: selectedTargetLabel).horizontally(self.view.pin.safeArea)
                .marginTop(45).marginHorizontal(20).sizeToFit(.width)
            amountKeyboardView.pin.bottom(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
                .height(250).marginHorizontal(10).marginBottom(10)
        }
        if askingStatus == .typingAmount {
            selectedTargetLabel.pin.below(of: currentCoinLabel).horizontally(self.view.pin.safeArea)
                .marginTop(15).marginHorizontal(20).sizeToFit(.width)
            amountKeyboardView.pin.bottom(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
                .height(250).marginHorizontal(10).marginBottom(10)
            bettingButton.pin.above(of: amountKeyboardView).horizontally(self.view.pin.safeArea).height(50)
                .marginBottom(5)
        }
    }
    
    func layoutAmountLabels() {
        if askingStatus == .typingAmount {
            for i in amountLabels.indices {
                if amountLabels[i].tag == NeedAnimation.needInsertAnim {
                    amountLabels[i].tag = NeedAnimation.none
                    if i == 0 { amountLabels[i].pin.left().top() }
                    else { amountLabels[i].pin.after(of: amountLabels[i-1]).top() }
                    amountLabels[i].pin.top(-20)
                    amountLabels[i].alpha = 0.0
                    UIView.animate(withDuration: 0.3) {
                        self.amountLabels[i].pin.top(0)
                        self.amountLabels[i].alpha = 1.0
                    }
                }
                else if amountLabels[i].text != "," {
                    UIView.animate(withDuration: 0.1) {
                        if i == 0 { self.amountLabels[i].pin.left().top() }
                        else { self.amountLabels[i].pin.after(of: self.amountLabels[i-1]).top() }
                    }
                }
                else {
                    if i == 0 { self.amountLabels[i].pin.left().top() }
                    else { self.amountLabels[i].pin.after(of: self.amountLabels[i-1]).top() }
                }
            }
            amountLabelContainer.pin.wrapContent().below(of: selectedTargetLabel).left(self.view.pin.safeArea)
                .marginTop(45).marginLeft(20)
        }
    }
    
    func setCommaLabels() {
        for i in amountLabels.indices.reversed() {
            if amountLabels[i].text == "," {
                pushCommaLabel(commaLabel: amountLabels[i])
                amountLabels.remove(at: i)
            }
        }
        
        var commaPos = amountLabels.count - 4
        while commaPos > 0 {
            let commaLabel = popCommaLabel()
            amountLabels.insert(commaLabel, at: commaPos)
            commaPos -= 3
        }
    }
    
    func popDigitLabel(digit: String) -> UILabel {
        if let label = digitLabels.popLast() {
            label.isHidden = false
            label.text = digit
            label.sizeToFit()
            return label
        }
        let digitLabel = UILabel()
        digitLabel.text = digit
        digitLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        digitLabel.sizeToFit()
        amountLabelContainer.addSubview(digitLabel)
        return digitLabel
    }
    
    func pushDigitLabel(digitLabel: UILabel) {
        digitLabel.tag = NeedAnimation.none
        digitLabel.layer.removeAllAnimations()
        digitLabel.isHidden = true
        digitLabel.pin.left().right().size(0)
        digitLabels.append(digitLabel)
    }
    
    func popCommaLabel() -> UILabel {
        if let label = commaLabels.popLast() {
            label.isHidden = false
            label.sizeToFit()
            return label
        }
        let commaLabel = UILabel()
        commaLabel.text = ","
        commaLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        commaLabel.sizeToFit()
        amountLabelContainer.addSubview(commaLabel)
        return commaLabel
    }
    
    func pushCommaLabel(commaLabel: UILabel) {
        commaLabel.isHidden = true
        commaLabel.pin.left().right().size(0)
        commaLabels.append(commaLabel)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

