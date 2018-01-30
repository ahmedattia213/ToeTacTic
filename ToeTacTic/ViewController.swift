//
//  ViewController.swift
//  ToeTacTic
//
//  Created by Ahmed Amr on 1/18/18.
//  Copyright © 2018 Ahmed Amr. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
   
        
        @IBOutlet weak var playAgainButton: UIButton!
        @IBOutlet weak var winnerLabel: UILabel!
        @IBOutlet weak var drawLabel: UILabel!
        
        var audioCross = AVAudioPlayer()
        var audioNought = AVAudioPlayer()
        var audioWin = AVAudioPlayer()
        var audioDraw = AVAudioPlayer()
        
        var winOrDraw : Bool  = false
        var activeGame : Bool = true
        var turnFlag : Int = 1                                   // 1  for noughts
        var boxFilled = [ 0 , 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ]       // 0 for empty spaces
        let winningCombinations = [ [0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        
        @IBAction func buttonPressed(_ sender: UIButton) {
            let currentPosition = sender.tag - 1
            if boxFilled[currentPosition] == 0 && activeGame{
                boxFilled[currentPosition] = turnFlag
                if turnFlag == 1 {
                    sender.setImage(UIImage(named: "nought.png"), for: [])
                    turnFlag = 2
                    do{
                        audioNought = try AVAudioPlayer(contentsOf : URL.init(fileURLWithPath: Bundle.main.path(forResource: "noughtSound" , ofType: "wav")!))
                        audioNought.prepareToPlay()
                        audioNought.play()
                    }
                    catch{
                        print(error)
                    }
                    
                } else
                {
                    sender.setImage(UIImage(named: "cross.png"), for: [])
                    turnFlag = 1
                    do {
                        audioCross = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "crossSound" , ofType: "wav")!))
                        audioCross.prepareToPlay()
                        audioCross.play()
                    }
                    catch{
                        print(error)
                    }
                }
                for combination in winningCombinations {
                    if boxFilled[combination[0]] != 0  && boxFilled[ combination[0]] == boxFilled[combination[1]]
                        && boxFilled[ combination[1] ] == boxFilled [ combination[2] ]
                    {
                        activeGame = false
                        winOrDraw = true
                        do {
                            audioWin = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "woah" , ofType: "wav")!))
                            audioWin.prepareToPlay()
                            audioWin.play()
                        }
                        catch{
                            print(error)
                        }
                        if boxFilled[combination[0]] == 1{
                            winnerLabel.text = "Noughts WIN!"
                        }else {
                            winnerLabel.text = "Crosses WIN!"
                        }
                        winnerLabel.isHidden = false
                        playAgainButton.isHidden = false
                        
                        UIView.animate(withDuration: 1, animations: {
                            self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500,  y: self.winnerLabel.center.y)
                            
                        })
                    }
                    
                }
                var allpressed : Int = 0
                if winOrDraw == false {
                    
                    let size = boxFilled.count
                    var counter : Int = 0
                    while counter < size {
                        if boxFilled[counter] != 0 {
                            allpressed += 1

                        }
                        counter += 1
                    }

                    if allpressed == 9 {
                        do{
                            audioDraw = try AVAudioPlayer(contentsOf : URL.init(fileURLWithPath: Bundle.main.path(forResource: "booing" , ofType: "wav")!))
                            audioDraw.prepareToPlay()
                            audioDraw.play()
                        }
                        catch{
                            print(error)
                        }
                        drawLabel.isHidden = false
                        playAgainButton.isHidden = false
                        
                    }
                }
            }
            
            
            
        }
        @IBAction func playAgain(_ sender: UIButton) {
            activeGame  = true
            winOrDraw  = false
            turnFlag  = 1
            boxFilled = [ 0 , 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ]
            
            for i in 1..<10{
                if let button = view.viewWithTag(i) as? UIButton {
                    button.setImage(nil, for: [])
                }
                
                
            }
            
            
            viewDidLoad()
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            playAgainButton.isHidden = true
            winnerLabel.isHidden = true
            drawLabel.isHidden = true
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }




}

