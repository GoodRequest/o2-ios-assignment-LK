//
//  CardBrandView.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

struct CardBrandView: View {
    
    let brandText: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 120, height: 120)
                .overlay(
                    Text(brandText)
                        .font(.title.weight(.heavy))
                        .foregroundColor(.black)
                )
        }
        .frame(height: 250)
        .frame(maxWidth: .infinity)
        .background(Color.App.deepBlue)
    }
    
}

#Preview {

    CardBrandView(brandText: "O2")
    
}

