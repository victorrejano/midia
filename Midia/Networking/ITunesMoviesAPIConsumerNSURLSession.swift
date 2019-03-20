//
//  ITunesMoviesAPIConsumerNSURLSession.swift
//  Midia
//
//  Created by Victor on 20/03/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

final class ITunesMoviesAPIConsumerNSURLSession {
    let session = URLSession.shared
}

extension ITunesMoviesAPIConsumerNSURLSession: MediaItemAPIConsumable {
    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        let url = ITunesMoviesAPIConstants.urlForMovies(withQueryParams: ["2018"])
        print("Making request to \(url)")
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                    DispatchQueue.main.async { success(movieCollection.results ?? []) }
                } catch {
                    DispatchQueue.main.async { failure(error) }
                }
            } else {
                DispatchQueue.main.async { failure(error) }
            }
        }
        task.resume()
    }
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        let url = ITunesMoviesAPIConstants.urlForMovies(withQueryParams: queryParams.components(separatedBy: " "))
        print("Making request to \(url)")
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                    DispatchQueue.main.async { success(movieCollection.results ?? []) }
                } catch {
                    DispatchQueue.main.async { failure(error) }
                }
            } else {
                DispatchQueue.main.async { failure(error) }
            }
        }
        task.resume()
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        
        let url = ITunesMoviesAPIConstants.urlForMovie(withId: mediaItemId)
        print("Making request to \(url)")
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                    DispatchQueue.main.async { success(movieCollection.results!.first!) }
                } catch {
                    DispatchQueue.main.async { failure(error) }
                }
            } else {
                DispatchQueue.main.async { failure(error) }
            }
        }
        task.resume()
    }
    
    
}
