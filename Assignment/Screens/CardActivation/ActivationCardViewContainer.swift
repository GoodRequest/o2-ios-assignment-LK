//
//  ActivationCardViewContainer.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

struct ActivationCardViewContainer: View {
    
    @State private var viewModel: ActivationCardViewModel
    @State private var activationError: AppError?
    
    init(cardService: CardService) {
        self._viewModel = State(initialValue: ActivationCardViewModel(cardService: cardService))
    }
    
    var body: some View {
        ActivationCardView(
            state: .init(
                card: viewModel.card,
                isLoading: viewModel.activationResult.isLoading
            ),
            onAction: handleAction
        )
        .onChange(of: viewModel.activationResult) { _, new in
            if case .failure(let error) = new {
                activationError = error
            }
        }
        .errorAlert(error: $activationError)        
    }
    
    private func handleAction(_ action: ActivationCardView.Action) {
        switch action {
        case .activate:
            viewModel.activateCoupon()            
        }
    }
    
}

#Preview {

    NavigationView {
        ActivationCardViewContainer(
            cardService: .init(
                cacheManager: CacheManager(card: .sample()),
                requestManager: RequestManager(server: .production)
            )
        )
        .navigationTitle(L10n.useCoupon)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

