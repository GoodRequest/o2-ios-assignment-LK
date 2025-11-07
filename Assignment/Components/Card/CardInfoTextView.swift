//
//  CardInfoTextView.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

struct CardInfoTextView: View {
    
    let scratchText: String
    let winsText: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(scratchText)
                .font(.headline)
                .foregroundColor(Color.App.deepBlue)
            
            Text(winsText)
                .font(.caption)
                .foregroundColor(Color.App.deepBlue)
        }
        .multilineTextAlignment(.center)
    }
    
}

#Preview {
    
    CardInfoTextView(
        scratchText: L10n.scratchToRevealTheWinningCode,
        winsText: L10n.everyoneWinsSomething
    )

}

