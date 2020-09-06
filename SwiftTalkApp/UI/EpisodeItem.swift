//
//  EpisodeItem.swift
//  SwiftTalkApp
//
//  Created by Abdullah Althobetey on 06/09/2020.
//  Copyright © 2020 Abdullah Althobetey. All rights reserved.
//

import SwiftUI
import Model
import TinyNetworking

struct EpisodeItem: View {
    
    let episode: EpisodeView
    @ObservedObject var imageResource: Resource<UIImage>
    @ObservedObject var store = sharedStore
    
    init(_ episode: EpisodeView) {
        self.episode = episode
        self.imageResource = Resource(endpoint: Endpoint(imageURL: episode.poster_url))
    }
    
    var body: some View {
        HStack {
            if imageResource.value != nil {
                Image(uiImage: imageResource.value!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(store.collection(for: episode)?.title ?? "")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                Text(episode.title)
                    .font(.headline)
                Text(episode.durationAndDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct EpisodeItem_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeItem(sampleEpisodes[0])
    }
}
