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
    
    private var leftLaurelView = UIImageView()
    private var rightLaurelView = UIImageView()
    
    
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
        
        leftLaurelView.contentMode = .scaleAspectFit
        leftLaurelView.tintColor = .systemGray3
        leftLaurelView.image = UIImage(systemName: "laurel.leading")
        upperArea.addSubview(leftLaurelView)
        
        rightLaurelView.contentMode = .scaleAspectFit
        rightLaurelView.tintColor = .systemGray3
        rightLaurelView.image = UIImage(systemName: "laurel.trailing")
        upperArea.addSubview(rightLaurelView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upperArea.pin.top(self.view.pin.safeArea)
            .horizontally(self.view.pin.safeArea).height(200)
        rankDescLabel.pin.top(70).hCenter()
        currentRankLabel.pin.bottom(70).hCenter()
        groupNameLabel.pin.bottom(30).hCenter()
        leftLaurelView.pin.before(of: currentRankLabel).vCenter(to: currentRankLabel.edge.vCenter)
            .size(30).marginRight(5)
        rightLaurelView.pin.after(of: currentRankLabel).vCenter(to: currentRankLabel.edge.vCenter)
            .size(30).marginLeft(5)
    }
    
}
