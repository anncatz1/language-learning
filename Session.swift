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
import Firebase
import FirebaseFirestore

class Session {
    // is the participant asleep
    var sessionRunning = false
    var sessionPaused = false
    
    func beginSession() {
        sessionRunning = true
        diary.diaryDate = diary.getDate()
        diary.diaryDateTime = diary.getDateTime()
        diary.resetInfo(resetDay: false)
        diary.diaryData["timeWhenStart"] = Date()
        diary.upload()
        //  The first series of audio files are silent, so the audio is loaded and
        //  played immediately when the session begins
        audioPlayer.loadAudioToStartSession()
        audioPlayer.playAudio(recordVol: true)
    }
    
    func endSession() {
        audioPlayer.stopAudio(recordVol: true)
        sessionRunning = false
        let date1 = Date()
        diary.diaryData["timeWhenEnd"] = date1
        diary.upload()
        
        // time for session
        var elapsed = date1.timeIntervalSince(diary.diaryData["timeWhenStart"] as! Date)
        elapsed = elapsed/60
        elapsed = round(elapsed * 100) / 100.0
        diary.diaryData["timeForSession"] = elapsed
        
        diary.diaryData["totalTimeForDay"] = (diary.diaryData["totalTimeForDay"] as! Double) + elapsed
        diary.upload()
    }
    
    func endDay()
    {
        diary.diarydayNum = diary.diarydayNum + 1
        diary.resetInfo(resetDay : true)
    }
    
    func continuePlay() {
        audioPlayer.playAudio(recordVol: true)
        // Because diaryData has the type [String: Any], in order to manipulate the value
        // they have to be cast to their correct type
        diary.diaryData["timesPressedContinue"] = (diary.diaryData["timesPressedContinue"] as! [Date]) + [Date()]
        sessionPaused = false
        diary.upload()
    }
    
    func pause() {
        audioPlayer.pauseAudio(recordVol: true)
        sessionPaused = true
        // Because diaryData has the type [String: Any], in order to manipulate the value
        // they have to be cast to their correct type
        diary.diaryData["numberOfPauses"] = diary.diaryData["numberOfPauses"] as! Int + 1
        diary.diaryData["timesPressedPause"] = (diary.diaryData["timesPressedPause"] as! [Date]) + [Date()]
        diary.upload()
    }
}

//    func restart() {
//        if audioPlayer.restartAudio() {
//            // Because diaryData has the type [String: Any], in order to manipulate the value
//            // they have to be cast to their correct type
//            diary.diaryData["numberOfRestarts"] = diary.diaryData["numberOfRestarts"] as! Int + 1
//            diary.diaryData["timesPressedRestart"] = (diary.diaryData["timesPressedRestart"] as! [Date]) + [Date()]
//            diary.upload()
//        }
//    }
