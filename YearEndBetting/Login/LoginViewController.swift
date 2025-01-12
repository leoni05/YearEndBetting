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
    private var groupListTableView = UITableView()
    private var askingFavoriteLabel = UILabel()
    private var animalKeyboardView = AnimalKeyboardView()
    private var backButton = UIButton()
    
    private var tableViewGradientView = UIView()
    private var tableViewGradientLayer = CAGradientLayer()
    
    private let groupNames: Array<String> = [
        "애교가 넘치는 사랑의 하츄핑",
        "성실한 올바름의 바로핑",
        "용기의 아자핑",
        "너그러운 희망의 차차핑",
        "쾌활한 즐거움의 라라핑",
        "감정이 풍부한 해핑",
        "다정하고 상냥한 포실핑",
        "배려심이 깊은 샤샤핑"
    ]
    
    private enum AskingStatus {
        case askingName
        case askingFavoriteAnimals
    }
    private var askingStatus: AskingStatus? {
        didSet {
            switch askingStatus {
                
            case .askingName:
                askingNameLabel.isHidden = false
                groupListTableView.isHidden = false
                tableViewGradientView.isHidden = false
                UIView.animate(withDuration: 0.3) {
                    self.askingNameLabel.alpha = 1.0
                    self.groupListTableView.alpha = 1.0
                    self.tableViewGradientView.alpha = 1.0
                }
                askingFavoriteLabel.isHidden = true
                animalKeyboardView.isHidden = true
                backButton.isHidden = true
                askingFavoriteLabel.alpha = 0.0
                animalKeyboardView.alpha = 0.0
                backButton.alpha = 0.0
                
            case .askingFavoriteAnimals:
                askingNameLabel.isHidden = true
                groupListTableView.isHidden = true
                tableViewGradientView.isHidden = true
                askingNameLabel.alpha = 0.0
                groupListTableView.alpha = 0.0
                tableViewGradientView.alpha = 0.0
                askingFavoriteLabel.isHidden = false
                animalKeyboardView.isHidden = false
                backButton.isHidden = false
                UIView.animate(withDuration: 0.3) {
                    self.askingFavoriteLabel.alpha = 1.0
                    self.animalKeyboardView.alpha = 1.0
                    self.backButton.alpha = 1.0
                }
                
            default:
                break
            }
        }
    }
    
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        groupListTableView.estimatedRowHeight = GroupItemCell.cellHeight
        groupListTableView.delegate = self
        groupListTableView.dataSource = self
        groupListTableView.register(GroupItemCell.self, forCellReuseIdentifier: GroupItemCell.reuseIdentifier)
        groupListTableView.separatorStyle = .none
        groupListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 6.0, right: 0)
        
        animalKeyboardView.delegate = self
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        askingStatus = .askingName
        
        greetingLabel.text = "반가워요!"
        greetingLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        greetingLabel.numberOfLines = 0
        self.view.addSubview(greetingLabel)
        
        askingNameLabel.text = "이름을 알려줄래요?"
        askingNameLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        askingNameLabel.numberOfLines = 0
        self.view.addSubview(askingNameLabel)
        
        askingFavoriteLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        askingFavoriteLabel.numberOfLines = 0
        setAskingFavoriteLabel(groupName: "애교가 넘치는 사랑의 하츄핑")
        self.view.addSubview(askingFavoriteLabel)
        
        self.view.addSubview(groupListTableView)
        
        let colors: [CGColor] = [
           .init(red: 1, green: 1, blue: 1, alpha: 1),
           .init(red: 1, green: 1, blue: 1, alpha: 0)
        ]
        tableViewGradientLayer.colors = colors
        tableViewGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        tableViewGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.view.addSubview(tableViewGradientView)
        tableViewGradientView.layer.addSublayer(tableViewGradientLayer)

        self.view.addSubview(animalKeyboardView)
        
        backButton.setImage(UIImage(systemName: "chevron.left",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)),
                              for: .normal)
        backButton.tintColor = .darkGray
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        self.view.addGestureRecognizer(edgePan)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
}

// MARK: - TableView DataSource

extension LoginViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupItemCell.reuseIdentifier, for: indexPath) as? GroupItemCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.cellIndex = indexPath.row
        cell.titleLabel.text = groupNames[indexPath.row]
        cell.subTitleLabel.text = "\(indexPath.row+1)조"
        return cell
    }
}

// MARK: - TableView Delegate

extension LoginViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GroupItemCell.cellHeight
    }
}

// MARK: - GroupItemCellDelegate

extension LoginViewController: GroupItemCellDelegate {
    func cellContentsTouched(cellIndex: Int) {
        setAskingFavoriteLabel(groupName: groupNames[cellIndex])
        askingStatus = .askingFavoriteAnimals
        layout()
    }
}

// MARK: - AnimalKeyboardViewDelegate

extension LoginViewController: AnimalKeyboardViewDelegate {
    func selectedAnimalChanged(selectedAnimals: Int) {
        if selectedAnimals == ((1<<0) | (1<<2) | (1<<4) | (1<<8)) {
            let welcomeVC = WelcomeViewController()
            welcomeVC.modalPresentationStyle = .overFullScreen
            welcomeVC.modalTransitionStyle = .crossDissolve
            welcomeVC.delegate = self
            self.present(welcomeVC, animated: true)
        }
    }
}

// MARK: - WelcomeViewControllerDelegate

extension LoginViewController: WelcomeViewControllerDelegate {
    func dismissLoginVC() {
        self.view.alpha = 0.0
        self.dismiss(animated: true) {
            self.presentingViewController?.dismiss(animated: false)
        }
    }
}

// MARK: - Private Extensions

private extension LoginViewController {
    func layout() {
        greetingLabel.pin.top(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
            .marginTop(60).marginHorizontal(20).sizeToFit(.width)
        
        if askingStatus == .askingName {
            askingNameLabel.pin.below(of: greetingLabel).horizontally(self.view.pin.safeArea)
                .marginTop(8).marginHorizontal(20).sizeToFit(.width)
            groupListTableView.pin.below(of: askingNameLabel).horizontally(self.view.pin.safeArea).bottom()
                .marginTop(110)
            tableViewGradientView.pin.top(to: groupListTableView.edge.top).horizontally().height(GroupItemCell.cellMarginVertical)
            tableViewGradientLayer.pin.all()
        }
        if askingStatus == .askingFavoriteAnimals {
            askingFavoriteLabel.pin.below(of: greetingLabel).horizontally(self.view.pin.safeArea)
                .marginTop(8).marginHorizontal(20).sizeToFit(.width)
            animalKeyboardView.pin.bottom(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
                .height(320).marginHorizontal(20).marginBottom(10)
            backButton.pin.top(self.view.pin.safeArea).left(self.view.pin.safeArea)
                .size(40).marginLeft(10)
        }
    }
    
    func goBackToAskingName() {
        if askingStatus == .askingFavoriteAnimals {
            groupListTableView.setContentOffset(CGPointZero, animated: false)
            askingStatus = .askingName
            layout()
            animalKeyboardView.resetKeyboard()
        }
    }
    
    @objc func backButtonPressed() {
        goBackToAskingName()
    }
    
    @objc func screenEdgeSwiped() {
        goBackToAskingName()
    }
    
    func setAskingFavoriteLabel(groupName: String) {
        let askingFavoriteString = "\(groupName)은\n어떤 동물을 좋아하나요?"
        let attrString = NSMutableAttributedString(string: askingFavoriteString)
        let range = (askingFavoriteString as NSString).range(of: groupName)
        attrString.addAttribute(.foregroundColor, value: UIColor(named: "DarkPink") as Any, range: range)
        askingFavoriteLabel.attributedText = attrString
    }
}

// MARK: - Accessibility
extension LoginViewController {
    override func accessibilityPerformEscape() -> Bool {
        goBackToAskingName()
        return true
    }
}
