//
//  ReusableButton.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import SwiftUI

struct CategoryTextView: View {
    var category: String
    @Binding var selectedCategory: String?
    let currentGradient: [Color] = [Color("backgroundColor"), Color("grey")]
    let selectedGradient: [Color] = [Color("majenta"), Color("backgroundColor")]
    
    var body: some View {
        Text(category)
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(LinearGradient(colors:  self.selectedCategory ==  category ? selectedGradient :currentGradient, startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(16)
            .onTapGesture {
                self.selectedCategory = category
            }
    }
}
