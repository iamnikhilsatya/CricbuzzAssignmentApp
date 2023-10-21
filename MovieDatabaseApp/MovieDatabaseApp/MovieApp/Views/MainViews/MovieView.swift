//
//  MovieView.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import SwiftUI

struct MovieView: View {
    @StateObject var viewModel = MoviesViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            MoviesListView(viewModel: viewModel)
        }
        .navigationBarTitle("Movie List")
    }
}
