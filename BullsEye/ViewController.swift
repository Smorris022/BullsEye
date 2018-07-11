//
//  ViewController.swift
//  BullsEye
//
//  Created by stephan morris on 11/23/17.
//  Copyright © 2017 Smorris. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    //Connections
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    //Instance Variables 
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    } //Function that changes the label information
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }

    func startNewRound(){
        
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        
        updateLabels()
//Calling the updateLabel func
    } // Function to start a new round
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        /* -- Another way of loading the screen --
         
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
        trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    */
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .normal)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlet(){
    
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        score += points
        //score = score + points
        
        let title: String
        if difference == 0 {
            title = "Perfect! You got it right on Target"
            points += 100
        }else if difference < 5 {
            title = "Shoot! You almost had it!"
            if difference == 1 {
                points += 50
            }
        }else if difference < 10 {
            title = "Pretty Good!"
        } else {
            title = "Sorry... Not Even Close"
        }
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in self.startNewRound()
            
        })
    
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
   
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver() {
        startNewGame()
    }
    }

