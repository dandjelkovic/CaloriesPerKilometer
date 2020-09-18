//
//  AllTimeStats.swift
//  CaloriesPerKilometer
//
//  Created by Dalibor Andjelkovic on 15.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

import SwiftUI


struct Stats: View {
    var activites:  [Activity]
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("\(activites.calculate(resultType: .caloriesPerKilometer))")
                    .bold()
                    .font(Font.system(size: 40.0))
                Text("Calories/ Kilometer")
                    .font(.system(size: 14))
                Spacer().frame(height: 20)
                Text("\(activites.calculate(resultType: .caloriesPerGainedElevatedMeter))")
                    .bold()
                    .font(Font.system(size: 40.0))
                Text("Calories/ Gained Elevated Meter")
                    .font(.system(size: 14))
                Spacer().frame(height: 20)
            }
            Spacer()
        }
    }
}

struct AllTimeStats_Previews: PreviewProvider {
    @State static var activites = Activity.mocked()
    
    static var previews: some View {
        Stats(activites: activites)
    }
}
