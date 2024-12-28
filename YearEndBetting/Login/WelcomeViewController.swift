//
//  WelcomeViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/26/24.
//

import Foundation
import UIKit
import PinLayout

protocol WelcomeViewControllerDelegate: AnyObject {
    func dismissLoginVC()
}

class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: WelcomeViewControllerDelegate?
    private let heartCount = 10
    private var containerView = UIView()
    private var welcomeLabel = UILabel()
    private var welcomeButton = UIButton()
    private var heartImageViews = Array<UIImageView>()
    
    private var logoContainerView = UIView()
    private var logoImageView = UIImageView()
    private var logoLabelView = UILabel()
    
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
        
        for idx in 0..<heartCount {
            let imageName = "heart" + ((idx == heartCount-1) ? ".fill" : "")
            let heartImageView = UIImageView(image: UIImage(systemName: imageName))
            heartImageView.tintColor = UIColor(named: "DarkPink")
            heartImageView.contentMode = .scaleAspectFit
            if idx > 0 {
                heartImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0, 0)
                heartImageView.isHidden = true
            }
            containerView.addSubview(heartImageView)
            heartImageViews.append(heartImageView)
        }
        
        welcomeButton.setTitle("OK", for: .normal)
        welcomeButton.setTitleColor(.white, for: .normal)
        welcomeButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        welcomeButton.addTarget(self, action: #selector(welcomeButtonPressed), for: .touchUpInside)
        containerView.addSubview(welcomeButton)
        
        logoContainerView.alpha = 0.0
        logoContainerView.isHidden = true
        self.view.addSubview(logoContainerView)
        
        logoImageView.image = UIImage(systemName: "heart.circle.fill")
        logoImageView.tintColor = .white
        logoImageView.contentMode = .scaleAspectFit
        logoContainerView.addSubview(logoImageView)
        
        logoLabelView.text = "YEAR-END BETTING"
        logoLabelView.font = .systemFont(ofSize: 16, weight: .semibold)
        logoLabelView.textColor = .white
        logoLabelView.sizeToFit()
        logoContainerView.addSubview(logoLabelView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        welcomeLabel.pin.top().left()
        for idx in heartImageViews.indices {
            heartImageViews[idx].pin.below(of: welcomeLabel, aligned: .center).size(80).marginTop(2)
        }
        welcomeButton.pin.below(of: welcomeLabel, aligned: .center).size(80)
        containerView.pin.wrapContent().center()
        
        logoContainerView.pin.size(200)
        logoImageView.pin.top().hCenter().size(60)
        logoLabelView.pin.below(of: logoImageView, aligned: .center).marginTop(3)
        logoContainerView.pin.wrapContent().center()
    }
    
}


// MARK: - Private Extensions

private extension WelcomeViewController {
    @objc func welcomeButtonPressed() {
        UIView.animate(withDuration: 0.3) {
            self.welcomeButton.alpha = 0.0
        } completion: { _ in
            self.welcomeButton.isHidden = true
        }
        
        for idx in heartImageViews.indices {
            heartImageViews[idx].isHidden = false
            UIView.animate(withDuration: 3, delay: 0.3 * Double(idx + 1)) {
                self.heartImageViews[idx].transform = CGAffineTransformScale(CGAffineTransformIdentity, 50, 50)
            }
        }
        
        logoContainerView.isHidden = false
        UIView.animate(withDuration: 1.0, delay: 4) {
            self.logoContainerView.alpha = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6.0) {
            self.delegate?.dismissLoginVC()
        }
    }
}
