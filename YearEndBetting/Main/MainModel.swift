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
    var gameStatus: GameStatus
    var gameGroupRank: Int
    var gamePredictResult: Int
    var changeOfAMC: Int
    var bettingAmount: Int
}
