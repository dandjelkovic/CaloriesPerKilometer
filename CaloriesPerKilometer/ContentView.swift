//
//  ContentView.swift
//  CaloriesPerKilometer
//
//  Created by Dalibor Andjelkovic on 10.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating = false
    @ObservedObject var store: Store
    var foreverAnimation: Animation {
        Animation
            .linear
            .repeatForever(autoreverses: false)
            .speed(0.8)
    }

    var body: some View {
        NavigationView {
            VStack {
                if !store.actvities.isEmpty {
                    Stats(activites: $store.actvities)
                } else {
                    if store.authSucceededButNotFinished {
                        Group {
                            Image(systemName: "arrow.2.circlepath")
                                .rotationEffect(.degrees(self.isAnimating ? 180.0 : 0.0))
                                .animation(foreverAnimation)
                                .onAppear{ self.isAnimating = true }
                                .onDisappear{ self.isAnimating = false }
                            Text("Receiving Activities")
                            .bold()
                        }
                        .font(.system(size: 40))
                        .foregroundColor(Color(red: 252 / 256, green: 82 / 256, blue: 0))
                        } else {
                            NavigationLink(destination: StravaAuth()) {
                                VStack {
                                    Group {
                                        Image(systemName: "lock.shield")
                                        Text("Connect Strava")
                                            .bold()
                                    }
                                    .foregroundColor(Color(red: 252 / 256, green: 82 / 256, blue: 0))
                                    .font(.system(size: 40))
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            store.authSucceededButNotFinished = true
            return ContentView(store: store)
        }
}
