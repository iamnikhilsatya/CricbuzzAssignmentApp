//
//  DetailSubView.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import SwiftUI

struct DetailSubView : View {
    let name: String
    let description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    var body: some View {
        HStack(alignment: .top ,spacing: 4) {
            Text("\(name): ")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .lineLimit(0)
            Text(description)
                .font(.title3)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}
