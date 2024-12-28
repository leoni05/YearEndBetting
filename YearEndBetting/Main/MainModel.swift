//
//  MainModel.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/28/24.
//

import Foundation

enum GameStatus {
    case beforeBetting
    case inProgress
    case gameEnded
}

struct GameModel {
    let gameIndex: Int
    let gameName: String
    let gameStatus: GameStatus
    let gameTeamRank: Int
    let gamePredictResult: Int
    let changeOfAMC: Int
    let bettingAmount: Int
}
