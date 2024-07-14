//
//  PlayerViewModel.swift
//  Dorae
//
//  Created by 한인우 on 5/25/24.
//

import AVKit
import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published var isVideoFinished = false
    var player: AVPlayer?

    init() {
        if let url = Bundle.main.url(forResource: "SplashVideo", withExtension: "mp4") {
            self.player = AVPlayer(url: url)
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
        }
    }

    @objc func playerDidFinishPlaying() {
        DispatchQueue.main.async {
            self.isVideoFinished = true
        }
    }
    
    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category: \(error)")
        }
    }
}


