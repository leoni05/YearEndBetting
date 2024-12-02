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
    private var buttonRole: ButtonRole?
    private var value: String?
    
    private var labelForPush: UILabel?
    private var imageViewForPop: UIImageView?
    
    // MARK: - Life Cycle
    
    init(buttonRole: ButtonRole, value: String? = nil) {
        super.init(frame: .zero)
        self.buttonRole = buttonRole
        self.value = value
        
        switch buttonRole {
        case .push:
            let label = UILabel()
            label.text = self.value
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
