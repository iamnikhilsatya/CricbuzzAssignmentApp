//
//  MovieMoreDetailsView.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import SwiftUI

struct MovieMoreDetailsView: View {
    let movie: Movie
    let screenWidth: CGFloat = UIScreen.main.bounds.width * 0.30
    let screenHeight: CGFloat = UIScreen.main.bounds.height * 0.40
    @State private var currentRatingIndex: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ScrollView(.vertical) {
                HStack {
                    // Display movie poster
                    AsyncImage(url: URL(string: movie.poster ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: screenHeight)
                            .cornerRadius(16)
                    } placeholder: {
                        ProgressView()
                    }
                }
                Spacer()
                
                // Display movie details
                DetailSubView(name: "Title", description: movie.title)
                DetailSubView(name: "Plot", description: movie.plot ?? "")
                DetailSubView(name: "Cast & Crew", description: movie.actors ?? "")
                DetailSubView(name: "Released Date", description: movie.released ?? "")
                DetailSubView(name: "Genre", description: movie.genre ?? "")
                
                // Picker to select the current rating source
                Picker("Ratings", selection: $currentRatingIndex) {
                    Text("Imdb").tag(0)
                    Text("Rotten Tomatoes").tag(1)
                    Text("Metacritic").tag(2)
                }
                .pickerStyle(.segmented)
                
                // Display the movie's rating based on the selected source
                DetailSubView(name: "Rating", description: getMovieRating())
                
                // Display the rating view based on the source
                if movie.ratings?[safe: currentRatingIndex]?.source == "Internet Movie Database" {
                    RatingView(rating: 4.5, maxRating: 5)
                }
            }
        }
        .padding(.horizontal, 16)
        .navigationTitle("Movie Details")
    }
}

extension MovieMoreDetailsView {
    // Function to get the movie's rating based on the selected source
    func getMovieRating() -> String {
        if currentRatingIndex < movie.ratings?.count ?? 0 {
            if let currentRating = movie.ratings?[safe: currentRatingIndex] {
                return currentRating.value ?? "No rating Available"
            }
        }
        return "No rating Available"
    }
}

