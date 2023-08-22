//
//  NetworkingController.swift
//  Assessment5IOS5
//
//  Created by Colton Brenneman on 6/25/23.
//

import UIKit.UIImage

struct NetworkingController {
    
    func fetchAritst(with searchTerm: String, completion: @escaping(Result<TopLevelAlbumDictionary, ResultError>) -> Void) {
        guard let baseURL = URL(string: "https://itunes.apple.com/search") else { completion(.failure(.invalidURL)) ; return }
        
        var urlRequest = URLRequest(url: baseURL)
//        urlRequest.url?.append(path: searchTerm)
        let entityQueryItem = URLQueryItem(name: "entity", value: "album")
        let artistQueryItem = URLQueryItem(name: "term", value: searchTerm)
        urlRequest.url?.append(queryItems: [entityQueryItem, artistQueryItem])
        print(urlRequest.url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completion(.failure(.thrownError(error)))
            } // End of error
            if response == nil {
                completion(.failure(.noResponse))
            } // End of response
            guard let data else { completion(.failure(.noData)) ; return }
            do {
                let tld = try JSONDecoder().decode(TopLevelAlbumDictionary.self, from: data)
                completion(.success(tld))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    } // End of fetchArtist
    
    func fetchSong(with songID: Int, completion: @escaping(Result<TopLevelSongDictionary, ResultError>) -> Void) {
        // https://itunes.apple.com/lookup?entity=song&id=1373516908
        guard let baseURL = URL(string: "https://itunes.apple.com/lookup") else { completion(.failure(.invalidURL)) ; return }
        
        var urlRequest = URLRequest(url: baseURL)
        let entiryQueryItem = URLQueryItem(name: "entiry", value: "song")
        let songQueryItem = URLQueryItem(name: "id", value: "\(songID)")
        urlRequest.url?.append(queryItems: [entiryQueryItem, songQueryItem])
        print(urlRequest.url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error {
                completion(.failure(.thrownError(error))) ; return
            } // End of error
            guard let data else { completion(.failure(.noData)) ; return }
            do {
                let songTLD = try JSONDecoder().decode(TopLevelSongDictionary.self, from: data)
                completion(.success(songTLD))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    } // End of fetchSong
    
    func fetchImage(with imageURL: String, completion: @escaping(Result<UIImage, ResultError>) -> Void) {
        guard let url = URL(string: imageURL) else { completion(.failure(.invalidURL)) ; return }
        
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(.thrownError(error))) ; return
            } // End of error
           
            guard let imageData = data else { completion(.failure(.noData)) ; return }
            
            guard let movieImage = UIImage(data: imageData) else { return }
            completion(.success(movieImage))
        }.resume() // End of dataTask
    } // End of fetchImage
    
} // End of struct
