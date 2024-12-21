//
//  MainViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 11/27/24.
//

import UIKit
import PinLayout

class MainViewController: UIViewController {

    // MARK: - Properties
    
    private var upperArea = UIView()
    private var lowerArea = UIView()
    
    private var coinDescLabel = UILabel()
    private var coinAmountLabel = UILabel()
    private var groupNameLabel = UILabel()
    
    private var listTitleLabel = UILabel()
    private var gameListTableView = UITableView()
    private var refreshControl = UIRefreshControl()
    
    private var rankingButton = UIButton()
    private var logoutButton = UIButton()
    private var githubButton = UIButton()
    
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        gameListTableView.estimatedRowHeight = GameItemCell.cellHeight
        gameListTableView.delegate = self
        gameListTableView.dataSource = self
        gameListTableView.register(GameItemCell.self, forCellReuseIdentifier: GameItemCell.reuseIdentifier)
        gameListTableView.separatorStyle = .none
        gameListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 6.0, right: 0)
        
        refreshControl.addTarget(self, action: #selector(refreshTableView(refreshControl:)), for: .valueChanged)
        refreshControl.endRefreshing()
        gameListTableView.refreshControl = refreshControl
        
        DispatchQueue.main.async {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            self.navigationController?.present(loginVC, animated: false)
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(upperArea)
        self.view.addSubview(lowerArea)
        
        coinDescLabel.text = "현재 보유 코인"
        coinDescLabel.textColor = .darkGray
        coinDescLabel.sizeToFit()
        upperArea.addSubview(coinDescLabel)
        
        coinAmountLabel.text = "1,000,000 AMC"
        coinAmountLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        coinAmountLabel.sizeToFit()
        upperArea.addSubview(coinAmountLabel)
        
        groupNameLabel.text = "애교가 넘치는 사랑의 하츄핑"
        groupNameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        groupNameLabel.textColor = .systemGray
        groupNameLabel.sizeToFit()
        upperArea.addSubview(groupNameLabel)
        
        listTitleLabel.text = "진행 중인 게임 목록"
        listTitleLabel.font = .systemFont(ofSize: 16)
        lowerArea.addSubview(listTitleLabel)
        
        lowerArea.addSubview(gameListTableView)
        
        rankingButton.setImage(UIImage(systemName: "trophy",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)),
                              for: .normal)
        rankingButton.tintColor = .systemGray2
        rankingButton.addTarget(self, action: #selector(rankingButtonPressed), for: .touchUpInside)
        self.view.addSubview(rankingButton)
        
        logoutButton.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .bold)),
                              for: .normal)
        logoutButton.tintColor = .systemGray2
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        self.view.addSubview(logoutButton)
        
        githubButton.setImage(UIImage(systemName: "link",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)),
                              for: .normal)
        githubButton.tintColor = .systemGray2
        githubButton.setTitle(" github", for: .normal)
        githubButton.setTitleColor(.systemGray2, for: .normal)
        githubButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        githubButton.addTarget(self, action: #selector(githubButtonPressed), for: .touchUpInside)
        self.view.addSubview(githubButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upperArea.pin.top(self.view.pin.safeArea)
            .horizontally(self.view.pin.safeArea).height(200)
        lowerArea.pin.below(of: upperArea).horizontally(self.view.pin.safeArea).bottom()
        
        coinDescLabel.pin.top(70).hCenter()
        coinAmountLabel.pin.bottom(70).hCenter()
        groupNameLabel.pin.bottom(30).hCenter()
        
        listTitleLabel.pin.top(30).horizontally().marginHorizontal(GameItemCell.cellMarginHorizontal).sizeToFit(.width)
        gameListTableView.pin.below(of: listTitleLabel).horizontally().bottom().marginTop(15)
        
        rankingButton.pin.top(self.view.pin.safeArea).right(self.view.pin.safeArea)
            .size(40).marginRight(16)
        logoutButton.pin.before(of: rankingButton, aligned: .top).size(40).marginRight(5)
        githubButton.pin.top(self.view.pin.safeArea).left(self.view.pin.safeArea)
            .width(85).height(40).marginLeft(16)
    }

}

// MARK: - TableView DataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameItemCell.reuseIdentifier, for: indexPath) as? GameItemCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.tag = indexPath.row
        
        if indexPath.row % 3 == 0 {
            cell.gameStatus = .beforeBetting
        }
        if indexPath.row % 3 == 1 {
            cell.gameStatus = .inProgress
        }
        if indexPath.row % 3 == 2 {
            cell.gameStatus = .gameEnded
        }
        return cell
    }
}

// MARK: - TableView Delegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GameItemCell.cellHeight
    }
}

// MARK: - GroupItemCellDelegate

extension MainViewController: GameItemCellDelegate {
    func cellContentsTouched(cellIndex: Int, gameStatus: GameItemCell.GameStatus?) {
        switch gameStatus {
        case .beforeBetting:
            self.navigationController?.pushViewController(BettingViewController(), animated: true)
        case .gameEnded:
            self.navigationController?.pushViewController(ResultViewController(), animated: true)
        default:
            break
        }
    }
}

// MARK: - Private Extensions

private extension MainViewController {
    @objc func rankingButtonPressed() {
        self.navigationController?.pushViewController(RankingViewController(), animated: true)
    }
    
    @objc func logoutButtonPressed() {
        let alert = UIAlertController(title: "", message: "로그아웃하시겠어요?", preferredStyle: .alert)
        let close = UIAlertAction(title: "취소", style: .default, handler: nil)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            DispatchQueue.main.async {
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .fullScreen
                self.navigationController?.present(loginVC, animated: true)
            }
        }
        alert.addAction(close)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @objc func githubButtonPressed() {
        
    }
    
    @objc func refreshTableView(refreshControl: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.gameListTableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
}
