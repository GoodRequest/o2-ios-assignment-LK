//
//  InfoBoxView.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

struct InfoBoxView: View {
    
    let message: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "info.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.App.deepBlue)
            
            Text(message)
                .font(.caption)
                .foregroundColor(Color.App.deepBlue)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.App.deepBlue.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.App.deepBlue.opacity(0.2), lineWidth: 1)
        )
        
    }
}

#Preview {

    InfoBoxView(message: L10n.ifYouDontUseCouponImmediatelyItWillBeAddedToMyCoupons)
        .padding()

}

