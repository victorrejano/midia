//
//  MovieCollection.swift
//  Midia
//
//  Created by Victor on 20/03/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

struct MovieCollection {
    let resultCount: Int
    let results: [Movie]?
}

extension MovieCollection: Decodable {}
