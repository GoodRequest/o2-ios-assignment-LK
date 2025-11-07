//
//  CardDetailViewContainer.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

struct CardDetailViewContainer: View {
        
    private let coordinator: CardDetailCoordinatorType
    @State private var viewModel: CardDetailViewModel
    
    init(coordinator: CardDetailCoordinatorType, cardService: CardService) {
        self.coordinator = coordinator
        self._viewModel = State(initialValue: CardDetailViewModel(cardService: cardService))
    }
     
    var body: some View {
        CardDetailView(
            state: .init(
                card: viewModel.card                
            ),
            onAction: handleAction
        )
        .background(Color.gray.opacity(0.1).ignoresSafeArea())        
    }
    
    private func handleAction(_ action: CardDetailView.Action) {
        switch action {
        case .scratchCard:
            if viewModel.card.state == .scratched {
                coordinator.navigateToActivation()
            } else {
                coordinator.navigateToScratchCard()
            }
        }
    }

}


