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
            audioOffset = Int(document.data()!["offset"] as! String)
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
            return ["mandarin-1.m4a", "mandarin-2.m4a"]
        }
        else if assignedLanguage.lowercased() == "arabic" {
            return ["arabic-1.m4a", "arabic-2.m4a", "arabic-3.m4a"]
        }
        else {
            fatalError("Error: Invalid Language. No audio will be played.")
        }
    }
}

//  For testing add "test/" at the end of the server, but make sure to change it back
//  afterwards. The test folder includes very short single sound audio files for you
//  to make sure that all appropriate audio files are indeed being played without having
//  to 5+ hours.
//  WARNING: The test audio working does not guarantee that the regular audio playback will
//  also work. It's possible that the longer audio stops playing because the app enters the
//  background after a long period of time or for some other reason. Make sure to check that
//  as well.
let server = "https://storage.googleapis.com/sleep-learning-app/audio-files/"

//  Create URLs for all of the audio
let languageAudioURLList: [URL] = languageAudioStreamList.map {
    URL(string: server + $0)!
}

let blankAudio5minsURL = URL(string: server + "5-minutes-of-silence.m4a")!
let blankAudio20minsURL = URL(string: server + "20-minutes-of-silence.m4a")!
let blankAudio40minsURL = URL(string: server + "40-minutes-of-silence.m4a")!

let startBlankAudioURLList: [URL] = [URL](repeating: blankAudio5minsURL, count: audioOffset!/5)
let endBlankAudioURLList: [URL] = [URL](repeating: blankAudio40minsURL, count: 12)

//  The "ocean" file is what's played before the language starts playing and also used to
//  calibrate the volume. It is no longer actual ocean sounds but the name has remained out
//  of laziness.
let oceanURL = URL(string: server + "ocean.mp3")!
