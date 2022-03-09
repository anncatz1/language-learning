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

//  This function sets the assigned language field. This function uses closures
//  that run asynchronously, so it needs to get called early so it completes running
//  before assignedLanguage is used.
//  Currently it is called in application() in AppDelegate.
//  Read more on closures: https://docs.swift.org/swift-book/LanguageGuide/Closures.html
func setAssignedLanguage() {
    let Database = Firestore.firestore()
    
    //  Assigned language can be found in "Subjects -> [userEmail] -> language"
    guard let userEmail = Auth.auth().currentUser?.email else {
        print("No User Email")
        return
    }
    let userInfoDocRef = Database.collection("Subjects").document(userEmail)
    userInfoDocRef.getDocument { (document, error) in
        if let document = document, document.exists {
            assignedLanguage = (document.data()!["language"] as! String)
        }
        else {
            fatalError("User document does not exist")
        }
    }
}

//  Create the audio stream list filled with the assigned language audio files.
//  IMPORTANT: If audio files on the server are changed, this chunk of code has to
//  be update. Pay attention to extensions (m4a, mp4, mp3, etc.).
func getLangAudioStreamList() -> URL {
    var audioName = ""
    let listArabic =
    ["arabic-f1-part1_MG-JL",
    "arabic-f1-part2_JL",
    "arabic-f1-part3_JS",
    "arabic-f2-part1_MG-YZ",
    "arabic-f2-part2_MG-YZ-MG",
    "arabic-f2-part3_MG-JS",
    "arabic-f3-part1_JL-JL",
    "arabic-f3-part2_JS-JS",
    "arabic-f3-part3_JS-MG",
    "arabic-f4-part1_YZ-JL-JS",
    "arabic-f4-part2_MG-YZ",
    "arabic-f4-part3_JL",
    "arabic-f5-part1_JS-JL",
    "arabic-f5-part2_JL-JS",
    "arabic-f6-part1_MG",
    "arabic-Q1-part1_MG",
    "arabic-Q1-part2_JS-YZ-YZ",
    "arabic-Q1-part3_JL-JS",
    "arabic-Q2-part1_JL-MG",
    "arabic-Q2-part2_YZ-JS",
    "arabic-Q2-part3_JS-MG",
    "arabic-Q3-part1_JS",
    "arabic-Q3-part2_YZ",
    "arabic-Q3-part3_YZ-JS",
    "arabic-Q4-part1_JL",
    "arabic-Q4-part2_MG-YZ",
    "arabic-Q4-part3_MG",
    "arabic-Q5-part1_JS-YZ-JS",
    "arabic-Q5-part2_MG",
    "arabic-Q5-part3_YZ-MG",
    "arabic-Q6-part1_JS-JS",
    "arabic-Q6-part2_JL-JL-YZ",
    "arabic-Q6-part3_JL-JL-MG",
    "arabic-S1-part1_YZ-JS-YZ",
    "arabic-S1-part2_JS",
    "arabic-S1-part3_MG-YZ-JS",
    "arabic-S2-part1_YZ",
    "arabic-S2-part2_YZ-JL",
    "arabic-S2-part3_JS-MG",
    "arabic-S3-part1_MG-JL",
    "arabic-S3-part2_JS",
    "arabic-S3-part3_JS",
    "arabic-S4-part1_MG",
    "arabic-S4-part2_JL-JL",
    "arabic-S4-part3_MG-YZ-JL"]
    let listMandarin =
    ["mandarin_Q1-part1_JL-JS",
    "mandarin_Q1-part2_JS",
    "mandarin_Q1-part3_YZ",
    "mandarin_Q2-part1_YZ-JL-MG",
    "mandarin_Q2-part2_JS",
    "mandarin_Q2-part3_MG-JL",
    "mandarin_Q3-part1_JS-YZ-YZ",
    "mandarin_Q3-part2_JS-JL",
    "mandarin_Q3-part3_YZ-YZ",
    "mandarin_Q4-part1_JL-JL-MG",
    "mandarin_Q4-part2_MG-JS",
    "mandarin_Q4-part3_YZ",
    "mandarin_Q5-part1_JS-YZ-JS",
    "mandarin_Q5-part2_MG-MG-JL",
    "mandarin_Q5-part3_YZ-MG",
    "mandarin_S1-part1_MG",
    "mandarin_S1-part2_YZ-YZ-JL",
    "mandarin_S1-part3_JL-JS-MG",
    "mandarin_S2-part1_JS-JL",
    "mandarin_S2-part2_MG-MG",
    "mandarin_S2-part3_JL-JS-YZ",
    "mandarin_S3-part1_YZ-YZ-JS",
    "mandarin_S3-part2_JS-JL",
    "mandarin_S3-part3_JL-JL-MG",
    "mandarin_S4-part1_YZ-MG-YZ",
    "mandarin_S4-part2_YZ",
    "mandarin_S4-part3_MG-JS-JL",
    "mandarin_S5-part1_JS",
    "mandarin_S5-part2_MG-YZ-YZ",
    "mandarin_S5-part3_YZ",
    "Mandarin-5-part1_JL-MG",
    "Mandarin-6-part1_JL-JS",
    "Mandarin-6-part2_MG-JS",
    "Mandarin-6-part3_JL-YZ",
    "Mandarin-7-part1_JS",
    "Mandarin-7-part2_YZ-JL-JL",
    "Mandarin-7-part3_JS-JS",
    "Mandarin-8-part1_MG",
    "Mandarin-8-part2_YZ-YZ-JL",
    "Mandarin-8-part3_MG-YZ",
    "Mandarin-9-part1_MG-JL",
    "Mandarin-9-part2_YZ-MG",
    "Mandarin-9-part3_JS-JS",
    "Mandarin-10-part1_JS",
    "Mandarin-10-part2_MG-MG",
    "Mandarin-10-part3_JS",
    "Mandarin-11-part1_JL-MG-JL",
    "Mandarin-11-part2_YZ-JL",
    "Mandarin-11-part3_MG-JS-JS",
    "mandarin-f1-part1_JL-JL",
    "mandarin-f1-part2_YZ-YZ",
    "mandarin-f1-part3_JS-MG-YZ",
    "mandarin-f2-part1_MG",
    "mandarin-f2-part2_YZ-JS-JL",
    "mandarin-f4-part1_MG",
    "mandarin-f4-part2_JL",
    "mandarin-f4-part3_JS",
    "mandarin-f5-part1_MG",
    "mandarin-f5-part2_JS-JL-YZ",
    "mandarin-f5-part3_JL-JL",
    "mandarin-f6-part1_MG-MG"]
    if assignedLanguage.lowercased() == "arabic" {
        //picks random number between 1 and 10 including 10 to choose audio file
        let audioInt = Int.random(in: 0 ... 44)
        audioName = listArabic[audioInt]
        diary.diaryData["audioFile"] = audioName
        diary.upload()
        diary.eventFile(fileName : audioName)
        audioName = "arabic/" + audioName
    }
    else if assignedLanguage.lowercased() == "mandarin" {
        //picks random number between 1 and 10 including 10 to choose audio file
        let audioInt = Int.random(in: 0 ... 60)
        audioName = listMandarin[audioInt]
        diary.diaryData["audioFile"] = audioName
        diary.upload()
        diary.eventFile(fileName : audioName)
        audioName = "mandarin/" + audioName
    }
    else {
        fatalError("Error: Invalid Language. No audio will be played.")
    }
    //listAudio.map {URL(string: server + $0 + ".m4a")!}
    return URL(string: server + audioName + ".m4a")!
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
//var languageAudioStreamList = getLangAudioStreamList()
let languageAudioURLList: [URL] = [getLangAudioStreamList()]
let blankAudio40minsURL = URL(string: server + "40-minutes-of-silence.m4a")!

//old
//let whiteOrSilentAudio5minsURL = URL(string: server + WhiteOrSilent)!
//let whiteOrSilentURLList: [URL] = [URL](repeating: whiteOrSilentAudio5minsURL, count: audioOffset!/5)
//let whiteOrSilentAudioURLList20min: [URL] = [URL](repeating: whiteOrSilentAudio5minsURL, count: 4)
//let whiteOrSilentAudioURLList40min: [URL] = [URL](repeating: whiteOrSilentAudio5minsURL, count: 8)

//let blankAudio5minsURL = URL(string: server + "5-minutes-of-silence.m4a")!
//let whiteNoise5minsURL = URL(string: server + "whitenoiseaudio.mp3")!
//let blankAudio20minsURL = URL(string: server + "20-minutes-of-silence.m4a")!
//let soundAudio5minsURL = URL(string: server + sound5minFile)!

//let startBlankAudioURLList: [URL] = [URL](repeating: blankAudio5minsURL, count: audioOffset!/5)
//let startSoundAudioURLList: [URL] = [URL](repeating: soundAudio5minsURL, count: audioOffset!/5)
//let whiteNoiseAudioURLList: [URL] = [URL](repeating: whiteNoise5minsURL, count: audioOffset!/5)
//let startSoundAudioURLList20min: [URL] = [URL](repeating: soundAudio5minsURL, count: 4)
//let whiteNoiseAudioURLList20min: [URL] = [URL](repeating: whiteNoise5minsURL, count: 4)
// end of old

let endBlankAudioURLList: [URL] = [URL](repeating: blankAudio40minsURL, count: 2)

//  The "ocean" file is what's played before the language starts playing and also used to
//  calibrate the volume. It is no longer actual ocean sounds but the name has remained out
//  of laziness.
let oceanURL = URL(string: server + "ocean.mp3")!

