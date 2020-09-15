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
    var startDateLocal: Date

    private enum CodingKeys: String, CodingKey {
        case id
        case kilojoules
        case distance
        case totalElevationGain = "total_elevation_gain"
        case startDateLocal = "start_date_local"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        kilojoules = try container.decodeIfPresent(Float.self, forKey: .kilojoules) ?? 0.0
        distance = try container.decode(Float.self, forKey: .distance)
        totalElevationGain = try container.decodeIfPresent(Float.self, forKey: .totalElevationGain) ?? 0.0
        let startDateString = try container.decode(String.self, forKey: .startDateLocal)
        startDateLocal = ISO8601DateFormatter().date(from: startDateString) ?? Date(timeIntervalSinceReferenceDate: 0)

    }

    static func mocked() -> [Activity] {
        let bundle = Bundle.main
        var fileURL: URL = bundle.url(forResource: "activities", withExtension: "json")!
        if let privateActivitiesURL = bundle.url(forResource: "strava_activites", withExtension: "json") {
            print("Use private activites JSON")
            fileURL = privateActivitiesURL
        }
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

    func groupByYear() -> [String: [Activity]] {
        return Dictionary(grouping: self) {
            let date = $0.startDateLocal
            let dateComponents = Calendar.current.dateComponents([.year], from: date)
            return "\(dateComponents.year ?? 1970)"
        }
    }
}
