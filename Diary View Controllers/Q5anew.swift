//
//  Q5anew.swift
//  Sleep Learning
//
//  Created by Annie Xu on 9/27/21.
//  Copyright © 2021 Memory Lab. All rights reserved.
//

import UIKit

class Q5anew: UIViewController {
    
    //  Set the status bar to have light content so it's visible against the black
    //  background
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func answeredYes(_ sender: Any) {
        diary.diaryData["englishHeardYN"] = "Yes"
        diary.upload()
    }
    
    @IBAction func answeredNo(_ sender: Any) {
        diary.diaryData["englishHeardYN"] = "No"
        diary.upload()
    }
    
    @IBAction func unwindToPreviousQuestion(segue: UIStoryboardSegue) {
        return
    }
}
