//
//  ActivationCardView.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

extension ActivationCardView {
    
    struct State {
        let card: Card
        let isLoading: Bool
    }
    
    enum Action {
        case activate
    }
    
}

struct ActivationCardView: View {
    
    let state: State
    let onAction: CallbackClosure<Action>
    
    var body: some View {
        ScrollView {
            CardView(
                model: .init(
                    card: state.card,
                    title: L10n.yourCoupon)
            ) {
                VStack(spacing: 20) {
                    ScratchCodeView(
                        code: state.card.id.uuidString,
                        progress: 1
                    )                                       
                }
            }
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .bottom) {
            Button(buttonTitle) {
                onAction(.activate)
            }
            .buttonStyle(.primary(isLoading: state.isLoading))
            .disabled(isButtonDisabled)
            .padding()
        }
        .background(Color.App.lightGray.ignoresSafeArea())
    }
    
}

private extension ActivationCardView {
    
    var infoMessage: String {
        state.card.state != .activated
            ? L10n.couponNotYetActivatedClickButtonBelowToActivate
            : L10n.thisCouponIsActivated
    }
    
    var buttonTitle: String {
        state.card.state != .activated ? L10n.activate : L10n.activated
    }
    
    var isButtonDisabled: Bool {
        state.card.state == .activated
    }
    
}

