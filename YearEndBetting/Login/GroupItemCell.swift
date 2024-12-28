//
//  GroupItemCell.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/1/24.
//

import Foundation
import UIKit
import PinLayout

protocol GroupItemCellDelegate: AnyObject {
    func cellContentsTouched(cellIndex: Int)
}

class GroupItemCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "GroupItemCell"
    static let cellHeight = 80.0
    static let cellMarginHorizontal = 16.0
    static let cellMarginVertical = 6.0
    
    var cellIndex: Int?
    weak var delegate: GroupItemCellDelegate?

    private var containerView = UIView()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 10.0
        containerView.clipsToBounds = true
        contentView.addSubview(containerView)
        
        titleLabel.text = "애교가 넘치는 사랑의 하츄핑"
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        containerView.addSubview(titleLabel)
        
        subTitleLabel.text = "1조"
        subTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        subTitleLabel.textColor = .darkGray
        containerView.addSubview(subTitleLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellContentsTouched(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.delegate = self
        contentView.addGestureRecognizer(tapGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(cellContentsLongPressed(_:)))
        longPressGesture.minimumPressDuration = 0
        longPressGesture.delegate = self
        contentView.addGestureRecognizer(longPressGesture)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(top: GroupItemCell.cellMarginVertical, left: GroupItemCell.cellMarginHorizontal,
                             bottom: GroupItemCell.cellMarginVertical, right: GroupItemCell.cellMarginHorizontal))
        containerView.pin.all()
        
        titleLabel.pin.horizontally(15).top(12).sizeToFit(.width)
        subTitleLabel.pin.horizontally(15).bottom(12).sizeToFit(.width)
    }
}

// MARK: - UIGestureRecognizer Delegate

extension GroupItemCell {
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - Private Extensions

private extension GroupItemCell {
    @objc func cellContentsTouched(_ sender: UITapGestureRecognizer) {
        if let idx = cellIndex {
            delegate?.cellContentsTouched(cellIndex: idx)
        }
    }
    
    @objc func cellContentsLongPressed(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: 0.1) {
                self.containerView.backgroundColor = .systemGray5
                self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
            }
            return
        }
        UIView.animate(withDuration: 0.1) {
            self.containerView.backgroundColor = .systemGray6
            self.containerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }
    }

}

