//
//  GameItemCell.swift
//  YearEndBetting
//
//  Created by yongjun18 on 11/30/24.
//

import Foundation
import UIKit
import PinLayout

class GameItemCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "GameItemCell"
    static let cellHeight = 80.0
    static let cellMarginHorizontal = 16.0
    static let cellMarginVertical = 6.0
    
    private var rightButtonLabel = UILabel()
    private var titleLabel = UILabel()
    private var statusLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10.0
        contentView.clipsToBounds = true
        
        rightButtonLabel.backgroundColor = .systemGray5
        rightButtonLabel.textAlignment = .center
        rightButtonLabel.text = "베팅"
        rightButtonLabel.font = .systemFont(ofSize: 14)
        rightButtonLabel.textColor = .darkGray
        rightButtonLabel.layer.cornerRadius = 5.0
        rightButtonLabel.clipsToBounds = true
        contentView.addSubview(rightButtonLabel)
        
        titleLabel.text = "Round 1. 미스터리 박스"
        titleLabel.font = .systemFont(ofSize: 16)
        contentView.addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(top: GameItemCell.cellMarginVertical, left: GameItemCell.cellMarginHorizontal,
                             bottom: GameItemCell.cellMarginVertical, right: GameItemCell.cellMarginHorizontal))
        
        rightButtonLabel.pin.right(15).vCenter().width(50).height(30)
        titleLabel.pin.before(of: rightButtonLabel).left().top(12).marginLeft(15).marginRight(5).sizeToFit(.width)
    }
}
