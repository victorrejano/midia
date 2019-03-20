//
//  GoogleBooksAPIConsumerAlamofire.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/4/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation
import Alamofire

class GoogleBooksAPIConsumerAlamofire: MediaItemAPIConsumable {

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {

        Alamofire.request(GoogleBooksAPIConstants.getAbsoluteURL(withQueryParams: ["2019"])).responseData { (response) in

            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: value)
                    success(bookCollection.items ?? [])
                } catch {
                    failure(error) // Error parseando, lo enviamos para arriba
                }
            }
        }

    }

    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        let paramsList = queryParams.components(separatedBy: " ")

        Alamofire.request(GoogleBooksAPIConstants.getAbsoluteURL(withQueryParams: paramsList)).responseData { (response) in

            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: value)
                    success(bookCollection.items ?? [])
                } catch {
                    failure(error) // Error parseando, lo enviamos para arriba
                }
            }
        }

    }

    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {

        Alamofire.request(GoogleBooksAPIConstants.urlForBook(withId: mediaItemId)).responseData { (response) in

            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let book = try decoder.decode(Book.self, from: value)
                    success(book)
                } catch {
                    failure(error) // Error parseando, lo enviamos para arriba
                }
            }
        }
    }

}
