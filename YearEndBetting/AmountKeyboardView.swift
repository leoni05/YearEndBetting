//
//  AmountKeyboardView.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/1/24.
//

import Foundation
import UIKit
import PinLayout

protocol AmountKeyboardViewDelegate: AnyObject {
    func digitStringTouched(string: String)
    func eraseDigitTouched()
}

class AmountKeyboardView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: AmountKeyboardViewDelegate?
    private var amountViews: Array<AmountView> = [
        AmountView(buttonRole: .push, valueForPush: "1"),
        AmountView(buttonRole: .push, valueForPush: "2"),
        AmountView(buttonRole: .push, valueForPush: "3"),
        AmountView(buttonRole: .push, valueForPush: "4"),
        AmountView(buttonRole: .push, valueForPush: "5"),
        AmountView(buttonRole: .push, valueForPush: "6"),
        AmountView(buttonRole: .push, valueForPush: "7"),
        AmountView(buttonRole: .push, valueForPush: "8"),
        AmountView(buttonRole: .push, valueForPush: "9"),
        AmountView(buttonRole: .push, valueForPush: "00"),
        AmountView(buttonRole: .push, valueForPush: "0"),
        AmountView(buttonRole: .pop),
    ]
    private var amountContainerView = UIView()
    private let cellGap = 5.0
    private let columnCnt = 3
    
    // MARK: - Life Cycle
    
    init() {
        super.init(frame: .zero)
        
        for idx in amountViews.indices {
            amountContainerView.addSubview(amountViews[idx])
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(amountViewTouched(_:)))
            gesture.numberOfTapsRequired = 1
            amountViews[idx].addGestureRecognizer(gesture)
        }
        self.addSubview(amountContainerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rowCnt = (amountViews.count + columnCnt - 1) / columnCnt
        let cellWidth = (self.frame.size.width - (cellGap * Double(columnCnt - 1))) / Double(columnCnt)
        let cellHeight = (self.frame.size.height - (cellGap * Double(rowCnt - 1))) / Double(rowCnt)
        if cellWidth < 0 || cellHeight < 0 {
            return
        }

        for idx in amountViews.indices {
            let r = idx / columnCnt
            let c = idx % columnCnt
            var x = 0.0
            var y = 0.0
            if c > 0 { x = amountViews[idx - 1].frame.maxX + cellGap }
            if r > 0 { y = amountViews[idx - columnCnt].frame.maxY + cellGap }
            amountViews[idx].pin.top(y).left(x).width(cellWidth).height(cellHeight)
        }
        amountContainerView.pin.wrapContent().center()
    }
}

// MARK: - Private Extensions

private extension AmountKeyboardView {
    @objc func amountViewTouched(_ sender: UITapGestureRecognizer) {
        if let view = sender.view as? AmountView {
            if view.buttonRole == .push {
                if let string = view.valueForPush {
                    for i in string.indices {
                        self.delegate?.digitStringTouched(string: String(string[i]))
                    }
                }
            }
            if view.buttonRole == .pop {
                self.delegate?.eraseDigitTouched()
            }
        }
    }
}
