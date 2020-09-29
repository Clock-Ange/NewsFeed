//
//  TestTaskTests.swift
//  TestTaskTests
//
//  Created by Геннадий Махмудов on 27.09.2020.
//

import XCTest
@testable import TestTask

class TestTaskTests: XCTestCase {

    
    func testLoadingData(completeion: @escaping (LoadedData) -> ()){
        
            DispatchQueue.global().async {
                guard let url = URL(string: "http://stage.apianon.ru:3000/fs-posts/v1/posts") else {
                    fatalError("Failed to load URL.")
                }
                
                guard let data = try? Data(contentsOf: url) else{
                    XCTFail()
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let downloadedData = try decoder.decode(LoadedData.self, from: data)
                    DispatchQueue.main.async {
                        XCTAssertNotNil(downloadedData)
                        completeion(downloadedData)
                    }
                }catch{
                    XCTFail(error.localizedDescription)
                }
            }
            
        }
        
        
     
    
}


