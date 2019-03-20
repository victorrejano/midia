//
//  MovieTests.swift
//  MidiaTests
//
//  Created by Victor on 20/03/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import XCTest
@testable import Midia

class MovieTests: XCTestCase {
    var movie: Movie!
    var decoder: JSONDecoder!
    
    override func setUp() {
        movie = Movie(movieId: "1232", title: "V for Vendetta")
        decoder = JSONDecoder()
    }
    
    override func tearDown() {
    }
    
    func testMovieExistence() {
        XCTAssertNotNil(movie)
    }
    
    func testDecodeMovieCollection() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "movie-search-response", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let movieCollection = try decoder.decode(MovieCollection.self, from: data)
            XCTAssertNotNil(movieCollection)
            let firstMovie = movieCollection.results?.first!
            XCTAssertNotNil(firstMovie?.movieId)
            XCTAssertNotNil(firstMovie?.title)
        } catch {
            XCTFail()
        }
    }
    
}
