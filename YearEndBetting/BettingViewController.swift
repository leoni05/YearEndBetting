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
    
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        currentCoinLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        currentCoinLabel.numberOfLines = 0
        let currentAMC = "1,000,000 AMC"
        let currentCoinString = "현재 \(currentAMC) 보유 중!"
        let attrString = NSMutableAttributedString(string: currentCoinString)
        let range = (currentCoinString as NSString).range(of: currentAMC)
        attrString.addAttribute(.foregroundColor, value: UIColor(named: "DarkPink") as Any, range: range)
        currentCoinLabel.attributedText = attrString
        self.view.addSubview(currentCoinLabel)
        
        askingSelectionLabel.text = "누구에게 베팅할까요?"
        askingSelectionLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        askingSelectionLabel.numberOfLines = 0
        self.view.addSubview(askingSelectionLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        currentCoinLabel.pin.top(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
            .marginTop(60).marginHorizontal(20).sizeToFit(.width)
        askingSelectionLabel.pin.below(of: currentCoinLabel).horizontally(self.view.pin.safeArea)
            .marginTop(15).marginHorizontal(20).sizeToFit(.width)
    }
    
}
