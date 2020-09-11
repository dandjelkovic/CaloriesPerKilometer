//
//  Store.swift
//  CaloriesPerKilometer
//
//  Created by Dalibor Andjelkovic on 11.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

import Foundation

class Store: ObservableObject {
    @Published var actvities = [Activity]()
    @Published var authSucceededButNotFinished = false
}

var store = Store()
