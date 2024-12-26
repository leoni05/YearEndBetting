//
//  WelcomeViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/26/24.
//

import Foundation
import UIKit
import PinLayout

class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var containerView = UIView()
    private var welcomeLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.view.addSubview(containerView)
        
        welcomeLabel.text = "2024년 송년회에 오신 것을 환영합니다!"
        welcomeLabel.numberOfLines = 0
        welcomeLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        welcomeLabel.textColor = .white
        welcomeLabel.sizeToFit()
        containerView.addSubview(welcomeLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        welcomeLabel.pin.top().left()
        containerView.pin.wrapContent().center()
    }
    
}
