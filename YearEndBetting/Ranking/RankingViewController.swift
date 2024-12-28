//
//  RankingViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/2/24.
//

import Foundation
import UIKit
import PinLayout

class RankingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var upperArea = UIView()
    private var rankDescLabel = UILabel()
    private var currentRankLabel = UILabel()
    private var groupNameLabel = UILabel()
    
    private var leftLaurelView = UIImageView()
    private var rightLaurelView = UIImageView()
    
    private var lowerArea = UIView()
    private var listTitleLabel = UILabel()
    private var groupListTableView = UITableView()
    private var tableViewGradientView = UIView()
    private var tableViewGradientLayer = CAGradientLayer()
    
    private var backButton = UIButton()
    
    private let ranking: Array<RankingModel> = [
        RankingModel(rank: 1, groupName: "애교가 넘치는 사랑의 하츄핑", groupNumber: 1, coinAmount: 5105000),
        RankingModel(rank: 2, groupName: "다정하고 상냥한 포실핑", groupNumber: 7, coinAmount: 4901000),
        RankingModel(rank: 3, groupName: "성실한 올바름의 바로핑", groupNumber: 2, coinAmount: 3050000),
        RankingModel(rank: 4, groupName: "배려심이 깊은 샤샤핑", groupNumber: 8, coinAmount: 2991000),
        RankingModel(rank: 5, groupName: "쾌활한 즐거움의 라라핑", groupNumber: 5, coinAmount: 2080000),
        RankingModel(rank: 6, groupName: "용기의 아자핑", groupNumber: 3, coinAmount: 2071000),
        RankingModel(rank: 7, groupName: "감정이 풍부한 해핑", groupNumber: 6, coinAmount: 1589000),
        RankingModel(rank: 8, groupName: "너그러운 희망의 차차핑", groupNumber: 4, coinAmount: 1440000)
    ]
    
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        groupListTableView.estimatedRowHeight = RankingGroupCell.cellHeight
        groupListTableView.delegate = self
        groupListTableView.dataSource = self
        groupListTableView.register(RankingGroupCell.self, forCellReuseIdentifier: RankingGroupCell.reuseIdentifier)
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
        
        rankDescLabel.text = "현재 코인 순위"
        rankDescLabel.textColor = .darkGray
        rankDescLabel.sizeToFit()
        upperArea.addSubview(rankDescLabel)
        
        currentRankLabel.text = "1위"
        currentRankLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        currentRankLabel.sizeToFit()
        upperArea.addSubview(currentRankLabel)
        
        groupNameLabel.text = "애교가 넘치는 사랑의 하츄핑"
        groupNameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        groupNameLabel.textColor = .systemGray
        groupNameLabel.sizeToFit()
        upperArea.addSubview(groupNameLabel)
        
        leftLaurelView.contentMode = .scaleAspectFit
        leftLaurelView.tintColor = .systemGray3
        leftLaurelView.image = UIImage(systemName: "laurel.leading")
        upperArea.addSubview(leftLaurelView)
        
        rightLaurelView.contentMode = .scaleAspectFit
        rightLaurelView.tintColor = .systemGray3
        rightLaurelView.image = UIImage(systemName: "laurel.trailing")
        upperArea.addSubview(rightLaurelView)
        
        self.view.addSubview(lowerArea)
        
        listTitleLabel.text = "전체 순위"
        listTitleLabel.font = .systemFont(ofSize: 16)
        lowerArea.addSubview(listTitleLabel)
        
        lowerArea.addSubview(groupListTableView)
        
        let colors: [CGColor] = [
           .init(red: 1, green: 1, blue: 1, alpha: 1),
           .init(red: 1, green: 1, blue: 1, alpha: 0)
        ]
        tableViewGradientLayer.colors = colors
        tableViewGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        tableViewGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        lowerArea.addSubview(tableViewGradientView)
        tableViewGradientView.layer.addSublayer(tableViewGradientLayer)
        
        backButton.setImage(UIImage(systemName: "chevron.left",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)),
                              for: .normal)
        backButton.tintColor = .darkGray
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.view.addSubview(backButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upperArea.pin.top(self.view.pin.safeArea)
            .horizontally(self.view.pin.safeArea).height(200)
        rankDescLabel.pin.top(70).hCenter()
        currentRankLabel.pin.bottom(70).hCenter()
        groupNameLabel.pin.bottom(30).hCenter()
        leftLaurelView.pin.before(of: currentRankLabel).vCenter(to: currentRankLabel.edge.vCenter)
            .size(30).marginRight(5)
        rightLaurelView.pin.after(of: currentRankLabel).vCenter(to: currentRankLabel.edge.vCenter)
            .size(30).marginLeft(5)
        
        lowerArea.pin.below(of: upperArea).horizontally(self.view.pin.safeArea).bottom()
        listTitleLabel.pin.top(30).horizontally().marginHorizontal(RankingGroupCell.cellMarginHorizontal).sizeToFit(.width)
        groupListTableView.pin.below(of: listTitleLabel).horizontally().bottom().marginTop(15)
        tableViewGradientView.pin.top(to: groupListTableView.edge.top).horizontally().height(RankingGroupCell.cellMarginVertical)
        tableViewGradientLayer.pin.all()
        
        backButton.pin.top(self.view.pin.safeArea).left(self.view.pin.safeArea)
            .size(40).marginLeft(10)
    }
    
}

// MARK: - TableView DataSource

extension RankingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ranking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingGroupCell.reuseIdentifier, for: indexPath) as? RankingGroupCell else {
            return UITableViewCell()
        }
        cell.setRankingCell(rankInfo: ranking[indexPath.row])
        return cell
    }
}

// MARK: - TableView Delegate

extension RankingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RankingGroupCell.cellHeight
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

