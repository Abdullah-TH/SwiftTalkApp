//
//  EpisodeProgress.swift
//  SwiftTalkApp
//
//  Created by Abdullah Althobetey on 07/09/2020.
//  Copyright © 2020 Abdullah Althobetey. All rights reserved.
//

import Foundation
import Combine
import Model

final class EpisodeProgress: ObservableObject {
    
    let episode: EpisodeView
    @Published var progress: TimeInterval
    
    init(episode: EpisodeView, progress: TimeInterval) {
        self.episode = episode
        self.progress = progress
    }
}
