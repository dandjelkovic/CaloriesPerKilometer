//
//  ContentView.swift
//  CaloriesPerKilometer
//
//  Created by Dalibor Andjelkovic on 10.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: Store

    var body: some View {
        NavigationView {
            VStack {
                if !store.actvities.isEmpty {
                    Stats(activites: $store.actvities)
                } else {
                    if store.authSucceededButNotFinished {
                        Text("Receiving Activities")
                    } else {
                        NavigationLink(destination: StravaAuth()) {
                            Text("Connect Strava").bold()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: store)
    }
}
