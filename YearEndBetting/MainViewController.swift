//
//  MainViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 11/27/24.
//

import UIKit
import PinLayout

class MainViewController: UIViewController {

    // MARK: - Properties
    
    private var upperArea = UIView()
    private var lowerArea = UIView()
    
    private var coinDescLabel = UILabel()
    private var coinAmountLabel = UILabel()
    private var greetingLabel = UILabel()
    
    private var listTitleLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(upperArea)
        self.view.addSubview(lowerArea)
        
        coinDescLabel.text = "현재 보유 코인"
        coinDescLabel.textColor = .darkGray
        coinDescLabel.sizeToFit()
        upperArea.addSubview(coinDescLabel)
        
        coinAmountLabel.text = "1,000,000 AMC"
        coinAmountLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        coinAmountLabel.sizeToFit()
        upperArea.addSubview(coinAmountLabel)
        
        greetingLabel.text = "즐거운 연말 보내세요"
        greetingLabel.font = .systemFont(ofSize: 15)
        greetingLabel.textColor = .systemGray
        greetingLabel.sizeToFit()
        upperArea.addSubview(greetingLabel)
        
        listTitleLabel.text = "진행 중인 게임 목록"
        listTitleLabel.font = .systemFont(ofSize: 16)
        lowerArea.addSubview(listTitleLabel)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upperArea.pin.top(self.view.pin.safeArea)
            .horizontally(self.view.pin.safeArea).height(200)
        lowerArea.pin.below(of: upperArea).horizontally(self.view.pin.safeArea)
            .bottom(self.view.pin.safeArea)
        
        coinDescLabel.pin.top(70).hCenter()
        coinAmountLabel.pin.bottom(70).hCenter()
        greetingLabel.pin.bottom(30).hCenter()
        
        listTitleLabel.pin.top(30).horizontally().marginHorizontal(25).sizeToFit(.width)
    }

}
