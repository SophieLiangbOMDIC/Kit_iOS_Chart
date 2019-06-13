//
//  GMChartsTests.swift
//  GMChartsTests
//
//  Created by Sophie Liang on 2019/6/13.
//  Copyright © 2019 Sophie Liang. All rights reserved.
//

import XCTest
import GMCharts

class GMChartsTests: XCTestCase {
    
    var chart: GMCharts!

    override func setUp() {
        super.setUp()
        chart = GMCharts(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetSeparatorArray() {
        let testArray = [1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9, 10.2, 11.1, 12.2, 13.3, 14.4, 15.5, 16.6, 17.7, 18.8, 19.9, 20.3]
        for (index, test) in testArray.enumerated() {
            switch index {
            case 0, 1, 2, 3, 4:
                XCTAssertEqual(chart.getSeparatorArray(distance: test).count, index)
            case 5:
                XCTAssertEqual(chart.getSeparatorArray(distance: test).count, 2)
            case 6, 7, 10, 11, 15:
                XCTAssertEqual(chart.getSeparatorArray(distance: test).count, 3)
            default:
                let count = chart.getSeparatorArray(distance: test).count
                print(test, count)
                XCTAssertEqual(count, 4)
            }
        }
    }

}
