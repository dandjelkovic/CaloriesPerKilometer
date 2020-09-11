//
//  CaloriesPerKilometerTests.swift
//  CaloriesPerKilometerTests
//
//  Created by Dalibor Andjelkovic on 10.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

import XCTest
@testable import CaloriesPerKilometer

class CaloriesPerKilometerTests: XCTestCase {
    let activitesJSON =
    """
    [
        {
            "id": 1,
            "distance": 5000,
            "kilojoules": 250,
            "total_elevation_gain": 50,
        },
        {
            "id": 2,
            "distance": 10000,
            "kilojoules": 500,
            "total_elevation_gain": 100,
        },
        {
            "id": 3,
            "distance": 20000,
            "kilojoules": 1000,
            "total_elevation_gain": 200,
        },
    ]
    """

    func testCalucaltionOfCaloiresPerKilometer() {
        let data = activitesJSON.data(using: .utf8)!
        let activities = try! JSONDecoder().decode([Activity].self, from: data)

        // when
        let result = activities.calculate(resultType: .caloriesPerKilometer)

        // then
        XCTAssertEqual(result, "11.950")
    }

    func testCalucaltionOfCaloiresPerElevatedMeters() {
        let data = activitesJSON.data(using: .utf8)!
        let activities = try! JSONDecoder().decode([Activity].self, from: data)

        // when
        let result = activities.calculate(resultType: .caloriesPerGainedElevatedMeter)

        // then
        XCTAssertEqual(result, "1.195")
    }

}
