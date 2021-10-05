//
//  Q2.swift
//  Sleep Learning
//
//  Created by Mani Jahani on 7/3/19.
//  Copyright © 2019 Memory Lab. All rights reserved.
//

import UIKit

class Q2: UIViewController {
    
    //  Set the status bar to have light content so it's visible against the black
    //  background
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func answeredYes(_ sender: Any) {
        diary.diaryData["awakenedBySoundsOrLanguage"] = "Yes"
        diary.upload()
    }
    
    @IBAction func answeredNo(_ sender: Any) {
        diary.diaryData["awakenedBySoundsOrLanguage"] = "No"
        diary.upload()
    }
    
    @IBAction func unwindToPreviousQuestion(segue: UIStoryboardSegue) {
        return
    }
}
