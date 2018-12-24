//
//  ViewController.swift
//  boboChu
//
//  Created by Leyi Qiang on 12/24/18.
//  Copyright © 2018 Leyi Qiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bigBoButton: UIButton!
    @IBOutlet weak var boButton: UIButton!
    @IBOutlet weak var chuButton: UIButton!
    @IBOutlet weak var blockButton: UIButton!
    @IBOutlet weak var superBlockButton: UIButton!
    @IBOutlet weak var gameStatus: UILabel!
    @IBOutlet weak var playerActionPrompt: UILabel!
    @IBOutlet weak var enemyActionPrompt: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    var opponentChuCount: Int!
    var playerChuCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBoard()
        // Do any additional setup after loading the view, typically from a nib.
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"background")!)
    }
    func resetBoard() {
        playerActionPrompt.text = ""
        enemyActionPrompt.text = ""
        gameStatus.text = ""
        playAgainButton.isEnabled = false
        playAgainButton.isHidden = true
        
        bigBoButton.isEnabled = true
        boButton.isEnabled = true
        chuButton.isEnabled = true
        blockButton.isEnabled = true
        superBlockButton.isEnabled = true
    }
    
    func randomAction() -> Sign {
        var selectedAction = Sign.chu
        if opponentChuCount <= 0 {
            let actions = [Sign.chu, Sign.block]
            selectedAction = actions.randomElement()!
        } else if opponentChuCount == 1 {
            let actions = [Sign.bo, Sign.chu, Sign.block, Sign.superBlock]
            selectedAction = actions.randomElement()!
        } else {
            let actions = [Sign.bo, Sign.chu, Sign.block, Sign.superBlock, Sign.bigBo]
            selectedAction = actions.randomElement()!
        }
        calculateChuCount(selectedAction, isOppnent: true)
        return selectedAction
    }
    
    func calculateChuCount(_ action:Sign, isOppnent:Bool) {
        switch action {
        case .bigBo:
            if isOppnent {
                opponentChuCount -= 2
            } else {
                playerChuCount -= 2
            }
        case .bo:
            if isOppnent {
                opponentChuCount -= 1
            } else {
                playerChuCount -= 1
            }
        case .chu:
            if isOppnent {
                opponentChuCount += 1
            } else {
                playerChuCount += 1
            }
        case .superBlock:
            if isOppnent {
                opponentChuCount -= 1
            } else {
                playerChuCount -= 1
            }
        case .block:
            break
        }
    }
    
    func play(_ playerTurn:Sign) {
        let opponent = randomAction()
        
    }
    
    @IBAction func playAgainSelected(_ sender: Any) {
        resetBoard()
    }
    
    @IBAction func bigBoSelected(_ sender: Any) {
        play(Sign.bigBo)
    }
    @IBAction func boSelected(_ sender: Any) {
        play(Sign.bo)
    }
    
    @IBAction func chuSelected(_ sender: Any) {
        play(Sign.chu)
    }
    
    @IBAction func blockSelected(_ sender: Any) {
        play(Sign.block)
    }
    
    @IBAction func superBlockSelected(_ sender: Any) {
        play(Sign.superBlock)
    }
}

