//
//  ITunesMoviesAPIConsumerAlamofire.swift
//  Midia
//
//  Created by Victor on 20/03/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation
import Alamofire

final class ITunesMoviesAPIConsumerAlamofire: MediaItemAPIConsumable {
    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        let url = ITunesMoviesAPIConstants.urlForMovies(withQueryParams: ["2018"])
        print("Making request to \(url)")
        
        Alamofire.request(url).responseData { (data) in
            
            switch data.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                    success(movieCollection.results ?? [])
                } catch {
                    failure(error)
                }
                
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        let url = ITunesMoviesAPIConstants.urlForMovies(withQueryParams: queryParams.components(separatedBy: " "))
        print("Making request to \(url)")
        
        Alamofire.request(url).responseData { (data) in
            
            switch data.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                    success(movieCollection.results ?? [])
                } catch {
                    failure(error)
                }
                
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        
        let url = ITunesMoviesAPIConstants.urlForMovie(withId: mediaItemId)
        print("Making request to \(url)")
        
        Alamofire.request(url).responseData { (data) in
            
            switch data.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                    success(movieCollection.results!.first!)
                } catch {
                    failure(error)
                }
                
            case .failure(let error):
                failure(error)
            }
        }
    }
}
