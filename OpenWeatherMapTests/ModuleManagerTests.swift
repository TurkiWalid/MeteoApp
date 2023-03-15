//
//  ModuleManagerTest.swift
//  OpenWeatherMapTests
//
//  Created by Walid on 15/3/2023.
//

import XCTest
@testable import OpenWeatherMap

final class ModuleManagerTest: XCTestCase {
    
    var moduleManager: ModuleManager!

    override func tearDownWithError() throws {
        moduleManager = nil
    }
    
    func testModuleManager_DefaultConfigFile_shouldNotThrow(){
        //Arrange
        moduleManager = ModuleManagerImplementation(gateway: SucceedingMock())
        
        //Act
        //Assert
        XCTAssertNoThrow(
            try moduleManager.fetchWeather(for: FetchRequestRequestMocks.optimaRequest, completion: { respObj, errString in
            //Nothing to consider here for now
        })
            , "fetchWeather didn't throw ParametersNotSet while looking default for config file")
    }

    func testModuleManager_MissingConfigFile_shouldThrow_ParametersNotSet(){
        //Arrange
        moduleManager = ModuleManagerImplementation(gateway: SucceedingMock(), configName: "N/A")
        
        //Act
        //Assert
        XCTAssertThrowsError(
            try moduleManager.fetchWeather(for: FetchRequestRequestMocks.optimaRequest, completion: { respObj, errString in
            //Nothing to consider here for now
        })
            , "fetchWeather didn't throw ParametersNotSet when called with a missing config file") { error in
                
            XCTAssertEqual(error as? OpenWeatherMapServiceError, OpenWeatherMapServiceError.ParametersNotSet, "fetchWeather throwing an unknown error when called with a missing config file")}
    }
    

}
