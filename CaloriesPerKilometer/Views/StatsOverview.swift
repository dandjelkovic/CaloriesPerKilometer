//
//  Stats.swift
//  CaloriesPerKilometer
//
//  Created by Dalibor Andjelkovic on 10.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

import SwiftUI

struct StatsOverview: View {
    @Binding var activites: [Activity]

    var body: some View {
        VStack {
            Spacer()
            Stats(activites: activites)
            Spacer()
        }
    }
}

struct Stats_Previews: PreviewProvider {
    @State static var activites = Activity.mocked()
    static var previews: some View {
        StatsOverview(activites: $activites)
    }
}
