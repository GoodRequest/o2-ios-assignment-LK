//
//  ScratchCardDetailViewModel.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

@Observable
final class ScratchCardDetailViewModel {
    
    private let cardService: CardService
    
    var card: Card
    var progress = 0.0
    
    var isLoading: Bool {
        progress > 0 && progress < 1
    }
    
    var isRevealed: Bool {
        progress >= 1
    }
    
    private var scratchingTask: Task<Void, Never>?
    
    init(cardService: CardService, card: Card) {
        self.cardService = cardService
        self.card = card
    }
    
    func scratchCard() {
        guard !isRevealed && progress == 0 else { return }
        
        scratchingTask = Task { [weak self, cardService] in
            for await progressValue in cardService.scratch() {
                let newProgress = progressValue
                    self?.progress = newProgress
            }
            self?.card = cardService.card
        }
    }
    
    isolated deinit {
        self.scratchingTask?.cancel()     
    }
    
}

