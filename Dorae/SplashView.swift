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
                    VideoPlayer(player: player)
                        .onAppear {
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

#Preview {
    SplashView()
}
