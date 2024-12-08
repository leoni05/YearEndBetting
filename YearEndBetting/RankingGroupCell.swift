//
//  RankingGroupCell.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/8/24.
//

import Foundation
import UIKit
import PinLayout

class RankingGroupCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "RankingGroupCell"
    static let cellHeight = 80.0
    static let cellMarginHorizontal = 16.0
    static let cellMarginVertical = 6.0
    
    private var titleLabel = UILabel()
    private var groupNumberLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10.0
        contentView.clipsToBounds = true
        
        titleLabel.text = "애교가 넘치는 사랑의 하츄핑"
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        contentView.addSubview(titleLabel)
        
        groupNumberLabel.text = "1조"
        groupNumberLabel.font = .systemFont(ofSize: 14, weight: .medium)
        groupNumberLabel.textColor = .darkGray
        groupNumberLabel.sizeToFit()
        contentView.addSubview(groupNumberLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(top: RankingGroupCell.cellMarginVertical, left: RankingGroupCell.cellMarginHorizontal,
                             bottom: RankingGroupCell.cellMarginVertical, right: RankingGroupCell.cellMarginHorizontal))
        
        titleLabel.pin.left(15).right(15).top(12).sizeToFit(.width)
        groupNumberLabel.pin.left(15).bottom(12)
    }
}
