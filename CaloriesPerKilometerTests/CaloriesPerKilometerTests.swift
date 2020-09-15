//
//  CaloriesPerKilometerTests.swift
//  CaloriesPerKilometerTests
//
//  Created by Dalibor Andjelkovic on 10.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

import XCTest
@testable import Calories_Per

class CaloriesPerKilometerTests: XCTestCase {
    let activitesJSON = {
        try! Data(contentsOf: Bundle.main.url(forResource: "activities", withExtension: "json")!)
    }

    func testCalucaltionOfCaloiresPerKilometer() {
        // given
        let activities = try! JSONDecoder().decode([Activity].self, from: activitesJSON())

        // when
        let result = activities.calculate(resultType: .caloriesPerKilometer)

        // then
        XCTAssertEqual(result, "6.675")
    }

    func testCalucaltionOfCaloiresPerElevatedMeters() {
        // given
        let activities = try! JSONDecoder().decode([Activity].self, from: activitesJSON())

        // when
        let result = activities.calculate(resultType: .caloriesPerGainedElevatedMeter)

        // then
        XCTAssertEqual(result, "1.350")
    }

    func testGroupByYear() {
        // given
        let activities = try! JSONDecoder().decode([Activity].self, from: activitesJSON())

        // when
        let groupedActivities = activities.groupByYear()

        // then
        XCTAssertEqual(groupedActivities.count, 4)
    }

}
