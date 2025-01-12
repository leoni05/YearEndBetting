//
//  AmountView.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/1/24.
//

import Foundation
import UIKit
import PinLayout

class AmountView: UIView {
 
    // MARK: - Properties

    enum ButtonRole {
        case push
        case pop
    }
    var buttonRole: ButtonRole?
    var valueForPush: String?
    
    private var labelForPush: UILabel?
    private var imageViewForPop: UIImageView?
    
    // MARK: - Life Cycle
    
    init(buttonRole: ButtonRole, valueForPush: String? = nil) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        self.buttonRole = buttonRole
        self.valueForPush = valueForPush
        
        switch buttonRole {
        case .push:
            let label = UILabel()
            label.text = self.valueForPush
            label.font = .systemFont(ofSize: 30, weight: .medium)
            label.textColor = .black
            label.sizeToFit()
            labelForPush = label
            self.addSubview(label)
        case .pop:
            let imageView = UIImageView(image: UIImage(systemName: "arrow.left"))
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .darkGray
            imageViewForPop = imageView
            self.addSubview(imageView)
        }
        
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        switch buttonRole {
        case .push:
            if let valueString = valueForPush {
                let suffix = (valueString.count > 1 ? " \(valueString.count)개" : "")
                self.accessibilityLabel = valueString + suffix
            }
        case .pop:
            self.accessibilityLabel = "마지막 숫자 지우기"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelForPush?.pin.center()
        imageViewForPop?.pin.center().size(30)
    }
}
