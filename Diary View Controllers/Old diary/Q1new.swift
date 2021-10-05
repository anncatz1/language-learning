//
//  Q1new.swift
//  Sleep Learning
//
//  Created by Annie Xu on 9/27/21.
//  Copyright © 2021 Memory Lab. All rights reserved.
//

import UIKit

class Q1new: UIViewController {
    
    //  Set the status bar to have light content so it's visible against the black
    //  background
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBOutlet weak var hoursField: UITextField!
    @IBOutlet weak var minutesField: UITextField!
    
    @IBAction func enterInfo(_ sender: Any) {
        guard hoursField.text != nil && hoursField.text != "" else {
            return
        }
        diary.diaryData["streamHours"] = Int(hoursField.text!)
        diary.upload()
    }
    
    @IBAction func enterInfo2(_ sender: Any) {
        guard minutesField.text != nil && minutesField.text != "" else {
            return
        }
        diary.diaryData["streamMins"] = Int(minutesField.text!)
        diary.upload()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "continueToNextQuestion" && (minutesField.text == "" || minutesField.text == nil) {
            //  Display alert
            let emptyAlert = UIAlertController(title: "Invalid response", message: "You must enter a response before continuing.", preferredStyle: .alert)
            emptyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(emptyAlert, animated: true, completion: nil)
            return false
        }
        else {
            return true
        }
    }
    
    @IBAction func unwindToPreviousQuestion(segue: UIStoryboardSegue) {
        return
    }
}
