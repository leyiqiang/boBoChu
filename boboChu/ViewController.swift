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
    @IBOutlet weak var opponentActionPrompt: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    
    var opponentChuCount: Int! = 0
    var playerChuCount: Int! = 0
    var countDownSeconds = 3
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBoard()
        // Do any additional setup after loading the view, typically from a nib.
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"background")!)

    }
    
    func runCountDown() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCountDown() {
        countDownSeconds -= 1
        if countDownSeconds < 0 {
            resetCountDown()
            play(Sign.chu)
        } else {
            countDownLabel.text = String(countDownSeconds)
        }
    }
    
    func resetCountDown() {
        timer.invalidate()
        runCountDown()
        countDownSeconds = 3
        countDownLabel.text = String(countDownSeconds)
    }
    
    func resetBoard() {
        playerActionPrompt.text = ""
        opponentActionPrompt.text = ""
        gameStatus.text = ""
        playAgainButton.isEnabled = false
        playAgainButton.isHidden = true
        menuButton.isEnabled = false
        menuButton.isHidden = true
        playerChuCount = 0
        opponentChuCount = 0
        enableActionButtonsOnChuCount()
        resetCountDown()
    }
    
    func setActionPrompt(_ action:Sign, isOpponent: Bool) {
        switch action {
        case .bigBo:
            if isOpponent {
                opponentActionPrompt.text = "大波!"
            } else {
                playerActionPrompt.text = "大波!"
            }
        case .bo:
            if isOpponent {
                opponentActionPrompt.text = "波!"
            } else {
                playerActionPrompt.text = "波!"
            }
        case .chu:
            if isOpponent {
                opponentActionPrompt.text = "储!"
            } else {
                playerActionPrompt.text = "储!"
            }
        case .superBlock:
            if isOpponent {
                opponentActionPrompt.text = "超防!"
            } else {
                playerActionPrompt.text = "超防!"
            }
        case .block:
            if isOpponent {
                opponentActionPrompt.text = "防!"
            } else {
                playerActionPrompt.text = "防!"
            }
        }
    }
    
    func disableAllActionButtons() {
        bigBoButton.isEnabled = false
        boButton.isEnabled = false
        chuButton.isEnabled = false
        blockButton.isEnabled = false
        superBlockButton.isEnabled = false
    }
    
    func enableAllActionButtons() {
        bigBoButton.isEnabled = true
        boButton.isEnabled = true
        chuButton.isEnabled = true
        blockButton.isEnabled = true
        superBlockButton.isEnabled = true
    }
    
    func setupGameOver() {
        playAgainButton.isHidden = false
        playAgainButton.isEnabled = true
        menuButton.isHidden = false
        menuButton.isEnabled = true
        timer.invalidate()
    }
    
    func enableActionButtonsOnChuCount() {
        chuButton.isEnabled = true
        blockButton.isEnabled = true
        bigBoButton.isEnabled = false
        boButton.isEnabled = false
        superBlockButton.isEnabled = false
        if playerChuCount >= 1 {
            boButton.isEnabled = true
            superBlockButton.isEnabled = true
        }
        if playerChuCount >= 2 {
            bigBoButton.isEnabled = true
        }
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
        disableAllActionButtons()
        let opponentTurn = randomAction()
        calculateChuCount(playerTurn, isOppnent: false)
        calculateChuCount(opponentTurn, isOppnent: true)
        setActionPrompt(playerTurn, isOpponent: false)
        setActionPrompt(opponentTurn, isOpponent: true)
        resetCountDown()
        let gameState = playerTurn.takeTurn(opponentTurn)
        switch gameState {
        case .play:
            gameStatus.text = ""
            enableActionButtonsOnChuCount()
        case .lose:
            gameStatus.text = "你输了."
            setupGameOver()
        case .win:
            gameStatus.text = "你赢了."
            setupGameOver()
        }
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

