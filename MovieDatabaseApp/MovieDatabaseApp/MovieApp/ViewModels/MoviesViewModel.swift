//
//  MoviesViewModel.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import Foundation

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = [] // All movies data
    @Published var searchResults: [Movie] = [] // Search results
    @Published var selectedFilter: Filter = .all // Selected filter for categories
    
    init() {
        // Load and initialize movies data from a JSON file
        movies = JSONLoader.load("MoviesData.json", as: [Movie].self)
    }
    
    // Generate a list of years from date ranges
    func generateYears(from dateRanges: [String]) -> [String] {
        var result: [String] = []
        
        for dateRange in dateRanges {
            if dateRange.contains("–") {
                let rangeComponents = dateRange.components(separatedBy: "–")
                if let startYear = Int(rangeComponents[safe: 0] ?? ""), let endYear = Int(rangeComponents[safe: 1] ?? "") {
                    result.append(String(startYear))
                    result.append(String(endYear))
                }
                else {
                    result.append(String(Int(rangeComponents[safe: 0] ?? "") ?? 0))
                }
            } else if let singleYear = Int(dateRange) {
                result.append(String(singleYear))
            }
        }
        
        return result
    }
    
    // Get a list of subcategories based on the selected category
    func getSublist(category: String) -> [String] {
        let values: [String]
        
        switch category {
        case "Year":
            values = generateYears(from: movies.compactMap({$0.year}))
        case "Genre":
            values = movies.compactMap { $0.genre?.components(separatedBy: ", ") }.flatMap { $0 }
        case "Directors":
            values = movies.compactMap { $0.director?.components(separatedBy: ", ") }.flatMap { $0 }
        case "Actors":
            values = movies.compactMap { $0.actors?.components(separatedBy: ", ") }.flatMap { $0 }
        default:
            values = []
        }
        
        return Array(Set(values)).sorted() // Remove duplicates and sort
    }
    
    // Get filtered movies based on the selected category and filter
    func getMovies(category: String, filter: String?) -> [Movie] {
        let filteredMovies: [Movie]
        
        switch category {
        case "Year":
            if let filter = filter {
                filteredMovies = movies.filter { $0.year?.contains(filter) ?? false }
            } else {
                filteredMovies = movies
            }
        case "Genre":
            if let filter = filter {
                filteredMovies = movies.filter { $0.genre?.contains(filter) ?? false}
            } else {
                filteredMovies = movies
            }
        case "Directors":
            if let filter = filter {
                filteredMovies = movies.filter { $0.director?.contains(filter) ?? false }
            } else {
                filteredMovies = movies
            }
        case "Actors":
            if let filter = filter {
                filteredMovies = movies.filter { $0.actors?.contains(filter) ?? false }
            } else {
                filteredMovies = movies
            }
        case "All Movies":
            filteredMovies = movies
        default:
            filteredMovies = movies
        }
        
        return filteredMovies
    }
    
    // Clear search results
    func clearSearchResults() {
        searchResults = [] // Clear search results
    }
    
    // Perform a search based on the provided query
    func performSearch(query: String) {
        if query.isEmpty {
            // If the search query is empty, reset the movies list to its original state
            searchResults = movies
        } else {
            // Filter movies based on the search query (search by title, genre, actor, director)
            searchResults = movies.filter { movie in
                return movie.title.lowercased().contains(query.lowercased()) ||
                movie.genre?.lowercased().contains(query.lowercased()) ?? false ||
                movie.actors?.contains { $0.lowercased().contains(query.lowercased()) } ?? false ||
                movie.director?.contains { $0.lowercased().contains(query.lowercased()) } ?? false
            }
        }
    }
    
    // Filter movies based on the selected filter
    var filteredMovies: [Movie] {
        switch selectedFilter {
        case .year(let year):
            return movies.filter { $0.year == year }
        case .genre(let genre):
            return movies.filter { $0.genre?.contains(genre) ?? false}
        case .director(let director):
            return movies.filter { $0.director?.contains(director) ?? false}
        case .actor(let actor):
            return movies.filter { $0.actors?.contains(actor) ?? false}
        case .all:
            return movies
        }
    }
    
    enum Filter {
        case year(String)
        case genre(String)
        case director(String)
        case actor(String)
        case all
    }
}
