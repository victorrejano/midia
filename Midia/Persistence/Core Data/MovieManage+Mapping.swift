//
//  MovieManage+Mapping.swift
//  Midia
//
//  Created by Victor on 21/03/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

extension MovieManaged {
    
    func mappedObject() -> Movie {
        
        var url: URL?
        
        if let _ = imageURL, let unwrappedURL = URL(string: imageURL!) {
            url = unwrappedURL
        }
        
        return Movie(movieId: Int(movieId), title: title!, imageURL: url, artistName: artistName, releaseDate: releaseDate, price: price, synopsis: synopsis)
    }
    
}
