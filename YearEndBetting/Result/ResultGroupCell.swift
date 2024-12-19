//
//  ResultGroupCell.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/8/24.
//

import Foundation
import UIKit
import PinLayout

class ResultGroupCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ResultGroupCell"
    static let cellHeight = 140.0
    static let cellMarginHorizontal = 16.0
    static let cellMarginVertical = 6.0
    
    private var groupLabel = UILabel()
    private var gameRankLabel = UILabel()
    private var onePickLabel = UILabel()
    private var winRewardLabel = UILabel()
    private var betAmountLabel = UILabel()
    private var betRewardLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10.0
        contentView.clipsToBounds = true
        
        gameRankLabel.text = "게임 1위"
        gameRankLabel.font = .systemFont(ofSize: 16, weight: .medium)
        gameRankLabel.textColor = .systemGray2
        gameRankLabel.sizeToFit()
        contentView.addSubview(gameRankLabel)
        
        groupLabel.text = "애교가 넘치는 사랑의 하츄핑 (1조)"
        groupLabel.font = .systemFont(ofSize: 16, weight: .medium)
        groupLabel.textColor = UIColor(named: "DarkPink")
        contentView.addSubview(groupLabel)
        
        onePickLabel.text = "우리의 원픽   애교가 넘치는 사랑의 하츄핑 (1조)"
        onePickLabel.font = .systemFont(ofSize: 14, weight: .medium)
        onePickLabel.textColor = .darkGray
        contentView.addSubview(onePickLabel)
        
        winRewardLabel.text = "승리 보상   +500,000 AMC"
        winRewardLabel.font = .systemFont(ofSize: 14, weight: .medium)
        winRewardLabel.textColor = .darkGray
        contentView.addSubview(winRewardLabel)
        
        betAmountLabel.text = "베팅 코인   500,000 AMC"
        betAmountLabel.font = .systemFont(ofSize: 14, weight: .medium)
        betAmountLabel.textColor = .darkGray
        contentView.addSubview(betAmountLabel)
        
        betRewardLabel.text = "베팅 보상   +500,000 AMC"
        betRewardLabel.font = .systemFont(ofSize: 14, weight: .medium)
        betRewardLabel.textColor = .darkGray
        contentView.addSubview(betRewardLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(top: ResultGroupCell.cellMarginVertical, left: ResultGroupCell.cellMarginHorizontal,
                             bottom: ResultGroupCell.cellMarginVertical, right: ResultGroupCell.cellMarginHorizontal))
        
        gameRankLabel.pin.right(15).top(12)
        groupLabel.pin.left(15).before(of: gameRankLabel, aligned: .center).sizeToFit(.width)
        onePickLabel.pin.horizontally(15).bottom(72).sizeToFit(.width)
        winRewardLabel.pin.horizontally(15).bottom(52).sizeToFit(.width)
        betAmountLabel.pin.horizontally(15).bottom(32).sizeToFit(.width)
        betRewardLabel.pin.horizontally(15).bottom(12).sizeToFit(.width)
    }
}

