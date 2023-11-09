//
//  MovieListTests.swift
//  MovieListTests
//
//  Created by Masud Onikeku on 07/11/2023.
//

import XCTest
@testable import MovieList

final class MovieListTests: XCTestCase {
    
    var viewModel: ViewModel!

    override func setUpWithError() throws {
        
        viewModel = ViewModel()
    }

    override func tearDownWithError() throws {
        
        viewModel = nil
    }

    
    func testKeyApi() {
        
        let expectation = XCTestExpectation(description: "Test request to retrieve key")
        
        var firstCheck = true
        
        viewModel.keyResponse.bind(completion: {response in
            
            //Check to see if the observer property is initialized
            
            if !firstCheck {
                if let response = response {
                    expectation.fulfill()
                    XCTAssertTrue(response.object is String)
                }else {
                    XCTFail("Response should not be null")
                }
                
            }else {
                firstCheck = false
            }
            
        })
        
        viewModel.getKey()
        
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testMovieApi() {
        
        let expectation = XCTestExpectation(description: "Test request to retrieve key")
        
        var firstCheck = true
        
        viewModel.poModelResponse.bind(completion: {response in
            
            //Check to see if the observer property is initialized
            
            if !firstCheck {
                if let response = response {
                    expectation.fulfill()
                    XCTAssertTrue(response.object is [Movie])
                }else {
                    XCTFail("Response should not be null")
                }
                
            }else {
                firstCheck = false
            }
            
        })
        
        viewModel.getPopular()
        
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testCastApi() {
        
        let expectation = XCTestExpectation(description: "Test request to retrieve key")
        
        var firstCheck = true
        
        viewModel.castResponse.bind(completion: {response in
            
            //Check to see if the observer property is initialized
            
            if !firstCheck {
                if let response = response {
                    expectation.fulfill()
                    XCTAssertTrue(response.object is [Cast])
                }else {
                    XCTFail("Response should not be null")
                }
                
            }else {
                firstCheck = false
            }
            
        })
        
        //Using a practical cast id example gotten from the api or else it fails
        viewModel.getCast(id: "820525")
        
        wait(for: [expectation], timeout: 20.0)
    }

}

