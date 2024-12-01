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
        AmountView(),
        AmountView(),
        AmountView(),
        AmountView(),
        AmountView(),
        AmountView(),
        AmountView(),
        AmountView(),
        AmountView(),
        AmountView(),
        AmountView(),
        AmountView(),
    ]
    private var amountContainerView = UIView()
    private let cellGap = 10.0
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
            
        }
    }
}
