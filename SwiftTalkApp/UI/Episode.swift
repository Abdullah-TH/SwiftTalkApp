//
//  Episode.swift
//  SwiftTalkApp
//
//  Created by Abdullah Althobetey on 06/09/2020.
//  Copyright © 2020 Abdullah Althobetey. All rights reserved.
//

import SwiftUI
import Model
import TinyNetworking

struct PlayState {
    
    var isPlaying = false {
        didSet {
            if isPlaying { startedPlaying = true }
        }
    }
    
    var startedPlaying = false
}

struct Episode: View {
    
    let episode: EpisodeView
    @State var playState = PlayState()
    @ObservedObject var imageResource: Resource<UIImage>
    @ObservedObject var progress: EpisodeProgress
    
    init(_ episode: EpisodeView) {
        self.episode = episode
        self.imageResource = Resource(endpoint: Endpoint(imageURL: episode.poster_url))
        self.progress = EpisodeProgress(episode: episode, progress: 0) // todo real progress
    }
    
    var overlayImage: AnyView? {
        if let image = imageResource.value, !playState.startedPlaying {
            return AnyView(
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(16/9, contentMode: .fit)
            )
        } else {
            return nil
        }
    }
    
    var body: some View {
        VStack {
            Text(episode.title)
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(nil)
            Text(episode.synopsis)
                .lineLimit(nil)
            Player(
                url: episode.mediaURL!,
                isPlaying: $playState.isPlaying,
                playPosition: $progress.progress,
                overlay: overlayImage
            )
                .aspectRatio(16/9, contentMode: .fit)
            Slider(value: $progress.progress, in: 0...TimeInterval(episode.media_duration))
            Spacer()
        }
    }
}

struct Episode_Previews: PreviewProvider {
    static var previews: some View {
        Episode(sampleEpisodes[0])
    }
}
