//
//  OpenWeatherMapRequestModelTests.swift
//  OpenWeatherMapTests
//
//  Created by Walid on 15/3/2023.
//

import XCTest
@testable import OpenWeatherMap

final class OpenWeatherMapRequestModelTests: XCTestCase {
    
    var request: OpenWeatherMapRequestModel!

    override func tearDownWithError() throws {
        request = nil
    }

    func testRequest_validData_shouldReturnAValidUrl(){
        //Arrange
        request = FetchRequestRequestMocks.optimaRequest
        
        //Act
        let urlData = request.parametersEncoded
        let dummyUrl = "http://www.google.com?id=1" + urlData
        let url = URL(string: dummyUrl)
        
        //Assert
        XCTAssertNotNil(url, "Encoded Data from a Valid Request does not return a valid Url")
        XCTAssertTrue(UIApplication.shared.canOpenURL(url!), "Encoded Data from a Valid Request returned a malformed url")
    }
    
    func testRequest_minimalRequest_shouldReturnAValidUrl(){
        //Arrange
        request = FetchRequestRequestMocks.minimalRequest
        
        //Act
        let urlData = request.parametersEncoded
        let dummyUrl = "http://www.google.com?id=1" + urlData
        let url = URL(string: dummyUrl)
        
        //Assert
        XCTAssertNotNil(url, "Encoded Data from a Valid Request does not return a valid Url")
        XCTAssertTrue(UIApplication.shared.canOpenURL(url!), "Encoded Data from a Valid Request returned a malformed url")
    }
    

}
