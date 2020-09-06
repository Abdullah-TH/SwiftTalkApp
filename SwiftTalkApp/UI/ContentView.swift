//
//  ContentView.swift
//  SwiftTalkApp
//
//  Created by Abdullah Althobetey on 17/08/2020.
//  Copyright © 2020 Abdullah Althobetey. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var store = sharedStore
    
    var body: some View {
        Group {
            if !store.loaded {
                Text("Loading...")
            } else {
                NavigationView {
                    CollectionsList(collections: store.collections)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
