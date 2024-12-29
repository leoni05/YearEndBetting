//
//  BettingResultViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/29/24.
//

import Foundation
import UIKit
import PinLayout

protocol BettingResultViewControllerDelegate: AnyObject {
    func popBettingVC()
}

class BettingResultViewController: UIViewController {
    
    // MARK: - Properties
 
    weak var delegate: BettingResultViewControllerDelegate?
    var bettingTarget: String
    var bettingAmount: Int
    private var bettingFinishLabel = UILabel()
    private var okButton = UIButton()
    
    // MARK: - Life Cycle
    
    init(bettingTarget: String, bettingAmount: Int) {
        self.bettingTarget = bettingTarget
        self.bettingAmount = bettingAmount
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        var amountOfAMC = "AMC"
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let decimalString = numberFormatter.string(for: bettingAmount) {
            amountOfAMC = decimalString + " AMC"
        }
        
        bettingFinishLabel.font = .systemFont(ofSize: 22, weight: .medium)
        bettingFinishLabel.numberOfLines = 0
        
        let finishString = "\(bettingTarget)에게\n\(amountOfAMC)\n베팅 완료!"
        let finishAttrString = NSMutableAttributedString(string: finishString)
        let targetRange = (finishString as NSString).range(of: bettingTarget)
        finishAttrString.addAttribute(.foregroundColor, value: UIColor(named: "DarkPink") as Any, range: targetRange)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 4
        finishAttrString.addAttribute(NSAttributedString.Key.paragraphStyle, 
                                      value: paragraphStyle,
                                      range: NSMakeRange(0, finishAttrString.length))
        
        bettingFinishLabel.attributedText = finishAttrString
        bettingFinishLabel.sizeToFit()
        self.view.addSubview(bettingFinishLabel)
        
        okButton.setTitle("확인", for: .normal)
        okButton.setTitleColor(.white, for: .normal)
        okButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        okButton.backgroundColor = UIColor(named: "DarkPink")
        okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        okButton.layer.cornerRadius = 5.0
        okButton.clipsToBounds = true
        self.view.addSubview(okButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bettingFinishLabel.pin.top(self.view.pin.safeArea).hCenter().marginTop(100)
        okButton.pin.bottom(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
            .height(50).marginHorizontal(10).marginBottom(10)
    }
}

private extension BettingResultViewController {
    @objc func okButtonPressed() {
        delegate?.popBettingVC()
        self.dismiss(animated: true)
    }
}
