//
//  Q3b.swift
//  Sleep Learning
//
//  Created by Annie Xu on 7/17/20.
//  Copyright © 2020 Memory Lab. All rights reserved.
//

import UIKit

class Q3b: UIViewController {
    
    //  Set the status bar to have light content so it's visible against the black
    //  background
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var responseField: UITextField!
    
    @IBAction func continueToNextQuestion(_ sender: Any) {
        guard responseField.text != nil && responseField.text != "" else {
            return
        }
        diary.diaryData["issuesWithVolume"] = responseField.text
        diary.upload()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "continueToNextQuestion" && (responseField.text == "" || responseField.text == nil) {
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
