//
//  CallibrateVolumeViewController.swift
//  Sleep Learning
//
//  Created by Mani Jahani on 7/1/19.
//  Copyright © 2019 Memory Lab. All rights reserved.
//

import UIKit

class CallibrateVolumeViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        //  Play the ocean audio so that the volume can be calibrated.
        //diary.dayChange()
        diary.diaryName = diary.getDate()
        audioPlayer.loadAudio(with: oceanURL)
        audioPlayer.playAudio(recordVol: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //  Stop playing the audio once the view disappears.
        audioPlayer.stopAudio(recordVol: false)
    }
}
