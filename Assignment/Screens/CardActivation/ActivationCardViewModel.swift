//
//  ActivationCardViewModel.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

@Observable
class ActivationCardViewModel {
    
    var activationResult: GRResult<Card, AppError> = .idle
    var card: Card
    
    private let cardService: CardService
    
    init(cardService: CardService) {
        self.cardService = cardService
        self.card = cardService.card
    }
    
    func activateCoupon() {
        Task<Void, Never> { [cardService, weak self] in
            do throws(AppError) {
                self?.activationResult = .loading
                
                if let card = self?.card {
                    let card = try await cardService.activate(code: card.id.uuidString)
                    self?.activationResult = .success(card)
                }
                let retrievedCard = cardService.card
                self?.card = retrievedCard
            } catch {
                self?.activationResult = .failure(error)
            }
        }
    }
    
}

