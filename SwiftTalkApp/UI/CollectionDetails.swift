//
//  CollectionDetails.swift
//  SwiftTalkApp
//
//  Created by Abdullah Althobetey on 17/08/2020.
//  Copyright © 2020 Abdullah Althobetey. All rights reserved.
//

import SwiftUI
import Model
import TinyNetworking

struct ImageError: Error {}

extension Endpoint where A == UIImage {
    
    init(imageURL url: URL) {
        self.init(
            .get,
            url: url,
            expectedStatusCode: expected200to300
        ) { data, response in
            guard let data = data, let image = UIImage(data: data) else {
                return .failure(ImageError())
            }
            return .success(image)
        }
    }
}

struct CollectionDetails: View {
    
    let collection: CollectionView
    @ObservedObject var store = sharedStore
    @ObservedObject var imageResource: Resource<UIImage>
    
    init(collection: CollectionView) {
        self.collection = collection
        self.imageResource = Resource<UIImage>(
            endpoint: Endpoint(imageURL: collection.artwork.png)
        )
    }
    
    var collectionEpisodes: [EpisodeView] {
        return store.episodes.filter { $0.collection == collection.id} 
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if imageResource.value != nil {
                Image(uiImage: imageResource.value!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(collection.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(nil)
                    if collection.new {
                        NewBadge()
                    }
                }
                Text(collection.episodeCountAndTotalDuration)
                    .foregroundColor(.gray)
                    .padding([.bottom])
                Text(collection.description)
                .lineLimit(nil)
            }
            .padding([.leading, .trailing])
            List {
                ForEach(collectionEpisodes, id: \.id) { episode in
                    NavigationLink(destination: Episode(episode)) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(episode.title)
                                .font(.headline)
                            Text(episode.durationAndDate)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
    }
}

struct CollectionDetails_Previews: PreviewProvider {
    static var previews: some View {
        CollectionDetails(
            collection: sampleCollections[1]
        )
    }
}
