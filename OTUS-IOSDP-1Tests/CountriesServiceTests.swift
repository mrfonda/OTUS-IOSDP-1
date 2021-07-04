//
//  CountriesServiceTests.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import XCTest
@testable import OTUS_IOSDP_1

class CountriesServiceTests: XCTestCase {

    
    var countriesService: CountriesService!
    
    override func setUp() {
        super.setUp()
        countriesService = CountriesService()
    }
    
    override func tearDown() {
        countriesService = nil
        super.tearDown()
    }

    func testUS() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let hasUS = countriesService.countries.contains { country in
            country.id == "US"
        }
        
        countriesService.countries.forEach{print($0)}
        
        XCTAssertEqual(hasUS, true, "oops")
        
    }

}
