//
//  ViewController.swift
//  Sleep Learning
//
//  Created by Mani Jahani on 6/4/19.
//  Copyright © 2019 Memory Lab. All rights reserved.
//
//  Description:
//      This is the controller for the session view. This file
//      defines the objects on the view, how the user can interact with them,
//      how those interactions affect the model (Session.swift), and how the
//      view gets updated from the model.
//

import UIKit

class SessionViewController: UIViewController {
    
    //  Set the status bar to have light content so it's visible against the black
    //  background
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var currentSession = Session()
    var hasSessionEnded = false
    
    //  Instances of the main button that starts and restarts sessions, and the end session button
    @IBOutlet weak var startOrRestartButton: UIButton!
    @IBOutlet weak var endSegmentButton: UIButton!
    //@IBOutlet weak var endDayButton: UIButton!
    
    //  When "start" or "restart" is pressed, take the appropriate action depending on the state (isAsleep)
    @IBAction func startOrRestartSession(_ sender: UIButton) {
        if !currentSession.sessionRunning {
            currentSession.beginSession()
        }
        else {
            if !currentSession.sessionPaused {
                currentSession.pause()
            }
            else {
                //currentSession.restart()
                currentSession.continuePlay()
            }
        }
        updateViewFromModel()
    }
    
    //  When "end" is pressed, view a confirmation alert and take the appropriate action based on user input.
    @IBAction func endSegment(_ sender: UIButton) {
        //  Declare Alert message
        let confirmAlert = UIAlertController(title: "Confirm", message: "Are you sure you want to stop the session?", preferredStyle: .alert)
        
        //  Create Yes button that ends session
        let yesButton = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            self.currentSession.endSession()
            self.hasSessionEnded = true
            self.performSegue(withIdentifier: "beginDiarySegue", sender: sender)
        })
        
        //  Create No button that cancels
        let noButton = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        //  Add Yes and No buttons to alert
        confirmAlert.addAction(noButton)
        confirmAlert.addAction(yesButton)
        
        //  Present alert message to user
        self.present(confirmAlert, animated: true, completion: nil)
        updateViewFromModel()
    }
    
//    //  When "end" is pressed, view a confirmation alert and take the appropriate action based on user input.
//    @IBAction func endDay(_ sender: UIButton) {
//        //  Declare Alert message
//        let confirmAlert = UIAlertController(title: "Confirm", message: "Are you sure you want to end the day?", preferredStyle: .alert)
//
//        //  Create Yes button that ends session
//        let yesButton = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
//            self.currentSession.endSession()
//            //diary.changedDay = true
//            self.hasSessionEnded = true
//            self.performSegue(withIdentifier: "beginDiarySegue", sender: sender)
//        })
//
//        //  Create No button that cancels
//        let noButton = UIAlertAction(title: "No", style: .cancel, handler: nil)
//
//        //  Add Yes and No buttons to alert
//        confirmAlert.addAction(noButton)
//        confirmAlert.addAction(yesButton)
//
//        //  Present alert message to user
//        self.present(confirmAlert, animated: true, completion: nil)
//        updateViewFromModel()
//    }

    func updateViewFromModel() {
        //  In session want pause:
        if currentSession.sessionRunning {
            if !currentSession.sessionPaused{
                startOrRestartButton.setTitle("Pause", for: UIControl.State.normal)
                startOrRestartButton.setTitleColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), for: UIControl.State.normal)
                endSegmentButton.isEnabled = true // END SEGMENT BUTTON
                endSegmentButton.setTitleColor(#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), for: UIControl.State.normal)
                //endDayButton.isEnabled = true // END DAY BUTTON
                //endDayButton.setTitleColor(#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), for: UIControl.State.normal)
            }
            // in session want start again
            else {
                startOrRestartButton.setTitle("Continue", for: UIControl.State.normal)
                startOrRestartButton.setTitleColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), for: UIControl.State.normal)
                endSegmentButton.isEnabled = true // END SEGMENT BUTTON
                endSegmentButton.setTitleColor(#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), for: UIControl.State.normal)
                //endDayButton.isEnabled = true // END DAY BUTTON
                //endDayButton.setTitleColor(#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), for: UIControl.State.normal)
            }
        }
            
        //  Not in session:
        else {
            startOrRestartButton.setTitle("Press Here to Begin Session", for: UIControl.State.normal)
            startOrRestartButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State.normal)
            endSegmentButton.isEnabled = false
            endSegmentButton.setTitleColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0), for: UIControl.State.normal)
            //endDayButton.isEnabled = false
            //endDayButton.setTitleColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0), for: UIControl.State.normal)
        }
    }
    
    //  Only segue into diary when the session has ended
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "beginDiarySegue" {
            return hasSessionEnded
        }
        return false
    }
}
