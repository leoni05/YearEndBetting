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
                askingFavoriteLabel.isHidden = true
                animalKeyboardView.isHidden = true
                backButton.isHidden = true
            case .askingFavoriteAnimals:
                askingNameLabel.isHidden = true
                groupListTableView.isHidden = true
                askingFavoriteLabel.isHidden = false
                animalKeyboardView.isHidden = false
                backButton.isHidden = false
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
        let groupName = "애교가 넘치는 사랑의 하츄핑"
        let askingFavoriteString = "\(groupName)은\n어떤 동물을 좋아하나요?"
        let attrString = NSMutableAttributedString(string: askingFavoriteString)
        let range = (askingFavoriteString as NSString).range(of: groupName)
        attrString.addAttribute(.foregroundColor, value: UIColor(named: "DarkPink") as Any, range: range)
        askingFavoriteLabel.attributedText = attrString
        self.view.addSubview(askingFavoriteLabel)
        
        self.view.addSubview(groupListTableView)
        
        self.view.addSubview(animalKeyboardView)
        
        backButton.setImage(UIImage(systemName: "chevron.left",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)),
                              for: .normal)
        backButton.tintColor = .darkGray
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.view.addSubview(backButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
}

// MARK: - TableView DataSource

extension LoginViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupItemCell.reuseIdentifier, for: indexPath) as? GroupItemCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.cellIndex = indexPath.row
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
        askingStatus = .askingFavoriteAnimals
        layout()
    }
}

// MARK: - AnimalKeyboardViewDelegate

extension LoginViewController: AnimalKeyboardViewDelegate {
    func selectedAnimalChanged(selectedAnimals: Int) {
        if selectedAnimals == ((1<<0) | (1<<2) | (1<<4) | (1<<8)) {
            let alert = UIAlertController(title: "", message: "2024 송년회에 오신 것을 환영합니다~!", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default) { _ in
                self.dismiss(animated: true)
            }
            alert.addAction(action)
            present(alert, animated: true)
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
                .marginTop(15).marginHorizontal(20).sizeToFit(.width)
            groupListTableView.pin.below(of: askingNameLabel).horizontally(self.view.pin.safeArea).bottom()
                .marginTop(110)
        }
        if askingStatus == .askingFavoriteAnimals {
            askingFavoriteLabel.pin.below(of: greetingLabel).horizontally(self.view.pin.safeArea)
                .marginTop(15).marginHorizontal(20).sizeToFit(.width)
            animalKeyboardView.pin.bottom(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
                .height(320).marginHorizontal(20).marginBottom(10)
            backButton.pin.top(self.view.pin.safeArea).left(self.view.pin.safeArea)
                .size(40).marginLeft(10)
        }
    }
    
    @objc func backButtonPressed() {
        groupListTableView.setContentOffset(CGPointZero, animated: false)
        askingStatus = .askingName
        layout()
        animalKeyboardView.resetKeyboard()
    }
}
