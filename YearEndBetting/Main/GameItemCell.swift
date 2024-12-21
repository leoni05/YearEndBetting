//
//  GameItemCell.swift
//  YearEndBetting
//
//  Created by yongjun18 on 11/30/24.
//

import Foundation
import UIKit
import PinLayout

protocol GameItemCellDelegate: AnyObject {
    func cellContentsTouched(cellIndex: Int, gameStatus: GameItemCell.GameStatus?)
}

class GameItemCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "GameItemCell"
    static let cellHeight = 80.0
    static let cellMarginHorizontal = 16.0
    static let cellMarginVertical = 6.0
    
    weak var delegate: GameItemCellDelegate?
    
    enum GameStatus {
        case beforeBetting
        case inProgress
        case gameEnded
    }
    var gameStatus: GameStatus? {
        didSet {
            switch gameStatus {
            case .beforeBetting:
                rightButtonLabel.text = "베팅"
            case .inProgress:
                rightButtonLabel.text = "진행중"
            case .gameEnded:
                rightButtonLabel.text = "결과"
            default:
                break
            }
        }
    }
    
    private var containerView = UIView()
    private var rightButtonLabel = UILabel()
    private var titleLabel = UILabel()
    private var statusLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 10.0
        containerView.clipsToBounds = true
        contentView.addSubview(containerView)
        
        rightButtonLabel.backgroundColor = .systemGray5
        rightButtonLabel.textAlignment = .center
        rightButtonLabel.text = "베팅"
        rightButtonLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        rightButtonLabel.textColor = .darkGray
        rightButtonLabel.layer.cornerRadius = 5.0
        rightButtonLabel.clipsToBounds = true
        containerView.addSubview(rightButtonLabel)
        
        titleLabel.text = "Round 1. 미스터리 박스"
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        containerView.addSubview(titleLabel)
        
        statusLabel.font = .systemFont(ofSize: 14, weight: .medium)
        statusLabel.textColor = .darkGray
        let changeOfAMC = "+500,102 AMC"
        let statusString = "게임 1위, 예측 결과 2위 \(changeOfAMC)"
        let attrString = NSMutableAttributedString(string: statusString)
        let range = (statusString as NSString).range(of: changeOfAMC)
        attrString.addAttribute(.foregroundColor, value: UIColor.systemRed as Any, range: range)
        statusLabel.attributedText = attrString
        containerView.addSubview(statusLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cellContentsTouched(_:)))
        gesture.numberOfTapsRequired = 1
        contentView.addGestureRecognizer(gesture)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(top: GameItemCell.cellMarginVertical, left: GameItemCell.cellMarginHorizontal,
                             bottom: GameItemCell.cellMarginVertical, right: GameItemCell.cellMarginHorizontal))
        containerView.pin.all()
        
        rightButtonLabel.pin.right(15).vCenter().width(50).height(30)
        titleLabel.pin.before(of: rightButtonLabel).left(15).top(12).marginRight(5).sizeToFit(.width)
        statusLabel.pin.before(of: rightButtonLabel).left(15).bottom(12).marginRight(5).sizeToFit(.width)
    }
}

// MARK: - Private Extensions

private extension GameItemCell {
    @objc func cellContentsTouched(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            self.delegate?.cellContentsTouched(cellIndex: view.tag, gameStatus: gameStatus)
        }
    }
}
