//
//  ScratchCodeView.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

struct ScratchCodeView: View {
    
    private let code: String
    private let progress: Double
    
    private var blurRadius: Double {
        let maxBlur: Double = 10.0
        return maxBlur * (1.0 - progress)
    }
    
    private var isRevealed: Bool {
        progress >= 1
    }
    
    /// Initializes a scratch code view with the given code and progress.
    /// - Parameters:
    ///   - code: The code to display (will be blurred based on progress)
    ///   - progress: The reveal progress from 0 to 100, where 0 is fully hidden and 100 is fully revealed
    init(code: String, progress: Double) {
        self.code = code
        self.progress = progress
    } 
    
    var body: some View {
        ZStack {
            Text(code)
                .font(.title3.bold())
                .foregroundColor(Color.App.deepBlue)
                .blur(radius: blurRadius)
                .padding()
                .multilineTextAlignment(.center)
            
            ZStack {
                if !isRevealed {
                    VStack(spacing: 12) {
                        Image(systemName: "lock.fill")
                            .font(.title2)
                            .foregroundColor(Color.App.gray)
                        
                        Text(L10n.hidden)
                            .font(.callout)
                            .foregroundColor(Color.App.gray)
                    }
                }
            }
            .transition(.opacity)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(Color.App.lightGray)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(
                    style: StrokeStyle(lineWidth: 1, dash: [5])
                )
                .foregroundColor(Color.App.gray)
        )
    }
    
}

#Preview {

    VStack(spacing: 20) {
        ScratchCodeView(
            code: "ABC123",
            progress: 0
        )
        
        ScratchCodeView(
            code: "ABC123",
            progress: 50
        )
        
        ScratchCodeView(
            code: "ABC123",
            progress: 100
        )
    }
    .padding()
    
}

