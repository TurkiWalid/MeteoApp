//
//  NetWorkServiceTest.swift
//  OpenWeatherMapTests
//
//  Created by Walid on 15/3/2023.
//

import XCTest
@testable import OpenWeatherMap

final class NetWorkServiceTests: XCTestCase {
    
    var networkService: NetworkService!

    override func tearDownWithError() throws {
        networkService = nil
    }

    func testNetwrorkService_OptimalCase_shouldReturnResultSucceedWithValidResponse(){
        //Arrange
        networkService = NetworkServiceImplementation(gateway: SucceedingMock())
        
        //Act
        networkService.fetchWeather(from: "") { result in
            //Assert
            switch result {
            case .success(let respObj):
                XCTAssertNotNil(respObj, "SucceedingData case returning empty response but should return \"OpenWeatherMapMinimalResponseModel!\"")
                XCTAssert(type(of: respObj) == Swift.Optional<OpenWeatherMap.OpenWeatherMapMinimalResponseModel>.self, "SucceedingData case returning success but object is not \"OpenWeatherMapMinimalResponseModel\"")
                break
            case .failure(_):
                XCTFail("SucceedingData case failed on Networkservice fetchWeather")
                break
            }
            
        }
    }
    
    func testNetwrorkService_WrongData_shouldReturnResultFailureWithParsingError(){
        //Arrange
        networkService = NetworkServiceImplementation(gateway: WrongDataMock())
        
        //Act
        networkService.fetchWeather(from: "") { result in
            //Assert
            switch result {
            case .success(_):
                XCTFail("WrongData case should return failure with FetchError.ParsingError")
                break
            case .failure(let fetchError):
                XCTAssertEqual(fetchError, .ParsingError, "WrongData case failed as intended by with wrong error")
                break
            }
            
        }
    }
    
    func testNetwrorkService_APIError_shouldReturnResultFailureWithAPIError(){
        //Arrange
        networkService = NetworkServiceImplementation(gateway: ApiErrorMock())
        
        //Act
        networkService.fetchWeather(from: "") { result in
            //Assert
            switch result {
            case .success(_):
                XCTFail("APIError case should return failure with FetchError.APIError")
                break
            case .failure(let fetchError):
                XCTAssertEqual(fetchError, .APIError, "WrongData failed as intended by with wrong error")
                break
            }
            
        }
    }

}
