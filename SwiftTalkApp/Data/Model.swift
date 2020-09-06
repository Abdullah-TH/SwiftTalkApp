//
//  Model.swift
//  SwiftTalkApp
//
//  Created by Abdullah Althobetey on 17/08/2020.
//  Copyright © 2020 Abdullah Althobetey. All rights reserved.
//

import Foundation
import TinyNetworking
import Model

extension CollectionView: Identifiable {}

extension CollectionView {
    var episodeCountAndTotalDuration: String {
        "\(episodes_count) episodes ᐧ \(TimeInterval(total_duration).hoursAndMinutes)"
    }
}

extension EpisodeView {
    
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }
    
    var durationAndDate: String {
        "\(TimeInterval(media_duration).hoursAndMinutes) - \(dateFormatter.string(from: released_at))"
    }
}

let allCollections = Endpoint<[CollectionView]>(
    json: .get,
    url: URL(string: "https://talk.objc.io/collections.json")!
)

let allEpisodes = Endpoint<[EpisodeView]>(
    json: .get,
    url: URL(string: "https://talk.objc.io/episodes.json")!
)

import Combine
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
}

let sharedStore = Store()

func sample<A: Codable>(name: String) -> A {
    let url = Bundle.main.url(forResource: name, withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    return try! decoder.decode(A.self, from: data)
}

let sampleCollections: [CollectionView] = sample(name: "collections")
let sampleEpisodes: [EpisodeView] = sample(name: "episodes")
