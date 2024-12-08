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
    static let cellHeight = 80.0
    static let cellMarginHorizontal = 16.0
    static let cellMarginVertical = 6.0
    
    private var groupLabel = UILabel()
    private var onePickLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10.0
        contentView.clipsToBounds = true
        
        groupLabel.text = "애교가 넘치는 사랑의 하츄핑"
        groupLabel.font = .systemFont(ofSize: 16, weight: .medium)
        contentView.addSubview(groupLabel)
        
        onePickLabel.text = "1조"
        onePickLabel.font = .systemFont(ofSize: 14, weight: .medium)
        onePickLabel.textColor = .darkGray
        contentView.addSubview(onePickLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(top: ResultGroupCell.cellMarginVertical, left: ResultGroupCell.cellMarginHorizontal,
                             bottom: ResultGroupCell.cellMarginVertical, right: ResultGroupCell.cellMarginHorizontal))
        
        groupLabel.pin.horizontally(15).top(12).sizeToFit(.width)
        onePickLabel.pin.horizontally(15).bottom(12).sizeToFit(.width)
    }
}

