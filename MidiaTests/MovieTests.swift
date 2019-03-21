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
    var encoder: JSONEncoder!
    
    override func setUp() {
        movie = Movie(movieId: 1232, title: "V for Vendetta")
        decoder = JSONDecoder()
        encoder = JSONEncoder()
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
    
    func testEncodeMovie() {
        do {
            let fullMovie = Movie(movieId: 123124312, title: "A random title", imageURL: URL(string: "https://www.google.com/"), artistName: "An artist, another artist", releaseDate: Date(), price: 9.95, synopsis: "A synopsis")
            
            let encodedMovie = try encoder.encode(fullMovie)
            XCTAssertNotNil(encodedMovie)
        
        } catch {
            assertionFailure("Encode movie fails")
        }
    }
    
    func testDecodeEncodedMovie() {
        do {
            let fullMovie = Movie(movieId: 123124312, title: "A random title", imageURL: URL(string: "https://www.google.com/"), artistName: "An artist, another artist", releaseDate: Date(), price: 9.95, synopsis: "A synopsis")
            
            let encodedMovie = try encoder.encode(fullMovie)
            XCTAssertNotNil(encodedMovie)
            
            let decodedMovie = try decoder.decode(Movie.self, from: encodedMovie)
            XCTAssertNotNil(decodedMovie)
            
            XCTAssertNotNil(decodedMovie.movieId)
            XCTAssertNotNil(decodedMovie.title)
            XCTAssertNotNil(decodedMovie.imageURL)
            
            XCTAssertNotNil(decodedMovie.artistName)
            XCTAssertNotNil(decodedMovie.releaseDate)
            XCTAssertNotNil(decodedMovie.price)
            XCTAssertNotNil(decodedMovie.synopsis)
            
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
