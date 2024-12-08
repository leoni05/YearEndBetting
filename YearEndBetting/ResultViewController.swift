//
//  ResultViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/8/24.
//

import Foundation
import UIKit
import PinLayout

class ResultViewController: UIViewController {
    
    // MARK: - Properties
    
    private var upperArea = UIView()
    private var resultDescLabel = UILabel()
    private var currentRankLabel = UILabel()
    private var winRewardLabel = UILabel()
    private var onePickLabel = UILabel()
    private var betAmountLabel = UILabel()
    private var betRewardLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white   
        
        self.view.addSubview(upperArea)
        
        resultDescLabel.text = "게임 결과"
        resultDescLabel.textColor = .darkGray
        resultDescLabel.sizeToFit()
        upperArea.addSubview(resultDescLabel)
        
        currentRankLabel.text = "1위"
        currentRankLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        currentRankLabel.sizeToFit()
        upperArea.addSubview(currentRankLabel)
        
        winRewardLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        winRewardLabel.textColor = .systemGray
        let winReward = "+500,100 AMC"
        let winRewardString = "승리 보상    \(winReward)"
        let winRewardAttrString = NSMutableAttributedString(string: winRewardString)
        let winRewardRange = (winRewardString as NSString).range(of: winReward)
        winRewardAttrString.addAttribute(.foregroundColor, value: UIColor.black as Any, range: winRewardRange)
        winRewardLabel.attributedText = winRewardAttrString
        winRewardLabel.sizeToFit()
        upperArea.addSubview(winRewardLabel)
        
        onePickLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        onePickLabel.textColor = .systemGray
        let onePick = "애교가 넘치는 사랑의 하츄핑 (1조)"
        let onePickString = "우리의 원픽    \(onePick)"
        let onePickAttrString = NSMutableAttributedString(string: onePickString)
        let onePickRange = (onePickString as NSString).range(of: onePick)
        onePickAttrString.addAttribute(.foregroundColor, value: UIColor(named: "DarkPink") as Any, range: onePickRange)
        onePickLabel.attributedText = onePickAttrString
        onePickLabel.sizeToFit()
        upperArea.addSubview(onePickLabel)
        
        betAmountLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        betAmountLabel.textColor = .systemGray
        let amount = "500,100 AMC"
        let amountString = "베팅 코인    \(amount)"
        let amountAttrString = NSMutableAttributedString(string: amountString)
        let amountRange = (amountString as NSString).range(of: amount)
        amountAttrString.addAttribute(.foregroundColor, value: UIColor.black as Any, range: amountRange)
        betAmountLabel.attributedText = amountAttrString
        betAmountLabel.sizeToFit()
        upperArea.addSubview(betAmountLabel)
        
        betRewardLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        betRewardLabel.textColor = .systemGray
        let betReward = "+500,100 AMC"
        let betRewardString = "베팅 보상    \(betReward)"
        let betRewardAttrString = NSMutableAttributedString(string: betRewardString)
        let betRewardRange = (betRewardString as NSString).range(of: betReward)
        betRewardAttrString.addAttribute(.foregroundColor, value: UIColor.black as Any, range: betRewardRange)
        betRewardLabel.attributedText = betRewardAttrString
        betRewardLabel.sizeToFit()
        upperArea.addSubview(betRewardLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upperArea.pin.top(self.view.pin.safeArea)
            .horizontally(self.view.pin.safeArea).height(200)
        resultDescLabel.pin.top(30).hCenter()
        currentRankLabel.pin.bottom(110).hCenter()
        winRewardLabel.pin.below(of: currentRankLabel).hCenter().marginTop(15)
        onePickLabel.pin.below(of: winRewardLabel).hCenter().marginTop(10)
        betAmountLabel.pin.below(of: onePickLabel).hCenter().marginTop(5)
        betRewardLabel.pin.below(of: betAmountLabel).hCenter().marginTop(5)
    }
}
