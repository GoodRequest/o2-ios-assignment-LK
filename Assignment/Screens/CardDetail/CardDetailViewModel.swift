//
//  CardDetailViewModel.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import Foundation
import SwiftUI
import Combine

@Observable
class CardDetailViewModel {
    
    var card: Card
    
    let cardService: CardService
    
    private var cancellables = Set<AnyCancellable>()

    init(cardService: CardService) {        
        self.cardService = cardService
        self.card = cardService.card
        
        bindForCardUpdates()
    }
    
    private func bindForCardUpdates() {
        cardService.cardPublisher
            .sink {
                self.card = $0
            }
            .store(in: &cancellables)
    }
   
}


