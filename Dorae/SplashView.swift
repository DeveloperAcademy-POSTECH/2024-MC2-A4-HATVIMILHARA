//
//  SplashView.swift
//  Dorae
//
//  Created by 한인우 on 5/25/24.
//

import SwiftUI
import AVKit

struct SplashView: View {
    @StateObject private var viewModel = PlayerViewModel()

    var body: some View {
        Group {
            if viewModel.isVideoFinished {
                HomeView()
            } else {
                if let player = viewModel.player {
                    VideoPlayerView(player: player)
                        .onAppear {
                            viewModel.setupAudioSession()
                            player.play()
                        }
                        .edgesIgnoringSafeArea(.all)
                } else {
                    Text("Splash video not found")
                        .foregroundColor(.red)
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}
struct VideoPlayerView: UIViewControllerRepresentable {
    var player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // 필요한 경우 업데이트 로직 추가
    }
}

#Preview {
    SplashView()
}
