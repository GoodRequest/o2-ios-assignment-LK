//
//  CardDetailView.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

extension CardDetailView {
    
    struct State: Equatable {
        let card: Card
    }
    
    enum Action {
        case scratchCard
    }
    
}

struct CardDetailView: View {
    
    let state: State
    let onAction: CallbackClosure<Action>
    
    var body: some View {
        ScrollView {
            CardView(model: .init(card: state.card, title: L10n.yourCoupon))
                .padding()            
        }
        .safeAreaInset(edge: .bottom) {
            if state.card.state != .activated {
                VStack(spacing: 12) {
                    Text(instructionText)
                        .font(.caption)
                        .foregroundColor(Color.App.deeperBlue)
                    
                    Button(buttonTitle) {
                        onAction(.scratchCard)
                    }
                    .buttonStyle(.primary)
                    .disabled(state.card.state == .activated)
                }
                .padding([.horizontal, .bottom])
            }
        }
        .background(Color.App.lightGray.ignoresSafeArea())
    }
        
}

private extension CardDetailView {
    
    var instructionText: String {
        switch state.card.state {
        case .initial:
            L10n.clickToRevealHiddenCode
        case .activated:
            L10n.codeAlreadyActivated
        case .scratched:
            L10n.codeRevealedAndReadyForActivation
        }
    }
    
    var buttonTitle: String {
        switch state.card.state {
        case .initial:
            L10n.scratch
        case .activated:
            L10n.useCoupon
        case .scratched:
            L10n.activate
        }
    }
    
}

#Preview {

    NavigationView {
        CardDetailView(
            state: .init(
                card: .sample()
            ),
            onAction: { _ in }
        )
        .padding(.top)
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
        .navigationTitle(L10n.yourCoupon)
        .navigationBarTitleDisplayMode(.large)
    }
    
}

