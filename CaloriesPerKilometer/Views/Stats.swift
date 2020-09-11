//
//  Stats.swift
//  CaloriesPerKilometer
//
//  Created by Dalibor Andjelkovic on 10.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

import SwiftUI

struct Stats: View {
    @Binding var activites: [Activity]

    var body: some View {
        VStack {
            Text("\(activites.count) Activities")
            Spacer()
            Text("\(activites.calculate(resultType: .caloriesPerKilometer))")
                .bold()
                .font(Font.system(size: 40.0))
            Text("Calories/ Kilometer")
            Divider()
            Text("\(activites.calculate(resultType: .caloriesPerGainedElevatedMeter))")
                .bold()
                .font(Font.system(size: 40.0))
            Text("Calories/ Gained Elevated Meter")
            Spacer()
        }
    }
}

struct Stats_Previews: PreviewProvider {
    @State static var activites = Activity.mocked()
    static var previews: some View {
        Stats(activites: $activites)
    }
}
