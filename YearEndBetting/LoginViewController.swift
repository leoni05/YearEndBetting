//
//  LoginViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 11/30/24.
//

import Foundation
import UIKit
import PinLayout

class LoginViewController: UIViewController {
 
    // MARK: - Properties
    
    private var greetingLabel = UILabel()
    private var askingNameLabel = UILabel()
    private var askingFavoriteLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        greetingLabel.text = "반가워요!"
        greetingLabel.font = .systemFont(ofSize: 25, weight: .bold)
        greetingLabel.numberOfLines = 0
        self.view.addSubview(greetingLabel)
        
        askingNameLabel.text = "이름을 알려줄래요?"
        askingNameLabel.font = .systemFont(ofSize: 25, weight: .bold)
        askingNameLabel.numberOfLines = 0
        self.view.addSubview(askingNameLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        greetingLabel.pin.top(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
            .marginTop(40).marginHorizontal(20).sizeToFit(.width)
        askingNameLabel.pin.below(of: greetingLabel, aligned: .left).right(20).marginTop(15).sizeToFit(.width)
    }
    
}
