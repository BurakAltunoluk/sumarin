//
//  ViewController.swift
//  Sumarin
//
//  Created by Burak Altunoluk on 13/07/2022.
//

import UIKit
import AVFoundation

class MainVC: UIViewController {
    var player: AVAudioPlayer!
    var statue = false
    var mainModel = Model()
    var allButtonsArray = [UIButton]()
    var countTimer = Timer()
    var startFadeEffectTimer = Timer()
    var currentScore = 0
    @IBOutlet var SumanjiMiddle: UIImageView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var targetNumber: UILabel!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    @IBOutlet var button10: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        startButtonFadeEffectTimer()
        allButtonsArray = [button1, button2, button3, button4, button5, button6, button7, button8, button9, button10]
        targetNumber.isUserInteractionEnabled = true
        let startButtonGesture = UITapGestureRecognizer(target: self, action: #selector(startButton))
        targetNumber.addGestureRecognizer(startButtonGesture)
       
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        if targetNumber.text != "Start"{
        
        let ChoosedNumber = Int(sender.titleLabel!.text!)
        targetNumber.text = String(Int(targetNumber.text!)! - ChoosedNumber!)
        if targetNumber.text == "0" {
            playSound()
            currentScore += 1
            progressBar.progress = 1
            scoreLabel.text = "\(currentScore)"
            putNumberInButtonTitle()
        } else if Int(targetNumber.text!)! <= 0 {
            gameOver()
        }
        }
        
    }
    
    func putNumberInButtonTitle() {
        mainModel = Model()
        targetNumber.text = String(mainModel.targetNumber)
        func getByNo(no:Int) -> String {
            let getNumberFromSet = Array(mainModel.randomNumberArray)[no]
            return String(getNumberFromSet)
        }
        for (i,X) in allButtonsArray.enumerated() {
            X.setTitle(getByNo(no: i), for: .normal)
        }
      
     
    }
    
    @objc func countDown() {
        progressBar.progress -= 0.05
        if progressBar.progress == 0 {
            gameOver()
        }
    }
    
    @objc func startButton() {
        if targetNumber.text == "Start" {
            targetNumber.font = UIFont(name: "Georgia", size: 100)
            scoreLabel.text = "0"
            startFadeEffectTimer.invalidate()
            targetNumber.alpha = 0.6
            putNumberInButtonTitle()
            countTimer = Timer.scheduledTimer(timeInterval:1,
                                              target: self,
                                              selector: #selector(countDown),
                                              userInfo: nil,
                                              repeats: true)
        }
    }
    
    func gameOver() {
        targetNumber.font = UIFont(name: "Georgia", size: 44)
        countTimer.invalidate()
        startButtonFadeEffectTimer()
        let alert = UIAlertController(title: "Game over", message: "Oyun bitmistir", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
        targetNumber.text = "Start"
        currentScore = 0
        scoreLabel.text = "0"
        progressBar.progress = 1
        for bt in allButtonsArray {
            bt.setTitle("⬖", for: .normal)
        }
    }
    
    @objc func startButtonFadeAffect() {
       
        if targetNumber.alpha >= 0.6 {
            statue = true
        } else if targetNumber.alpha <= 0.1 {
            statue = false
        }
        
        switch statue {
        case true : targetNumber.alpha -= 0.05
        case false : targetNumber.alpha += 0.05
        }
    }
    
    func startButtonFadeEffectTimer() {
        startFadeEffectTimer = Timer.scheduledTimer(timeInterval: 0.08, target: self, selector: #selector(startButtonFadeAffect), userInfo: nil, repeats: true)
    }
    func playSound() {
            let url = Bundle.main.url(forResource: "lockSound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
                    
        }

}
