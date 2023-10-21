//
//  CardView.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import SwiftUI

struct CardView: View {
    var item: String

    init(item: String) {
        self.item = item
    }
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .padding(10)
                .cornerRadius(16)
        }
    }
}
