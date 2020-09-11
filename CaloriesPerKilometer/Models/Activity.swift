//
//  Activity.swift
//  CaloriesPerKilometer
//
//  Created by Dalibor Andjelkovic on 10.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

import Foundation

struct Activity: Decodable, Hashable {
    var id: Int
    var kilojoules: Float
    var distance: Float
    var totalElevationGain: Float

    private enum CodingKeys: String, CodingKey {
        case id
        case kilojoules
        case distance
        case totalElevationGain = "total_elevation_gain"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        kilojoules = try container.decodeIfPresent(Float.self, forKey: .kilojoules) ?? 0.0
        distance = try container.decode(Float.self, forKey: .distance)
        totalElevationGain = try container.decodeIfPresent(Float.self, forKey: .totalElevationGain) ?? 0.0
    }

    static func mocked() -> [Activity] {
        let fileURL = Bundle.main.url(forResource: "strava_activites", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)

        let result = try! JSONDecoder().decode([Activity].self, from: data)
        return result
    }
}

enum CalculationResult {
    case caloriesPerKilometer
    case caloriesPerGainedElevatedMeter
}

extension Array where Element == Activity {
    func calculate(resultType: CalculationResult) -> String {
        switch resultType {
        case .caloriesPerKilometer:
            guard !self.isEmpty else { return "..." }
            let sumKilometers = self.reduce(0) {
                $0 + $1.distance
            } / 1000
            let sumKilojoules = self.reduce(0) {
                $0 + $1.kilojoules
            }
            let sumCalories = sumKilojoules / 4.184
            let average = sumCalories / sumKilometers

            return String(format: "%.3f", average)

        case .caloriesPerGainedElevatedMeter:
            guard !self.isEmpty else { return "..." }
            let sumElevatedMeters = self.reduce(0) {
                $0 + $1.totalElevationGain
            }
            let sumKilojoules = self.reduce(0) {
                $0 + $1.kilojoules
            }
            let sumCalories = sumKilojoules / 4.184
            let average = sumCalories / sumElevatedMeters

            return String(format: "%.3f", average)
        }
    }
}
