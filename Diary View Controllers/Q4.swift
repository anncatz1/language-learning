//
//  Q4.swift
//  Sleep Learning
//
//  Created by Annie Xu on 6/29/20.
//  Copyright © 2020 Memory Lab. All rights reserved.
//

import UIKit

class Q4: UIViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func answeredYes(_: Any) {
        diary.diaryData["issuesWithVolumeYN"] = "Yes"
        diary.upload()
    }
    
    @IBAction func answeredNo(_ sender: Any) {
        diary.diaryData["issuesWithVolumeYN"] = "No"
        diary.upload()
    }
    
    @IBAction func unwindToPreviousQuestion(segue: UIStoryboardSegue) {
        return
    }
}
