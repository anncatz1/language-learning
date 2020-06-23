//
//  Session.swift
//  Sleep Learning
//
//  Created by Mani Jahani on 6/10/19.
//  Copyright © 2019 Memory Lab. All rights reserved.
//
//  Description:
//      The Session class handles beginning, restarting, and ending a session.
//

import Foundation

class Session {
    // is the participant asleep
    var isAsleep = false
    
    func beginSession() {
        isAsleep = true
        diary.diaryData["timeWhenAsleep"] = Date()
        diary.upload()
        //  The first series of audio files are silent, so the audio is loaded and
        //  played immediately when the session begins
        audioPlayer.loadAudioToStartSession()
        audioPlayer.playAudio()
    }
    
    func endSession() {
        audioPlayer.stopAudio(recordVol : true)
        isAsleep = false
        diary.diaryData["timeWhenAwake"] = Date()
        diary.upload()
    }
    
    func restart() {
        if audioPlayer.restartAudio() {
            // Because diaryData has the type [String: Any], in order to manipulate the value
            // they have to be cast to their correct type
            diary.diaryData["numberOfRestarts"] = diary.diaryData["numberOfRestarts"] as! Int + 1
            diary.diaryData["timesPressedRestart"] = (diary.diaryData["timesPressedRestart"] as! [Date]) + [Date()]
            diary.upload()
        }
    }
}
