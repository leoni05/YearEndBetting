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
    private var greetingLabel = UILabel()
    
    private var listTitleLabel = UILabel()
    private var gameListTableView = UITableView()
    
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        gameListTableView.estimatedRowHeight = GameItemCell.cellHeight
        gameListTableView.delegate = self
        gameListTableView.dataSource = self
        gameListTableView.register(GameItemCell.self, forCellReuseIdentifier: GameItemCell.reuseIdentifier)
        gameListTableView.separatorStyle = .none
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
        
        greetingLabel.text = "OOO팀 송년회에 오신 걸 환영합니다"
        greetingLabel.font = .systemFont(ofSize: 15)
        greetingLabel.textColor = .systemGray
        greetingLabel.sizeToFit()
        upperArea.addSubview(greetingLabel)
        
        listTitleLabel.text = "진행 중인 게임 목록"
        listTitleLabel.font = .systemFont(ofSize: 16)
        lowerArea.addSubview(listTitleLabel)
        
        lowerArea.addSubview(gameListTableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upperArea.pin.top(self.view.pin.safeArea)
            .horizontally(self.view.pin.safeArea).height(200)
        lowerArea.pin.below(of: upperArea).horizontally(self.view.pin.safeArea).bottom()
        
        coinDescLabel.pin.top(70).hCenter()
        coinAmountLabel.pin.bottom(70).hCenter()
        greetingLabel.pin.bottom(30).hCenter()
        
        listTitleLabel.pin.top(30).horizontally().marginHorizontal(GameItemCell.cellMarginHorizontal).sizeToFit(.width)
        gameListTableView.pin.below(of: listTitleLabel).horizontally().bottom().marginTop(15)
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
        return cell
    }
}

// MARK: - TableView Delegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GameItemCell.cellHeight
    }
}
