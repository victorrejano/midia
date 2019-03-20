//
//  Movie.swift
//  Midia
//
//  Created by Victor on 20/03/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

struct Movie {
    // MARK: Properties
    let movieId: String
    let title: String
    let imageURL: URL?
    
    let artistName: String?
    let releaseDate: Date?
    let price: Float?
    let synopsis: String?
    
    // MARK: Initialization
    init(movieId: String,
         title: String,
         imageURL: URL? = nil,
         artistName: String? = nil,
         releaseDate: Date? = nil,
         price: Float? = nil,
         synopsis: String? = nil) {
        
        self.movieId = movieId
        self.title = title
        self.imageURL = imageURL
        self.artistName = artistName
        self.releaseDate = releaseDate
        self.price = price
        self.synopsis = synopsis
    }
}

// MARK: Providable protocols
extension Movie: MediaItemProvidable {
    var mediaItemId: String {
        return movieId
    }
}

extension Movie: MediaItemDetailedProvidable {
    
    var creatorName: String? {
        return artistName
    }
    
    var rating: Float? {
        return nil
    }
    
    var numberOfReviews: Int? {
        return nil
    }
    
    var creationDate: Date? {
        return releaseDate
    }
    
    var description: String? {
        return synopsis
    }
}

// MARK: Codable implementation
extension Movie: Codable {
    
    enum CodingKeys: String, CodingKey {
        case movieId = "trackId"
        case title = "trackName"
        case imageURL = "artworkUrl100"
        case artistName
        case releaseDate
        case price = "trackPrice"
        case synopsis = "longDescription"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(movieId, forKey: .movieId)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(imageURL, forKey: .imageURL)
        
        try container.encodeIfPresent(artistName, forKey: .artistName)
        
        if let date = releaseDate {
            try container.encode(DateFormatter.movieAPIDateFormatter.string(from: date), forKey: .releaseDate)
        }
        
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(synopsis, forKey: .synopsis)
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(Int.self, forKey: .movieId)
        movieId = "\(id)"
        title = try container.decode(String.self, forKey: .title)
        imageURL = try container.decodeIfPresent(URL.self, forKey: .imageURL)
        
        artistName = try container.decodeIfPresent(String.self, forKey: .artistName)
        
        if let date = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            releaseDate = DateFormatter.movieAPIDateFormatter.date(from: date)
        } else {
            releaseDate = nil
        }
        
        price = try container.decodeIfPresent(Float.self, forKey: .price)
        synopsis = try container.decodeIfPresent(String.self, forKey: .synopsis)
    }
}
