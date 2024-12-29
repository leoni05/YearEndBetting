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
    private var tableViewGradientView = UIView()
    private var tableViewGradientLayer = CAGradientLayer()
    
    private var rankingButton = UIButton()
    private var logoutButton = UIButton()
    private var githubButton = UIButton()
    
    private var currentCoinAmount = 5105000
    private var games: Array<GameModel> = [
        GameModel(gameIndex: 1, gameName: "미스터리 박스", gameStatus: .gameEnded,
                  gameGroupRank: 2, gamePredictResult: 1, changeOfAMC: 512000, bettingAmount: -1),
        GameModel(gameIndex: 2, gameName: "안 숨은 그림 찾기", gameStatus: .gameEnded,
                  gameGroupRank: 4, gamePredictResult: 3, changeOfAMC: -189000, bettingAmount: -1),
        GameModel(gameIndex: 3, gameName: "행동지령 게임", gameStatus: .gameEnded,
                  gameGroupRank: 1, gamePredictResult: 1, changeOfAMC: 4000000, bettingAmount: -1),
        GameModel(gameIndex: 4, gameName: "몸으로 말해요", gameStatus: .gameEnded,
                  gameGroupRank: 2, gamePredictResult: 3, changeOfAMC: -218000, bettingAmount: -1),
        GameModel(gameIndex: 5, gameName: "티니핑 맞추기", gameStatus: .beforeBetting,
                  gameGroupRank: -1, gamePredictResult: -1, changeOfAMC: -1, bettingAmount: -1),
        GameModel(gameIndex: 6, gameName: "네글자 게임", gameStatus: .beforeBetting,
                  gameGroupRank: -1, gamePredictResult: -1, changeOfAMC: -1, bettingAmount: -1),
        GameModel(gameIndex: 7, gameName: "제시된 문장 카톡으로 보내기", gameStatus: .beforeBetting,
                  gameGroupRank: -1, gamePredictResult: -1, changeOfAMC: -1, bettingAmount: -1)
    ]
    
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
            loginVC.modalPresentationStyle = .overFullScreen
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
        
        coinAmountLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        setCoinAmountLabel()
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
        
        let colors: [CGColor] = [
           .init(red: 1, green: 1, blue: 1, alpha: 1),
           .init(red: 1, green: 1, blue: 1, alpha: 0)
        ]
        tableViewGradientLayer.colors = colors
        tableViewGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        tableViewGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        lowerArea.addSubview(tableViewGradientView)
        tableViewGradientView.layer.addSublayer(tableViewGradientLayer)
        
        rankingButton.setImage(UIImage(systemName: "crown",
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
        layout()
    }

}

// MARK: - TableView DataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameItemCell.reuseIdentifier, for: indexPath) as? GameItemCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.cellIndex = indexPath.row
        cell.setGameStatus(gameInfo: games[indexPath.row])
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
    func cellContentsTouched(cellIndex: Int, gameStatus: GameStatus?) {
        switch gameStatus {
        case .beforeBetting:
            let bettingVC = BettingViewController(currentCoin: currentCoinAmount, selectedCellIndex: cellIndex)
            bettingVC.delegate = self
            self.navigationController?.pushViewController(bettingVC, animated: true)
        case .gameEnded:
            break;
        default:
            break
        }
    }
}

// MARK: - BettingViewControllerDelegate

extension MainViewController: BettingViewControllerDelegate {
    func bettingFinished(cellIndex: Int, bettingAmount: Int) {
        currentCoinAmount -= bettingAmount
        games[cellIndex].gameStatus = .inProgress
        games[cellIndex].bettingAmount = bettingAmount
        gameListTableView.reloadData()
        
        setCoinAmountLabel()
        layout()
    }
}

// MARK: - Private Extensions

private extension MainViewController {
    func layout() {
        upperArea.pin.top(self.view.pin.safeArea)
            .horizontally(self.view.pin.safeArea).height(200)
        lowerArea.pin.below(of: upperArea).horizontally(self.view.pin.safeArea).bottom()
        
        coinDescLabel.pin.top(70).hCenter()
        coinAmountLabel.pin.bottom(70).hCenter()
        groupNameLabel.pin.bottom(30).hCenter()
        
        listTitleLabel.pin.top(30).horizontally().marginHorizontal(GameItemCell.cellMarginHorizontal).sizeToFit(.width)
        gameListTableView.pin.below(of: listTitleLabel).horizontally().bottom().marginTop(15)
        tableViewGradientView.pin.top(to: gameListTableView.edge.top).horizontally().height(GameItemCell.cellMarginVertical)
        tableViewGradientLayer.pin.all()
        
        rankingButton.pin.top(self.view.pin.safeArea).right(self.view.pin.safeArea)
            .size(40).marginRight(16)
        logoutButton.pin.before(of: rankingButton, aligned: .top).size(40).marginRight(5)
        githubButton.pin.top(self.view.pin.safeArea).left(self.view.pin.safeArea)
            .width(85).height(40).marginLeft(16)
    }
    
    @objc func rankingButtonPressed() {
        self.navigationController?.pushViewController(RankingViewController(), animated: true)
    }
    
    @objc func logoutButtonPressed() {
        let alert = UIAlertController(title: "", message: "로그아웃하시겠어요?", preferredStyle: .alert)
        let close = UIAlertAction(title: "취소", style: .default, handler: nil)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            DispatchQueue.main.async {
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .overFullScreen
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
    
    func setCoinAmountLabel() {
        var amountOfAMC = "AMC"
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let decimalString = numberFormatter.string(for: currentCoinAmount) {
            amountOfAMC = decimalString + " AMC"
        }
        coinAmountLabel.text = amountOfAMC
        coinAmountLabel.sizeToFit()
    }
}
