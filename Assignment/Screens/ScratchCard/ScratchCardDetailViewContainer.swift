//
//  ScratchCardDetailViewContainer.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

struct ScratchCardDetailViewContainer: View {
    
    @State private var viewModel: ScratchCardDetailViewModel
    
    init(cardService: CardService) {        
        let card = cardService.card
        self._viewModel = State(initialValue: ScratchCardDetailViewModel(cardService: cardService, card: card))
    }
    
    var body: some View {
        ScratchCardDetailView(
            state: .init(
                card: viewModel.card,
                scratchProgress: viewModel.progress
            ),
            onAction: handleAction
        )
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
    }
    
    // MARK: - Private Methods
    
    private func handleAction(_ action: ScratchCardDetailView.Action) {
        switch action {
        case .scratchCard:
            viewModel.scratchCard()
        }
    }
    
}

