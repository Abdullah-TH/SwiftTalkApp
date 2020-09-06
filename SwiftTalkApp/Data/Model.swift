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


func sample<A: Codable>(name: String) -> A {
    let url = Bundle.main.url(forResource: name, withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    return try! decoder.decode(A.self, from: data)
}

let sampleCollections: [CollectionView] = sample(name: "collections")
let sampleEpisodes: [EpisodeView] = sample(name: "episodes")
