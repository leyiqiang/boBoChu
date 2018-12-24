//
//  Sign.swift
//  boboChu
//
//  Created by Leyi Qiang on 12/24/18.
//  Copyright © 2018 Leyi Qiang. All rights reserved.
//

import Foundation
//import GameplayKit

enum Sign {
    case bo, bigBo, block, superBlock, chu
    
    var prompt: String {
        switch self {
        case .bo:
            return "波"
        case .bigBo:
            return "大波"
        case .block:
            return "防"
        case .superBlock:
            return "超防"
        case .chu:
            return "储"
        }
    }
    
    func takeTurn(_ opponent: Sign) -> GameState {
        switch self {
        case .bo:
            switch opponent {
            case .bo:
                return GameState.play
            case .bigBo:
                return GameState.lose
            case .block:
                return GameState.play
            case .superBlock:
                return GameState.lose
            case .chu:
                return GameState.win
            }
        case .bigBo:
            switch opponent {
            case .bo:
                return GameState.win
            case .bigBo:
                return GameState.play
            case .block:
                return GameState.win
            case .superBlock:
                return GameState.play
            case .chu:
                return GameState.win
            }
        case .block:
            switch opponent {
            case .bo:
                return GameState.play
            case .bigBo:
                return GameState.lose
            case .block:
                return GameState.play
            case .superBlock:
                return GameState.play
            case .chu:
                return GameState.play
            }
        case .superBlock:
            switch opponent {
            case .bo:
                return GameState.win
            case .bigBo:
                return GameState.play
            case .block:
                return GameState.play
            case .superBlock:
                return GameState.play
            case .chu:
                return GameState.play
            }
        case .chu:
            switch opponent {
            case .bo:
                return GameState.lose
            case .bigBo:
                return GameState.lose
            case .block:
                return GameState.play
            case .superBlock:
                return GameState.play
            case .chu:
                return GameState.play
            }
        }
    }
}


