//
//  DiscoverViewModel.swift
//  boostmi
//
//  Created by Mark Aboujaoude on 2020-01-21.
//  Copyright © 2020 Mark Aboujaoude. All rights reserved.
//

import Foundation

class DiscoverViewModel {

    var movies = [Movie]()

    init() {
        getNowPlayingMovies()
        print(movies)
    }

    private func getNowPlayingMovies() {
        MovieServiceAPI.shared.fetchMovies(from: .nowPlaying) { (result: Result<MoviesResponse, MovieServiceAPI.APIServiceError>) in
            switch result {
            case .success(let movieResponse):
                self.movies = movieResponse.results
                NotificationCenter.default.post(name: .didUpdateContent, object: self)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func movieItem(at indexPath: IndexPath) -> Movie? {
        return movies[indexPath.row]
    }
    
}
