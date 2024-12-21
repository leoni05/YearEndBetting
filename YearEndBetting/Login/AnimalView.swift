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
    
    private var imageName: String?
    private var imageViewArea = UIView()
    private var imageView = UIImageView()
    private var label = UILabel()
    
    var isSelected = false {
        didSet {
            imageView.tintColor = isSelected ? UIColor(named: "DarkPink") : .systemGray4
        }
    }
    
    // MARK: - Life Cycle
    
    init(koreanString: String, imageName: String) {
        super.init(frame: .zero)
        self.imageName = imageName
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray4
        imageView.image = UIImage(systemName: imageName)
        imageViewArea.addSubview(imageView)
        
        self.addSubview(imageViewArea)
        
        label.text = koreanString
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.sizeToFit()
        self.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.pin.bottom(10).hCenter()
        imageViewArea.pin.above(of: label).top().horizontally()
        imageView.pin.center().size(50)
    }
}
