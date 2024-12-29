//
//  BettingViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/1/24.
//

import Foundation
import UIKit
import PinLayout

protocol BettingViewControllerDelegate: AnyObject {
    func bettingFinished(cellIndex: Int, bettingAmount: Int)
}

class BettingViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: BettingViewControllerDelegate?
    private var currentCoinLabel = UILabel()
    private var askingSelectionLabel = UILabel()
    private var groupListTableView = UITableView()
    private var selectedTargetLabel = UILabel()
    private var amountPlaceHolder = UILabel()
    private var amountString = ""
    private var postpositionLabel = UILabel()
    private var amountLabels = Array<UILabel>()
    private var amountLabelContainer = UIView()
    private var errorLabel = UILabel()
    private var amountKeyboardView = AmountKeyboardView()
    private var nextButton = UIButton()
    private var finalButton = UIButton()
    private var finalCheckLabel = UILabel()
    private var backButton = UIButton()
    
    private var commaLabels = Array<UILabel>()
    private var digitLabels = Array<UILabel>()
    
    private var tableViewGradientView = UIView()
    private var tableViewGradientLayer = CAGradientLayer()
    
    private var currentCoin: Int
    private var selectedCellIndex: Int
    private var selectedTargetIndex: Int?
    
    private enum NeedAnimation {
        static let none = 0
        static let needInsertAnim = 1
    }
    
    private enum AskingStatus {
        case askingTarget
        case askingAmount
        case typingAmount
        case finalCheck
    }
    private var askingStatus: AskingStatus? {
        didSet {
            askingStatusDidChange()
        }
    }
    
    private let groupNames: Array<String> = [
        "애교가 넘치는 사랑의 하츄핑",
        "성실한 올바름의 바로핑",
        "용기의 아자핑",
        "너그러운 희망의 차차핑",
        "쾌활한 즐거움의 라라핑",
        "감정이 풍부한 해핑",
        "다정하고 상냥한 포실핑",
        "배려심이 깊은 샤샤핑"
    ]
    
    // MARK: - Life Cycle
    
    init(currentCoin: Int, selectedCellIndex: Int) {
        self.currentCoin = currentCoin
        self.selectedCellIndex = selectedCellIndex
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
        
        var amountOfAMC = "AMC"
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let decimalString = numberFormatter.string(for: currentCoin) {
            amountOfAMC = decimalString + " AMC"
        }
        currentCoinLabel.text = "현재 \(amountOfAMC) 보유 중!"
        self.view.addSubview(currentCoinLabel)
        
        askingSelectionLabel.text = "누구에게 베팅할까요?"
        askingSelectionLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        askingSelectionLabel.numberOfLines = 0
        self.view.addSubview(askingSelectionLabel)
        
        self.view.addSubview(groupListTableView)
        
        let colors: [CGColor] = [
           .init(red: 1, green: 1, blue: 1, alpha: 1),
           .init(red: 1, green: 1, blue: 1, alpha: 0)
        ]
        tableViewGradientLayer.colors = colors
        tableViewGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        tableViewGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.view.addSubview(tableViewGradientView)
        tableViewGradientView.layer.addSublayer(tableViewGradientLayer)
        
        selectedTargetLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        selectedTargetLabel.numberOfLines = 0
        setSelectedTargetLabel(target: "애교가 넘치는 사랑의 하츄핑")
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
        
        postpositionLabel.text = "을"
        postpositionLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        postpositionLabel.sizeToFit()
        postpositionLabel.alpha = 0.0
        postpositionLabel.isHidden = true
        amountLabels.append(postpositionLabel)
        amountLabelContainer.addSubview(postpositionLabel)
        
        self.view.addSubview(amountLabelContainer)
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        nextButton.backgroundColor = UIColor(named: "DarkPink")
        nextButton.addTarget(self, action: #selector(bettingButtonPressed), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
        finalButton.setTitle("베팅하기", for: .normal)
        finalButton.setTitleColor(.white, for: .normal)
        finalButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        finalButton.backgroundColor = UIColor(named: "DarkPink")
        finalButton.addTarget(self, action: #selector(finalButtonPressed), for: .touchUpInside)
        finalButton.layer.cornerRadius = 5.0
        finalButton.clipsToBounds = true
        self.view.addSubview(finalButton)
        
        errorLabel.text = "베팅할 코인이 보유 중인 코인보다 많아요!"
        errorLabel.textColor = UIColor(named: "DarkPink")
        errorLabel.numberOfLines = 0
        errorLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        errorLabel.isHidden = true
        self.view.addSubview(errorLabel)
        
        self.view.addSubview(amountKeyboardView)
        
        finalCheckLabel.text = "베팅하시겠어요?"
        finalCheckLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        finalCheckLabel.sizeToFit()
        self.view.addSubview(finalCheckLabel)
        
        backButton.setImage(UIImage(systemName: "chevron.left",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)),
                              for: .normal)
        backButton.tintColor = .darkGray
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped(_:)))
        edgePan.edges = .left
        self.view.addGestureRecognizer(edgePan)
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
        return groupNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupItemCell.reuseIdentifier, for: indexPath) as? GroupItemCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.cellIndex = indexPath.row
        cell.titleLabel.text = groupNames[indexPath.row]
        cell.subTitleLabel.text = "\(indexPath.row+1)조"
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
        selectedTargetIndex = cellIndex
        setSelectedTargetLabel(target: groupNames[cellIndex])
        askingStatus = .askingAmount
        layout()
    }
}

// MARK: - AnimalKeyboardViewDelegate

extension BettingViewController: AmountKeyboardViewDelegate {
    func digitStringTouched(string: String) {
        errorLabel.isHidden = true
        amountLabelContainer.layer.removeAllAnimations()
        
        if amountString.count == 0 && Int(string) == 0 { return }
        if amountString.count >= 9 {
            shakeAmountLabelContainer()
            return
        }
        amountString.append(string)
        
        let pos = amountLabels.count - 2
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
        errorLabel.isHidden = true
        amountLabelContainer.layer.removeAllAnimations()
        
        if amountString.count == 0 { return }
        _ = amountString.popLast()
        
        let pos = amountLabels.count - 3
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

// MARK: - AnimalKeyboardViewDelegate

extension BettingViewController: BettingResultViewControllerDelegate {
    func popBettingVC() {
        self.navigationController?.popViewController(animated: false)
    }
}

// MARK: - Private Extensions

private extension BettingViewController {
    @objc func screenEdgeSwiped(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .ended {
            goBackToPreviousStatus()
        }
    }
    
    @objc func backButtonPressed() {
        goBackToPreviousStatus()
    }
    
    func goBackToPreviousStatus() {
        switch askingStatus {
            
        case .askingTarget:
            self.navigationController?.popViewController(animated: true)
            
        case .askingAmount:
            askingStatus = .askingTarget
            selectedTargetIndex = nil
            
        case .typingAmount:
            askingStatus = .askingTarget
            selectedTargetIndex = nil
            eraseAlldigits()
            
        case .finalCheck:
            askingStatus = .typingAmount
            
        default:
            break
        }
        layout()
        layoutAmountLabels()
    }
    
    func eraseAlldigits() {
        errorLabel.isHidden = true
        amountLabelContainer.layer.removeAllAnimations()
        amountString = ""
        
        while true {
            let pos = amountLabels.count - 3
            if pos >= 0 {
                pushDigitLabel(digitLabel: amountLabels[pos])
                amountLabels.remove(at: pos)
            }
            else { break }
        }
        setCommaLabels()
    }
    
    func layout() {
        currentCoinLabel.pin.top(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
            .marginTop(60).marginHorizontal(20).sizeToFit(.width)
        backButton.pin.top(self.view.pin.safeArea).left(self.view.pin.safeArea)
            .size(40).marginLeft(10)
        
        if askingStatus == .askingTarget {
            askingSelectionLabel.pin.below(of: currentCoinLabel).horizontally(self.view.pin.safeArea)
                .marginTop(8).marginHorizontal(20).sizeToFit(.width)
            groupListTableView.pin.below(of: askingSelectionLabel).horizontally(self.view.pin.safeArea).bottom()
                .marginTop(110)
            tableViewGradientView.pin.top(to: groupListTableView.edge.top).horizontally().height(GroupItemCell.cellMarginVertical)
            tableViewGradientLayer.pin.all()
        }
        if askingStatus == .askingAmount {
            selectedTargetLabel.pin.below(of: currentCoinLabel).horizontally(self.view.pin.safeArea)
                .marginTop(8).marginHorizontal(20).sizeToFit(.width)
            amountPlaceHolder.pin.below(of: selectedTargetLabel).horizontally(self.view.pin.safeArea)
                .marginTop(45).marginHorizontal(20).sizeToFit(.width)
            amountKeyboardView.pin.bottom(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
                .height(250).marginHorizontal(10).marginBottom(10)
        }
        if askingStatus == .typingAmount {
            selectedTargetLabel.pin.below(of: currentCoinLabel).horizontally(self.view.pin.safeArea)
                .marginTop(8).marginHorizontal(20).sizeToFit(.width)
            amountKeyboardView.pin.bottom(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
                .height(250).marginHorizontal(10).marginBottom(10)
            nextButton.pin.above(of: amountKeyboardView).horizontally(self.view.pin.safeArea).height(50)
                .marginBottom(5)
        }
        if askingStatus == .finalCheck {
            selectedTargetLabel.pin.below(of: currentCoinLabel).horizontally(self.view.pin.safeArea)
                .marginTop(8).marginHorizontal(20).sizeToFit(.width)
            finalButton.pin.bottom(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
                .height(50).marginHorizontal(10).marginBottom(10)
        }
    }
    
    func layoutAmountLabels() {
        if askingStatus == .typingAmount || askingStatus == .finalCheck {
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
            errorLabel.pin.below(of: amountLabelContainer).horizontally(self.view.pin.safeArea)
                .marginTop(8).marginHorizontal(20).sizeToFit(.width)
            finalCheckLabel.pin.below(of: amountLabelContainer).left(self.view.pin.safeArea)
                .marginTop(8).marginLeft(20)
        }
    }
    
    func setCommaLabels() {
        for i in amountLabels.indices.reversed() {
            if amountLabels[i].text == "," {
                pushCommaLabel(commaLabel: amountLabels[i])
                amountLabels.remove(at: i)
            }
        }
        
        var commaPos = amountLabels.count - 5
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
    
    func setSelectedTargetLabel(target: String) {
        let selectedTargetString = "\(target)에게"
        let targetAttrString = NSMutableAttributedString(string: selectedTargetString)
        let targetRange = (selectedTargetString as NSString).range(of: target)
        targetAttrString.addAttribute(.foregroundColor, value: UIColor(named: "DarkPink") as Any, range: targetRange)
        selectedTargetLabel.attributedText = targetAttrString
    }
    
    func shakeAmountLabelContainer() {
        let shakeAnimation = CABasicAnimation(keyPath: "position.x")
        shakeAnimation.duration = 0.04
        shakeAnimation.repeatCount = 5
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = amountLabelContainer.center.x - 4
        shakeAnimation.toValue = amountLabelContainer.center.x + 4
        amountLabelContainer.layer.add(shakeAnimation, forKey: "position.x")
    }
    
    @objc func bettingButtonPressed() {
        guard let amount = Int(amountString) else { return }
        if amount > currentCoin {
            errorLabel.isHidden = false
            shakeAmountLabelContainer()
            return
        }
        askingStatus = .finalCheck
        layout()
    }
    
    @objc func finalButtonPressed() {
        guard let amount = Int(amountString),
              let targetIndex = selectedTargetIndex else { return }
        
        delegate?.bettingFinished(cellIndex: selectedCellIndex, bettingAmount: amount)
        let bettingResultVC = BettingResultViewController(bettingTarget: groupNames[targetIndex],
                                                          bettingAmount: amount)
        bettingResultVC.delegate = self
        bettingResultVC.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(bettingResultVC, animated: true)
    }
    
    func askingStatusDidChange() {
        switch askingStatus {
            
        case .askingTarget:
            askingSelectionLabel.isHidden = false
            groupListTableView.isHidden = false
            tableViewGradientView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.askingSelectionLabel.alpha = 1.0
                self.groupListTableView.alpha = 1.0
                self.tableViewGradientView.alpha = 1.0
            }
            selectedTargetLabel.isHidden = true
            amountPlaceHolder.isHidden = true
            amountKeyboardView.isHidden = true
            amountLabelContainer.isHidden = true
            nextButton.isHidden = true
            selectedTargetLabel.alpha = 0.0
            amountPlaceHolder.alpha = 0.0
            amountKeyboardView.alpha = 0.0
            amountLabelContainer.alpha = 0.0
            nextButton.alpha = 0.0
            postpositionLabel.isHidden = true
            finalCheckLabel.isHidden = true
            finalButton.isHidden = true
            postpositionLabel.alpha = 0.0
            finalCheckLabel.alpha = 0.0
            finalButton.alpha = 0.0
            
        case .askingAmount:
            askingSelectionLabel.isHidden = true
            groupListTableView.isHidden = true
            tableViewGradientView.isHidden = true
            amountLabelContainer.isHidden = true
            nextButton.isHidden = true
            askingSelectionLabel.alpha = 0.0
            groupListTableView.alpha = 0.0
            tableViewGradientView.alpha = 0.0
            amountLabelContainer.alpha = 0.0
            nextButton.alpha = 0.0
            selectedTargetLabel.isHidden = false
            amountPlaceHolder.isHidden = false
            amountKeyboardView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.selectedTargetLabel.alpha = 1.0
                self.amountPlaceHolder.alpha = 1.0
                self.amountKeyboardView.alpha = 1.0
            }
            postpositionLabel.isHidden = true
            finalCheckLabel.isHidden = true
            finalButton.isHidden = true
            postpositionLabel.alpha = 0.0
            finalCheckLabel.alpha = 0.0
            finalButton.alpha = 0.0
            
        case .typingAmount:
            askingSelectionLabel.isHidden = true
            groupListTableView.isHidden = true
            tableViewGradientView.isHidden = true
            amountPlaceHolder.isHidden = true
            askingSelectionLabel.alpha = 0.0
            groupListTableView.alpha = 0.0
            tableViewGradientView.alpha = 0.0
            amountPlaceHolder.alpha = 0.0
            selectedTargetLabel.isHidden = false
            amountKeyboardView.isHidden = false
            amountLabelContainer.isHidden = false
            nextButton.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.selectedTargetLabel.alpha = 1.0
                self.amountKeyboardView.alpha = 1.0
                self.amountLabelContainer.alpha = 1.0
                self.nextButton.alpha = 1.0
            }
            postpositionLabel.isHidden = true
            finalCheckLabel.isHidden = true
            finalButton.isHidden = true
            postpositionLabel.alpha = 0.0
            finalCheckLabel.alpha = 0.0
            finalButton.alpha = 0.0
            
        case .finalCheck:
            askingSelectionLabel.isHidden = true
            groupListTableView.isHidden = true
            tableViewGradientView.isHidden = true
            amountPlaceHolder.isHidden = true
            askingSelectionLabel.alpha = 0.0
            groupListTableView.alpha = 0.0
            tableViewGradientView.alpha = 0.0
            amountPlaceHolder.alpha = 0.0
            selectedTargetLabel.isHidden = false
            amountKeyboardView.isHidden = true
            amountLabelContainer.isHidden = false
            nextButton.isHidden = true
            selectedTargetLabel.alpha = 1.0
            amountKeyboardView.alpha = 0.0
            amountLabelContainer.alpha = 1.0
            nextButton.alpha = 0.0
            postpositionLabel.isHidden = false
            finalCheckLabel.isHidden = false
            finalButton.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.postpositionLabel.alpha = 1.0
                self.finalCheckLabel.alpha = 1.0
                self.finalButton.alpha = 1.0
            }
            
        default:
            break
        }
    }
}

