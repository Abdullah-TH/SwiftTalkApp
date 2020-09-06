//
//  AllEpisodes.swift
//  SwiftTalkApp
//
//  Created by Abdullah Althobetey on 06/09/2020.
//  Copyright © 2020 Abdullah Althobetey. All rights reserved.
//

import SwiftUI
import Model
import TinyNetworking

struct AllEpisodes: View {
    
    let episodes: [EpisodeView]
    
    var body: some View {
        List {
            ForEach(episodes, id: \.id) { episode in
                EpisodeItem(episode)
            }
        }
        .navigationBarTitle("All Episodes")
    }
}

struct AllEpisodes_Previews: PreviewProvider {
    static var previews: some View {
        AllEpisodes(episodes: sampleEpisodes)
    }
}
