//
//  RankingViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/2/24.
//

import Foundation
import UIKit
import PinLayout

class RankingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var upperArea = UIView()
    private var rankDescLabel = UILabel()
    private var currentRankLabel = UILabel()
    private var groupNameLabel = UILabel()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(upperArea)
        
        rankDescLabel.text = "현재 코인 순위"
        rankDescLabel.textColor = .darkGray
        rankDescLabel.sizeToFit()
        upperArea.addSubview(rankDescLabel)
        
        currentRankLabel.text = "1위"
        currentRankLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        currentRankLabel.sizeToFit()
        upperArea.addSubview(currentRankLabel)
        
        groupNameLabel.text = "애교가 넘치는 사랑의 하츄핑"
        groupNameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        groupNameLabel.textColor = .systemGray
        groupNameLabel.sizeToFit()
        upperArea.addSubview(groupNameLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upperArea.pin.top(self.view.pin.safeArea)
            .horizontally(self.view.pin.safeArea).height(200)
        rankDescLabel.pin.top(70).hCenter()
        currentRankLabel.pin.bottom(70).hCenter()
        groupNameLabel.pin.bottom(30).hCenter()
    }
    
}
