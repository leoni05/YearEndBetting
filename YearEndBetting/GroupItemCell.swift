//
//  GroupItemCell.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/1/24.
//

import Foundation
import UIKit
import PinLayout

class GroupItemCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "GroupItemCell"
    static let cellHeight = 80.0
    static let cellMarginHorizontal = 16.0
    static let cellMarginVertical = 6.0
    
    private var titleLabel = UILabel()
    private var subTitleLabel = UILabel()
    
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
        
        subTitleLabel.text = "1조"
        subTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        subTitleLabel.textColor = .darkGray
        contentView.addSubview(subTitleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(top: GroupItemCell.cellMarginVertical, left: GroupItemCell.cellMarginHorizontal,
                             bottom: GroupItemCell.cellMarginVertical, right: GroupItemCell.cellMarginHorizontal))
        
        titleLabel.pin.horizontally(15).top(12).sizeToFit(.width)
        subTitleLabel.pin.horizontally(15).bottom(12).sizeToFit(.width)
    }
}

