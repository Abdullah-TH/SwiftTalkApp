//
//  Store.swift
//  SwiftTalkApp
//
//  Created by Abdullah Althobetey on 06/09/2020.
//  Copyright © 2020 Abdullah Althobetey. All rights reserved.
//

import Foundation
import Combine
import Model

let sharedStore = Store()

final class Store: ObservableObject {
    
    let objectWillChange: AnyPublisher<(), Never>
    let sharedCollections = Resource(endpoint: allCollections)
    let sharedEpisodes = Resource(endpoint: allEpisodes)
    
    init() {
        objectWillChange = sharedCollections.objectWillChange.zip(sharedEpisodes.objectWillChange).map { _ in () }.eraseToAnyPublisher()
    }
    
    var loaded: Bool {
        sharedCollections.value != nil && sharedEpisodes.value != nil
    }
    
    var collections: [CollectionView] {
        sharedCollections.value ?? []
    }
    
    var episodes: [EpisodeView] {
        sharedEpisodes.value ?? []
    }
    
    func collection(for ep: EpisodeView) -> CollectionView? {
        collections.first { $0.id == ep.collection }
    }
}
