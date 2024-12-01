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
    
    private var groupListTableView = UITableView()
    
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        groupListTableView.estimatedRowHeight = GroupItemCell.cellHeight
        groupListTableView.delegate = self
        groupListTableView.dataSource = self
        groupListTableView.register(GroupItemCell.self, forCellReuseIdentifier: GroupItemCell.reuseIdentifier)
        groupListTableView.separatorStyle = .none
        groupListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 6.0, right: 0)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        self.view.addSubview(groupListTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        greetingLabel.pin.top(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
            .marginTop(60).marginHorizontal(20).sizeToFit(.width)
        askingNameLabel.pin.below(of: greetingLabel).horizontally(self.view.pin.safeArea)
            .marginTop(15).marginHorizontal(20).sizeToFit(.width)
        groupListTableView.pin.below(of: askingNameLabel).horizontally(self.view.pin.safeArea).bottom()
            .marginTop(110)
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
        return cell
    }
}

// MARK: - TableView Delegate

extension LoginViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GroupItemCell.cellHeight
    }
}
