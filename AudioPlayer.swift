//
//  AudioPlayer.swift
//  Sleep Learning
//
//  Created by Mani Jahani on 6/11/19.
//  Copyright © 2019 Memory Lab. All rights reserved.
//
//  Description:
//      The AudioPlayer class handles the playback of audio.
//

import Foundation
import AVFoundation

class AudioPlayer {
    
    let audioSession: AVAudioSession
    var player: AVQueuePlayer
    
    init() {
        //  Initialize session as playback
        audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
        }
        catch {
            fatalError("Setting category to playback failed.")
        }
        
        //  Initialize an empty player
        player = AVQueuePlayer(items: [AVPlayerItem]())
    }
    
    //  Adds the blank audio, ocean sound, and language streams to the queue
    func loadAudioToStartSession() {
        let audioFilesList = (languageAudioURLList + endBlankAudioURLList).map {
        //let audioFilesList = (whiteOrSilentURLList + [oceanURL] + languageAudioURLList + endBlankAudioURLList).map {
            AVPlayerItem(url: $0)
        }
        player = AVQueuePlayer(items: audioFilesList)
    }
    
    //  Loads a single audio file into the player. Used for volume calibration.
//    func loadAudio(with audioURL: URL) {
//        player.removeAllItems()
//        let playerItem = AVPlayerItem(url: audioURL)
//        if player.canInsert(playerItem, after: player.currentItem) {
//            player.insert(playerItem, after: player.currentItem)
//        }
//        else {
//            fatalError("Inserting item into queue failed.")
//        }
//    }
    
    func playAudio(recordVol : Bool) {
        player.play()
        //  Record the volume for everytime the audio starts playing.
        if recordVol{
            diary.diaryData["volumes"] = (diary.diaryData["volumes"] as! [Float]) + [audioSession.outputVolume]
            diary.upload()
            diary.diaryData["timesRecordVolume"] = (diary.diaryData["timesRecordVolume"] as! [Date]) + [Date()]
            diary.upload()
        }
    }
    
    func pauseAudio(recordVol : Bool) {
        if recordVol {
            diary.diaryData["volumes"] = (diary.diaryData["volumes"] as! [Float]) + [audioSession.outputVolume]
            diary.upload()
            diary.diaryData["timesRecordVolume"] = (diary.diaryData["timesRecordVolume"] as! [Date]) + [Date()]
            diary.upload()
            }
        player.pause()
    }
    
    func stopAudio(recordVol : Bool) {
        if recordVol {
            diary.diaryData["volumes"] = (diary.diaryData["volumes"] as! [Float]) + [audioSession.outputVolume]
            diary.upload()
            diary.diaryData["timesRecordVolume"] = (diary.diaryData["timesRecordVolume"] as! [Date]) + [Date()]
            diary.upload()
            }
        player.pause()
        //player.removeAllItems()
    }
    
    func skipToNext() {
        player.advanceToNextItem()
    }
    
    internal func getPlayerItemURL(from playerItem: AVPlayerItem) -> URL {
        return (playerItem.asset as! AVURLAsset).url
    }
    
    //  Called when the "restart" button is pressed. It plays a 20-minute blank
    //  audio file and then the rest of the audio from when "restart" was pressed.
    //  The Bool value returned represents if the audio was restarted or not. (When
    //  nothing is playing it does not make sense to restart the audio.
//    func restartAudio() -> Bool {
//        player.pause()
//        //  If there is no item playing, don't restart
//        guard player.currentItem != nil else {
//            print("Can't restart: no more audio files left.")
//            return false
//        }
//
//        let currentURL = getPlayerItemURL(from: player.currentItem!)
//
//        //  If restart pressed during a language audio file: play whitenoise (20 mins),
//        //  ocean sounds, and then play from where the audio was paused.
//        if languageAudioURLList.contains(currentURL) {
//            let pausedItem = player.currentItem!
//            let whiteNoise5mins = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins2 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins3 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins4 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins5 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins6 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins7 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins8 = AVPlayerItem(url: whiteNoise5minsURL)
//            let blankAudio40mins = AVPlayerItem(url: blankAudio40minsURL)
//            let oceanAudio = AVPlayerItem(url: oceanURL)
//            if assignedWhiteNoise.lowercased() == "yes" {
//                player.insert(whiteNoise5mins, after: player.currentItem)
//                player.advanceToNextItem()
//                player.insert(whiteNoise5mins2, after: whiteNoise5mins)
//                player.insert(whiteNoise5mins3, after: whiteNoise5mins2)
//                player.insert(whiteNoise5mins4, after: whiteNoise5mins3)
//                player.insert(whiteNoise5mins5, after: whiteNoise5mins4)
//                player.insert(whiteNoise5mins6, after: whiteNoise5mins5)
//                player.insert(whiteNoise5mins7, after: whiteNoise5mins6)
//                player.insert(whiteNoise5mins8, after: whiteNoise5mins7)
//                player.insert(oceanAudio, after: whiteNoise5mins8)
//                player.insert(pausedItem, after: oceanAudio)
//            }
//            else if assignedWhiteNoise.lowercased() == "no" {
//                player.insert(blankAudio40mins, after: player.currentItem)
//                player.advanceToNextItem()
//                player.insert(oceanAudio, after: blankAudio40mins)
//                player.insert(pausedItem, after: oceanAudio)
//            }
//            //let soundAudio5mins = AVPlayerItem(url: soundAudio5minsURL)
//        }
//
//        //  If restart pressed during a white noise audio file: restart the white noise audio from the beginning (with same offset).
//        if whiteOrSilentURLList.contains(currentURL) {
//            player.removeAllItems()
//            loadAudioToStartSession()
//        }
//
//        //  If restart pressed during one of the blank audio files/white noise: restart
//        //  no longer do nothing
//        /*else if [blankAudio20minsURL, blankAudio40minsURL,].contains(currentURL) {
//            //print("Can't restart: No audio is playing")
//            //self.playAudio(recordVol: false)
//            //return false
//            let pausedItem = player.currentItem!
//            let whiteNoise5mins = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins2 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins3 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins4 = AVPlayerItem(url: whiteNoise5minsURL)
//            let blankAudio20mins = AVPlayerItem(url: blankAudio20minsURL)
//            let oceanAudio = AVPlayerItem(url: oceanURL)
//            if assignedWhite.lowercased() == "whitenoise" {
//                player.insert(whiteNoise5mins, after: player.currentItem)
//                player.advanceToNextItem()
//                player.insert(whiteNoise5mins2, after: whiteNoise5mins)
//                player.insert(whiteNoise5mins3, after: whiteNoise5mins2)
//                player.insert(whiteNoise5mins4, after: whiteNoise5mins3)
//                player.insert(oceanAudio, after: whiteNoise5mins4)
//                player.insert(pausedItem, after: oceanAudio)
//            }
//            else if assignedWhite.lowercased() == "silent" {
//                player.insert(blankAudio20mins, after: player.currentItem)
//                player.advanceToNextItem()
//                player.insert(oceanAudio, after: blankAudio20mins)
//                player.insert(pausedItem, after: oceanAudio)
//            }
//        }*/
//
//        //  If restart pressed during the rain (ocean) sound: play whitenoise (20 mins), rain sounds,
//        //  and then play the language audio files left to play.
//        else if [oceanURL].contains(currentURL){
//            let whiteNoise5mins = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins2 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins3 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins4 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins5 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins6 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins7 = AVPlayerItem(url: whiteNoise5minsURL)
//            let whiteNoise5mins8 = AVPlayerItem(url: whiteNoise5minsURL)
//            let blankAudio40mins = AVPlayerItem(url: blankAudio40minsURL)
//            let oceanAudio = AVPlayerItem(url: oceanURL)
//            if assignedWhiteNoise.lowercased() == "yes" {
//                player.insert(whiteNoise5mins, after: player.currentItem)
//                player.advanceToNextItem()
//                player.insert(whiteNoise5mins2, after: whiteNoise5mins)
//                player.insert(whiteNoise5mins3, after: whiteNoise5mins2)
//                player.insert(whiteNoise5mins4, after: whiteNoise5mins3)
//                player.insert(whiteNoise5mins5, after: whiteNoise5mins4)
//                player.insert(whiteNoise5mins6, after: whiteNoise5mins5)
//                player.insert(whiteNoise5mins7, after: whiteNoise5mins6)
//                player.insert(whiteNoise5mins8, after: whiteNoise5mins7)
//                player.insert(oceanAudio, after: whiteNoise5mins8)
//            }
//            else if assignedWhiteNoise.lowercased() == "no" {
//                player.insert(blankAudio40mins, after: player.currentItem)
//                player.advanceToNextItem()
//                player.insert(oceanAudio, after: blankAudio40mins)
//            }
//            //let soundAudio5mins = AVPlayerItem(url: soundAudio5minsURL)
//            //player.insert(blankAudio20mins, after: player.currentItem)
//        }
//        else{
//            print("Don't restart: White noise audio playing")
//            self.playAudio(recordVol: false)
//            return false
//        }
//        self.playAudio(recordVol: true)
//        return true
//    }
//}
}

let audioPlayer = AudioPlayer()
