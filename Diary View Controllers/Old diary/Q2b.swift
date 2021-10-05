//
//  Q2b.swift
//  Sleep Learning
//
//  Created by Mani Jahani on 7/3/19.
//  Copyright © 2019 Memory Lab. All rights reserved.
//

import UIKit

class Q2b: UIViewController {
    
    //  Set the status bar to have light content so it's visible against the black
    //  background
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func answeredYes(_ sender: Any) {
        diary.diaryData["notAwakenedButHeardALanguage"] = "Yes"
        diary.upload()
    }
    
    @IBAction func answeredNo(_ sender: Any) {
        diary.diaryData["notAwakenedButHeardALanguage"] = "No"
        diary.upload()
    }
    
    @IBAction func unwindToPreviousQuestion(segue: UIStoryboardSegue) {
        return
    }
}
