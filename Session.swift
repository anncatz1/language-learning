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

public class Session {
    // is the participant asleep
    var sessionRunning = false
    var sessionPaused = false
    var continuingDay = false
    
    func beginSession() {
        sessionRunning = true
        diary.diaryDate = diary.getDate()
        diary.diaryDateTime = diary.getDateTime()
                
        //  The first series of audio files are silent, so the audio is loaded and
        //  played immediately when the session begins
        if !continuingDay{
            diary.resetInfo(resetDay: true)
            diary.diaryData["timeWhenStart"] = Date()
            diary.upload()
            audioPlayer.loadAudioToStartSession()
        }
        else{
            diary.resetInfo(resetDay: false)
            diary.diaryData["timeWhenStart"] = Date()
            diary.upload()
        }
        audioPlayer.playAudio(recordVol: true)
    }
    
    func endSession() {
        audioPlayer.stopAudio(recordVol: true)
        sessionRunning = false
        
        let timeEnd = Date()
        diary.diaryData["timeWhenEnd"] = timeEnd
        diary.upload()
        // time for session
        let timeStart = diary.diaryData["timeWhenStart"] as! Date
        let elapsed = intervalBetweenTwoDates(date1: timeEnd, date2: timeStart)
        diary.diaryData["timeForSession"] = elapsed
        diary.diaryData["timeForDay"] = (diary.diaryData["timeForDay"] as! Double) + elapsed
        diary.upload()
    }
    
    func intervalBetweenTwoDates(date1 : Date, date2 : Date) -> TimeInterval
    {
        var elapsed = date1.timeIntervalSince(date2)
        elapsed = elapsed/60
        elapsed = round(elapsed * 100) / 100.0
        return elapsed
    }
    
    func continuePlay() {
        audioPlayer.playAudio(recordVol: true)
        // Because diaryData has the type [String: Any], in order to manipulate the value
        // they have to be cast to their correct type
        let continueDate = Date()
        let datesPaused = diary.diaryData["timesPressedPause"] as! [Date]
        let pauseDate = datesPaused[datesPaused.count-1]
        diary.diaryData["timePaused"] = (diary.diaryData["timePaused"] as! Double) + intervalBetweenTwoDates(date1: continueDate, date2: pauseDate)
        diary.diaryData["timesPressedContinue"] = (diary.diaryData["timesPressedContinue"] as! [Date]) + [continueDate]
        
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

var session = Session()
