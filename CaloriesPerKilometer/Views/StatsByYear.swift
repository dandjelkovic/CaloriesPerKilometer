//
//  StatsByYear.swift
//  CaloriesPerKilometer
//
//  Created by Dalibor Andjelkovic on 15.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

import SwiftUI

struct StatsByYear: View {
    @Binding var activites: [Activity]
    private var years: [String] {
        Array(activites.groupByYear().keys).sorted(by: >)
    }
    private var yearlyActivites: [String: [Activity]] {
        activites.groupByYear()
    }
    var body: some View {
        List {
            ForEach(years, id: \.self) { year in
                Section(header:
                    Text("\(year)").font(.title).bold()
                    +
                    Text(" \(self.yearlyActivites[year]!.count) activities")) {
                    Stats(activites: self.yearlyActivites[year]!)
                }
            }
        }
    }
}

struct StatsByYear_Previews: PreviewProvider {
    @State static var activites = Activity.mocked()

    static var previews: some View {
        StatsByYear(activites: $activites)
    }
}
