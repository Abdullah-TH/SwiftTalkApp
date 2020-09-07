//
//  Player.swift
//  SwiftTalkApp
//
//  Created by Abdullah Althobetey on 06/09/2020.
//  Copyright © 2020 Abdullah Althobetey. All rights reserved.
//

import SwiftUI
import AVKit

final class PlayerCoordinator<Overlay: View> {
    var observer: NSKeyValueObservation?
    var timeObserver: Any?
    var lastObservedPosition = TimeInterval(0)
    var hostingViewController: UIHostingController<Overlay>?
}

struct Player<Overlay: View>: UIViewControllerRepresentable {
    
    let url: URL
    @Binding var isPlaying: Bool
    @Binding var playPosition: TimeInterval
    let overlay: Overlay?
    
    func makeCoordinator() -> PlayerCoordinator<Overlay?> {
        return PlayerCoordinator()
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: url)
        
        context.coordinator.observer = player.observe(\.rate, options: [.new]) { _, change in
            self.isPlaying = (change.newValue ?? 0) > 0
        }
        
        context.coordinator.timeObserver = player.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1, preferredTimescale: 1),
            queue: .main
        ) { time in
            let position = time.seconds
            self.playPosition = position
            context.coordinator.lastObservedPosition = position
        }
        
        let playerVC = AVPlayerViewController()
        let hostingVC = UIHostingController(rootView: overlay)
        playerVC.player = player
        playerVC.contentOverlayView?.addSubview(hostingVC.view)
        hostingVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingVC.didMove(toParent: playerVC)
        
        context.coordinator.hostingViewController = hostingVC
        
        return playerVC
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        guard let hc = context.coordinator.hostingViewController else { return }
        
        if context.coordinator.lastObservedPosition != playPosition {
            let time = CMTime(seconds: playPosition, preferredTimescale: 1)
            uiViewController.player?.seek(to: time)
        }
        if let overlay = overlay {
            hc.rootView = overlay
            hc.view.isHidden = false
        } else {
            hc.view.isHidden = true
        }
    }
    
    static func dismantleUIViewController(_ uiViewController: AVPlayerViewController, coordinator: PlayerCoordinator<Overlay?>) {
        if let observer = coordinator.timeObserver {
            uiViewController.player?.removeTimeObserver(observer)
        }
    }
}

struct Player_Previews: PreviewProvider {
    static var previews: some View {
        Player(
            url: URL(string: "")!,
            isPlaying: .constant(false),
            playPosition: .constant(0),
            overlay: Text("Some Overlay")
        )
    }
}
