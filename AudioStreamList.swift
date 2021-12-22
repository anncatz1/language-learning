//
//  AudioStreamList.swift
//  Sleep Learning
//
//  Created by Mani Jahani on 6/12/19.
//  Copyright © 2019 Memory Lab. All rights reserved.
//
//  Description:
//      Declares the list of the URL's for the audio streams.
//
//  GOOD CHANGE TO IMPLEMENT:
//      Allow for adding more files to the server without having to update
//      the App's code. Could have a list of audio files on the server
//      to read.
//

import Foundation
import Firebase
import FirebaseFirestore

//  Get assigned language and audio offset time from the user database and
//  set the stream list correspondingly
var assignedLanguage: String = ""
//var assignedSound: String = ""
//var assignedWhiteNoise: String = ""
var audioOffset: Int? = 0

//  This function sets the assigned language field. This function uses closures
//  that run asynchronously, so it needs to get called early so it completes running
//  before assignedLanguage is used.
//  Currently it is called in application() in AppDelegate.
//  Read more on closures: https://docs.swift.org/swift-book/LanguageGuide/Closures.html
func setAssignedLanguage() {
    let Database = Firestore.firestore()
    
    //  Assigned language can be found in "Subjects -> [userEmail] -> language"
    //  Offset value can be found in "Subjects -> [userEmail] -> offset"
    guard let userEmail = Auth.auth().currentUser?.email else {
        print("No User Email")
        return
    }
    let userInfoDocRef = Database.collection("Subjects").document(userEmail)
    userInfoDocRef.getDocument { (document, error) in
        if let document = document, document.exists {
            assignedLanguage = (document.data()!["language"] as! String)
            //assignedWhiteNoise = (document.data()!["whitenoise"] as! String) //if yes, there is white noise; no means it's silent
            //audioOffset = Int(document.data()!["offset"] as! String)
            if audioOffset == nil { fatalError("Invalid audio offset") }
        }
        else {
            fatalError("User document does not exist")
        }
    }
}

//  Create the audio stream list filled with the assigned language audio files.
//  IMPORTANT: If audio files on the server are changed, this chunk of code has to
//  be update. Pay attention to extensions (m4a, mp4, mp3, etc.).
var languageAudioStreamList: [String] {
    get {
        if assignedLanguage.lowercased() == "mandarin" {
            //picks random number between 1 and 10 including 10 to choose audio file
            let audio = Int.random(in: 1 ... 18)
            switch audio {
            case 1:
                diary.diaryData["audioFile"] = "mandarin-1 & mandarin-2"
                diary.upload()
                return ["mandarin-1.m4a", "mandarin-2.m4a"]
            case 2:
                diary.diaryData["audioFile"] = "mandarin-5"
                diary.upload()
                return ["mandarin-5.m4a"]
            case 3:
                diary.diaryData["audioFile"] = "mandarin-6"
                diary.upload()
                return ["mandarin-6.m4a"]
            case 4:
                diary.diaryData["audioFile"] = "mandarin-7"
                diary.upload()
                return ["mandarin-7.m4a"]
            case 5:
                diary.diaryData["audioFile"] = "mandarin-8"
                diary.upload()
                return ["mandarin-8.m4a"]
            case 6:
                diary.diaryData["audioFile"] = "mandarin-9"
                diary.upload()
                return ["mandarin-9.m4a"]
            case 7:
                diary.diaryData["audioFile"] = "mandarin-10"
                diary.upload()
                return ["mandarin-10.m4a"]
            case 8:
                diary.diaryData["audioFile"] = "mandarin-11"
                diary.upload()
                return ["mandarin-11.m4a"]
            case 9:
                diary.diaryData["audioFile"] = "mandarin-Q1"
                diary.upload()
                return ["mandarin_Q1.m4a"]
            case 10:
                diary.diaryData["audioFile"] = "mandarin-Q2"
                diary.upload()
                return ["mandarin_Q2.m4a"]
            case 11:
                diary.diaryData["audioFile"] = "mandarin-Q3"
                diary.upload()
                return ["mandarin_Q3.m4a"]
            case 12:
                diary.diaryData["audioFile"] = "mandarin-Q4"
                diary.upload()
                return ["mandarin_Q4.m4a"]
            case 13:
                diary.diaryData["audioFile"] = "mandarin-Q5"
                diary.upload()
                return ["mandarin_Q5.m4a"]
            case 14:
                diary.diaryData["audioFile"] = "mandarin-S1"
                diary.upload()
                return ["mandarin_S1.m4a"]
            case 15:
                diary.diaryData["audioFile"] = "mandarin-S2"
                diary.upload()
                return ["mandarin_S2.m4a"]
            case 16:
                diary.diaryData["audioFile"] = "mandarin-S3"
                diary.upload()
                return ["mandarin_S3.m4a"]
            case 17:
                diary.diaryData["audioFile"] = "mandarin-S4"
                diary.upload()
                return ["mandarin_S4.m4a"]
            case 18:
                diary.diaryData["audioFile"] = "mandarin-S5"
                diary.upload()
                return ["mandarin_S5.m4a"]
            default:
                diary.diaryData["audioFile"] = "mandarin-1 & mandarin-2"
                diary.upload()
                return ["mandarin-1.m4a", "mandarin-2.m4a"]
            }
        }
        else if assignedLanguage.lowercased() == "arabic" {
            let audio = Int.random(in: 1 ... 13)
            //let audio = 12
            switch audio {
            case 1:
                diary.diaryData["audioFile"] = "arabic-1,2,3"
                diary.upload()
                return ["arabic-1.m4a", "arabic-2.m4a", "arabic-3.m4a"]
            case 2:
                diary.diaryData["audioFile"] = "arabic-f1"
                diary.upload()
                return ["arabic-f1.m4a"]
            case 3:
                diary.diaryData["audioFile"] = "arabic-f2"
                diary.upload()
                return ["arabic-f2.m4a"]
            case 4:
                diary.diaryData["audioFile"] = "arabic-f3"
                diary.upload()
                return ["arabic-f3.m4a"]
            case 5:
                diary.diaryData["audioFile"] = "arabic-f4"
                diary.upload()
                return ["arabic-f4.m4a"]
            case 6:
                diary.diaryData["audioFile"] = "arabic-f5"
                diary.upload()
                return ["arabic-f5.m4a"]
            case 7:
                diary.diaryData["audioFile"] = "arabic-f6"
                diary.upload()
                return ["arabic-f6.m4a"]
            case 8:
                diary.diaryData["audioFile"] = "arabic-S1"
                diary.upload()
                return ["arabic-S1.m4a"]
            case 9:
                diary.diaryData["audioFile"] = "arabic-S2"
                diary.upload()
                return ["arabic-S2.m4a"]
            case 10:
                diary.diaryData["audioFile"] = "arabic-S3"
                diary.upload()
                return ["arabic-S3.m4a"]
            case 11:
                diary.diaryData["audioFile"] = "arabic-S4"
                diary.upload()
                return ["arabic-S4.m4a"]
            case 12:
                diary.diaryData["audioFile"] = "arabic-Q3"
                diary.upload()
                return ["arabic-Q3.m4a"]
            case 13:
                diary.diaryData["audioFile"] = "arabic-Q5"
                diary.upload()
                return ["arabic-Q5.m4a"]
            /*case 14:
                diary.diaryData["audioFile"] = "arabic-Q1"
                diary.upload()
                return ["arabic-Q2.m4a"]
            case 15:
                diary.diaryData["audioFile"] = "arabic-Q2"
                diary.upload()
                return ["arabic-Q3.m4a"]
            case 16:
                diary.diaryData["audioFile"] = "arabic-Q4"
                diary.upload()
                return ["arabic-Q4.m4a"]
            case 17:
                diary.diaryData["audioFile"] = "arabic-Q6"
                diary.upload()
                return ["arabic-Q5.m4a"]*/
            default:
                diary.diaryData["audioFile"] = "arabic-1,2,3"
                diary.upload()
                return ["arabic-1.m4a", "arabic-2.m4a", "arabic-3.m4a"]
            }
        }
        else {
            fatalError("Error: Invalid Language. No audio will be played.")
        }
    }
}

//  Get the audio file of the choice of sounds before going to sleep
//  IMPORTANT: If audio files on the server are changed, this chunk of code has to
//  be update. Pay attention to extensions (m4a, mp4, mp3, etc.).
/*var sound5minFile: String {
    get {
        if assignedSound.lowercased() == "fan" {
            return "5min%20sounds/Fan"
        }
        else if assignedSound.lowercased() == "frog" {
            return "5min%20sounds/Frog"
        }
        else if assignedSound.lowercased() == "fire" {
            return "5min%20sounds/Fire"
        }
        else if assignedSound.lowercased() == "sea" {
            return "5min%20sounds/Sea"
        }
        else if assignedSound.lowercased() == "white" {
            return "5min%20sounds/White"
        }
        else {
            fatalError("Error: Invalid Sound. No audio will be played.")
        }
    }
}*/

//var WhiteOrSilent: String {
//    get {
//        if assignedWhiteNoise.lowercased() == "yes" {
//            return "whitenoiseaudio.mp3"
//        }
//        else if assignedWhiteNoise.lowercased() == "no" {
//            return "5-minutes-of-silence.m4a"
//        }
//        else {
//            fatalError("Error: Invalid Sound. No audio will be played.")
//        }
//    }
//}

//  For testing add "test/" at the end of the server, but make sure to change it back
//  afterwards. The test folder includes very short single sound audio files for you
//  to make sure that all appropriate audio files are indeed being played without having
//  to 5+ hours.
//  WARNING: The test audio working does not guarantee that the regular audio playback will
//  also work. It's possible that the longer audio stops playing because the app enters the
//  background after a long period of time or for some other reason. Make sure to check that
//  as well.
let server = "https://storage.googleapis.com/sleep-learning-app/audio-files/"

//  Create URLs for all of the language audio
let languageAudioURLList: [URL] = languageAudioStreamList.map {
    URL(string: server + $0)!
}

//let whiteOrSilentAudio5minsURL = URL(string: server + WhiteOrSilent)!
//let whiteOrSilentURLList: [URL] = [URL](repeating: whiteOrSilentAudio5minsURL, count: audioOffset!/5)
//let whiteOrSilentAudioURLList20min: [URL] = [URL](repeating: whiteOrSilentAudio5minsURL, count: 4)
//let whiteOrSilentAudioURLList40min: [URL] = [URL](repeating: whiteOrSilentAudio5minsURL, count: 8)

////old
//let blankAudio5minsURL = URL(string: server + "5-minutes-of-silence.m4a")!
//let whiteNoise5minsURL = URL(string: server + "whitenoiseaudio.mp3")!
//let blankAudio20minsURL = URL(string: server + "20-minutes-of-silence.m4a")!
let blankAudio40minsURL = URL(string: server + "40-minutes-of-silence.m4a")!
//let soundAudio5minsURL = URL(string: server + sound5minFile)!

//let startBlankAudioURLList: [URL] = [URL](repeating: blankAudio5minsURL, count: audioOffset!/5)
//let startSoundAudioURLList: [URL] = [URL](repeating: soundAudio5minsURL, count: audioOffset!/5)
//let whiteNoiseAudioURLList: [URL] = [URL](repeating: whiteNoise5minsURL, count: audioOffset!/5)
//let startSoundAudioURLList20min: [URL] = [URL](repeating: soundAudio5minsURL, count: 4)
//let whiteNoiseAudioURLList20min: [URL] = [URL](repeating: whiteNoise5minsURL, count: 4)
// end of old

let endBlankAudioURLList: [URL] = [URL](repeating: blankAudio40minsURL, count: 12)

//  The "ocean" file is what's played before the language starts playing and also used to
//  calibrate the volume. It is no longer actual ocean sounds but the name has remained out
//  of laziness.
let oceanURL = URL(string: server + "ocean.mp3")!
