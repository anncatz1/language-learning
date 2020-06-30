//
//  Q5b.swift
//  Sleep Learning
//
//  Created by Annie Xu on 6/29/20.
//  Copyright © 2020 Memory Lab. All rights reserved.
//

import UIKit

class Q5: UIViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func answeredYes(_ sender: Any) {
        diary.diaryData["issuesWithAppYN"] = "Yes"
        diary.upload()
    }
    
    @IBAction func answeredNo(_ sender: Any) {
        diary.diaryData["issuesWithAppYN"] = "No"
        diary.upload()
    }
    
    @IBAction func unwindToPreviousQuestion(segue: UIStoryboardSegue) {
        return
    }
}
