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
        let audioFilesList = (startBlankAudioURLList + [oceanURL] + languageAudioURLList + endBlankAudioURLList).map {
            AVPlayerItem(url: $0)
        }
        player = AVQueuePlayer(items: audioFilesList)
    }
    
    //  Loads a single audio file into the player. Used for volume calibration.
    func loadAudio(with audioURL: URL) {
        player.removeAllItems()
        let playerItem = AVPlayerItem(url: audioURL)
        if player.canInsert(playerItem, after: player.currentItem) {
            player.insert(playerItem, after: player.currentItem)
        }
        else {
            fatalError("Inserting item into queue failed.")
        }
    }
    
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
    
    func stopAudio(recordVol : Bool) {
        if recordVol {
            diary.diaryData["volumes"] = (diary.diaryData["volumes"] as! [Float]) + [audioSession.outputVolume]
            diary.upload()
            diary.diaryData["timesRecordVolume"] = (diary.diaryData["timesRecordVolume"] as! [Date]) + [Date()]
            diary.upload()
            }
        player.pause()
        player.removeAllItems()
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
    func restartAudio() -> Bool {
        player.pause()
        //  If there is no item playing, don't restart
        guard player.currentItem != nil else {
            print("Can't restart: no more audio files left.")
            return false
        }
        
        let currentURL = getPlayerItemURL(from: player.currentItem!)
        
        //  If restart pressed during a language audio file: play blank (20 mins),
        //  ocean sounds, and then play from where the audio was paused.
        if languageAudioURLList.contains(currentURL) {
            let pausedItem = player.currentItem!
            let blankAudio20mins = AVPlayerItem(url: blankAudio20minsURL)
            let oceanAudio = AVPlayerItem(url: oceanURL)
            player.insert(blankAudio20mins, after: player.currentItem)
            player.advanceToNextItem()
            player.insert(oceanAudio, after: blankAudio20mins)
            player.insert(pausedItem, after: oceanAudio)
        }
            
        //  If restart pressed during one of the blank audio files: do nothing
        else if [blankAudio5minsURL, blankAudio20minsURL, blankAudio40minsURL].contains(currentURL) {
            print("Can't restart: No audio is playing")
            self.playAudio(recordVol: true)
            return false
        }
            
        //  If restart pressed during the ocean sound: play blank (20 mins), ocean sounds,
        //  and then play the language audio files left to play.
        else {
            let blankAudio20mins = AVPlayerItem(url: blankAudio20minsURL)
            let oceanAudio = AVPlayerItem(url: oceanURL)
            player.insert(blankAudio20mins, after: player.currentItem)
            player.advanceToNextItem()
            player.insert(oceanAudio, after: blankAudio20mins)
        }
        self.playAudio(recordVol: true)
        return true
    }
    
   /* func setupNotifications() {
        // Get the default notification center instance.
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(handleRouteChange),
                       name: AVAudioSession.routeChangeNotification,
                       object: nil)
        nc.addObserver(self,
        selector: #selector(handleInterruption),
        name: AVAudioSession.interruptionNotification,
        object: nil)
    }

    @objc func handleRouteChange(notification: Notification) {
        // To be implemented.
    }

    @objc func handleInterruption(notification: Notification) {
        // To be implemented.
    }*/
}

let audioPlayer = AudioPlayer()
