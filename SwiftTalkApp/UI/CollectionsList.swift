//
//  CollectionsList.swift
//  SwiftTalkApp
//
//  Created by Abdullah Althobetey on 17/08/2020.
//  Copyright © 2020 Abdullah Althobetey. All rights reserved.
//

import SwiftUI
import Model
import ViewHelpers

struct CollectionsList: View {
    
    let collections: [CollectionView]
    
    var body: some View {
        List {
            ForEach(collections) { collection in
                NavigationLink(
                    destination: CollectionDetails(collection: collection)
                ) {
                    CollectionRow(collection: collection)
                }
            }
        }.navigationBarTitle("Collections")
    }
}

struct CollectionsList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CollectionsList(collections: sampleCollections)
        }
    }
}
