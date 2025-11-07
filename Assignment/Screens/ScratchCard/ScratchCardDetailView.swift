//
//  ScratchCardDetailView.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

extension ScratchCardDetailView {
    
    struct State: Equatable {
        let card: Card
        let scratchProgress: Double
        
        var isLoading: Bool {
            scratchProgress > 0 && scratchProgress < 1
        }
    }
    
    enum Action {
        case scratchCard
    }
    
}

struct ScratchCardDetailView: View {
    
    let state: State
    let onAction: CallbackClosure<Action>
    
    var body: some View {
        ScrollView {
            CardView(
                model: .init(
                    card: state.card,
                    title: L10n.clickToRevealHiddenCode
                )
            ) {
                ScratchCodeView(
                    code: state.card.id.uuidString,
                    progress: state.scratchProgress
                )
            }
            .padding(.horizontal)
        }        
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 12) {
                Text(L10n.clickButtonToRevealCode)
                    .font(.caption)
                    .foregroundColor(Color.App.deeperBlue)
                
                Button(L10n.scratch) {
                    onAction(.scratchCard)
                }
                .buttonStyle(.primary(isLoading: state.isLoading))
                .disabled(state.scratchProgress == 1 || state.isLoading)
            }
            .padding([.horizontal, .bottom])
        }
        .background(Color.App.lightGray.ignoresSafeArea())
        .animation(.default, value: state)
    }

}

// MARK: - Preview

#Preview {

    NavigationView {
        ScratchCardDetailView(
            state: .init(
                card: .sample(),
                scratchProgress: 0
            ),
            onAction: { _ in }
        )
        .padding(.top)
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
    }
    .environment(\.locale, .init(identifier: "en"))
    
}

