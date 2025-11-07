//
//  PrimaryButtonStyle.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    var isLoading: Bool = false
    
    @Environment(\.isEnabled) private var isEnabled
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        let isDisabledFromOutside = !isEnabled
        
        HStack(spacing: 8) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.App.white))
                    .scaleEffect(0.8)
            } else {
                configuration.label
            }
        }
        .font(.headline)
        .foregroundColor(Color.App.white)
        .frame(maxWidth: .infinity)
        .padding()
        .background(backgroundColor(isDisabledFromOutside: isDisabledFromOutside))
        .cornerRadius(12)
        .shadow(color: shadowColor(isDisabledFromOutside: isDisabledFromOutside), radius: 8, x: 0, y: 4)
        .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isLoading)
        .animation(.easeInOut(duration: 0.2), value: isDisabledFromOutside)
        .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
        .disabled(isLoading || isDisabledFromOutside)
    }
    
    private func backgroundColor(isDisabledFromOutside: Bool) -> Color {
        if isDisabledFromOutside {
            return Color.gray
        }

        return Color.App.deeperBlue
    }
    
    private func shadowColor(isDisabledFromOutside: Bool) -> Color {
        if isDisabledFromOutside {
            return Color.black.opacity(0.1)
        }
        
        return Color.black.opacity(0.2)
    }

}

extension ButtonStyle where Self == PrimaryButtonStyle {

    static var primary: PrimaryButtonStyle {
        PrimaryButtonStyle()
    }
    
    static func primary(isLoading: Bool = false) -> PrimaryButtonStyle {
        PrimaryButtonStyle(isLoading: isLoading)
    }

}

#Preview {

    VStack(spacing: 30) {
        VStack(alignment: .leading, spacing: 8) {
            Text("Normal")
                .font(.caption)
                .foregroundColor(.secondary)
            Button(action: {}) {
                Text("Primary Button")
            }
            .buttonStyle(.primary)
        }
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Loading")
                .font(.caption)
                .foregroundColor(.secondary)
            Button(action: {}) {
                Text("Loading Button")
            }
            .buttonStyle(.primary(isLoading: true))
        }
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Disabled")
                .font(.caption)
                .foregroundColor(.secondary)
            Button(action: {}) {
                Text("Disabled Button")
            }
            .buttonStyle(.primary)
            .disabled(true)
        }
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Loading + Disabled")
                .font(.caption)
                .foregroundColor(.secondary)
            Button(action: {}) {
                Text("Loading Disabled")
            }
            .buttonStyle(.primary(isLoading: true))
            .disabled(true)
        }
    }
    .padding()

}

