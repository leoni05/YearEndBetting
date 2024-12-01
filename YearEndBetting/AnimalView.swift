//
//  AnimalView.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/1/24.
//

import Foundation
import UIKit
import PinLayout

class AnimalView: UIView {
    
    // MARK: - Properties
    
    private var koreanString: String?
    private var imageName: String?
    
    // MARK: - Life Cycle
    
    init(koreanString: String, imageName: String) {
        super.init(frame: .zero)
        self.koreanString = koreanString
        self.imageName = imageName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
