//
//  ResultViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/8/24.
//

import Foundation
import UIKit
import PinLayout

class ResultViewController: UIViewController {
    
    // MARK: - Properties
    
    private var backButton = UIButton()
    
    private var upperArea = UIView()
    private var resultDescLabel = UILabel()
    private var currentRankLabel = UILabel()
    private var winRewardLabel = UILabel()
    private var onePickLabel = UILabel()
    private var betAmountLabel = UILabel()
    private var betRewardLabel = UILabel()
    
    private var lowerArea = UIView()
    private var listTitleLabel = UILabel()
    private var groupListTableView = UITableView()
    
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        groupListTableView.estimatedRowHeight = ResultGroupCell.cellHeight
        groupListTableView.delegate = self
        groupListTableView.dataSource = self
        groupListTableView.register(ResultGroupCell.self, forCellReuseIdentifier: ResultGroupCell.reuseIdentifier)
        groupListTableView.separatorStyle = .none
        groupListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 6.0, right: 0)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white   
        
        self.view.addSubview(upperArea)
        
        resultDescLabel.text = "게임 결과"
        resultDescLabel.textColor = .darkGray
        resultDescLabel.sizeToFit()
        upperArea.addSubview(resultDescLabel)
        
        currentRankLabel.text = "1위"
        currentRankLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        currentRankLabel.sizeToFit()
        upperArea.addSubview(currentRankLabel)
        
        winRewardLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        winRewardLabel.textColor = .systemGray
        let winReward = "+500,100 AMC"
        let winRewardString = "승리 보상    \(winReward)"
        let winRewardAttrString = NSMutableAttributedString(string: winRewardString)
        let winRewardRange = (winRewardString as NSString).range(of: winReward)
        winRewardAttrString.addAttribute(.foregroundColor, value: UIColor.black as Any, range: winRewardRange)
        winRewardLabel.attributedText = winRewardAttrString
        winRewardLabel.sizeToFit()
        upperArea.addSubview(winRewardLabel)
        
        onePickLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        onePickLabel.textColor = .systemGray
        let onePick = "애교가 넘치는 사랑의 하츄핑 (1조)"
        let onePickString = "우리의 원픽    \(onePick)"
        let onePickAttrString = NSMutableAttributedString(string: onePickString)
        let onePickRange = (onePickString as NSString).range(of: onePick)
        onePickAttrString.addAttribute(.foregroundColor, value: UIColor(named: "DarkPink") as Any, range: onePickRange)
        onePickLabel.attributedText = onePickAttrString
        onePickLabel.sizeToFit()
        upperArea.addSubview(onePickLabel)
        
        betAmountLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        betAmountLabel.textColor = .systemGray
        let amount = "500,100 AMC"
        let amountString = "베팅 코인    \(amount)"
        let amountAttrString = NSMutableAttributedString(string: amountString)
        let amountRange = (amountString as NSString).range(of: amount)
        amountAttrString.addAttribute(.foregroundColor, value: UIColor.black as Any, range: amountRange)
        betAmountLabel.attributedText = amountAttrString
        betAmountLabel.sizeToFit()
        upperArea.addSubview(betAmountLabel)
        
        betRewardLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        betRewardLabel.textColor = .systemGray
        let betReward = "+500,100 AMC"
        let betRewardString = "베팅 보상    \(betReward)"
        let betRewardAttrString = NSMutableAttributedString(string: betRewardString)
        let betRewardRange = (betRewardString as NSString).range(of: betReward)
        betRewardAttrString.addAttribute(.foregroundColor, value: UIColor.black as Any, range: betRewardRange)
        betRewardLabel.attributedText = betRewardAttrString
        betRewardLabel.sizeToFit()
        upperArea.addSubview(betRewardLabel)
        
        backButton.setImage(UIImage(systemName: "chevron.left",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)),
                              for: .normal)
        backButton.tintColor = .darkGray
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        self.view.addSubview(lowerArea)
        
        listTitleLabel.text = "전체 결과"
        listTitleLabel.font = .systemFont(ofSize: 16)
        lowerArea.addSubview(listTitleLabel)
        
        lowerArea.addSubview(groupListTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upperArea.pin.top(self.view.pin.safeArea)
            .horizontally(self.view.pin.safeArea).height(200)
        resultDescLabel.pin.top(45).hCenter()
        currentRankLabel.pin.bottom(95).hCenter()
        winRewardLabel.pin.below(of: currentRankLabel).hCenter().marginTop(10)
        onePickLabel.pin.below(of: winRewardLabel).hCenter().marginTop(3)
        betAmountLabel.pin.below(of: onePickLabel).hCenter().marginTop(3)
        betRewardLabel.pin.below(of: betAmountLabel).hCenter().marginTop(3)
        
        backButton.pin.top(self.view.pin.safeArea).left(self.view.pin.safeArea)
            .size(40).marginLeft(10)
        
        lowerArea.pin.below(of: upperArea).horizontally(self.view.pin.safeArea).bottom()
        listTitleLabel.pin.top(30).horizontally().marginHorizontal(ResultGroupCell.cellMarginHorizontal).sizeToFit(.width)
        groupListTableView.pin.below(of: listTitleLabel).horizontally().bottom().marginTop(15)
    }
}

// MARK: - TableView DataSource

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultGroupCell.reuseIdentifier, for: indexPath) as? ResultGroupCell else {
            return UITableViewCell()
        }
        return cell
    }
}

// MARK: - TableView Delegate

extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ResultGroupCell.cellHeight
    }
}

// MARK: - Private Extensions

private extension ResultViewController {
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
