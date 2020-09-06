//
//  CollectionRow.swift
//  SwiftTalkApp
//
//  Created by Abdullah Althobetey on 02/09/2020.
//  Copyright © 2020 Abdullah Althobetey. All rights reserved.
//

import SwiftUI
import Model

struct CollectionRow: View {
    
    let collection: CollectionView
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(collection.title)
                Text("\(collection.episodes_count) episodes - \(TimeInterval(collection.total_duration).hoursAndMinutes)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            if collection.new {
                Spacer()
                newBadge
            }
        }
    }
}

struct CollectionRow_Previews: PreviewProvider {
    static var previews: some View {
        CollectionRow(collection: sampleCollections[0])
            .previewLayout(.fixed(width: 300, height: 50))
    }
}
