//
//  CacheManager.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import Combine

final class CacheManager: CacheManagerType {
    
    @Published var card: Card
    
    var cardPublisher: AnyPublisher<Card, Never> {
        $card.eraseToAnyPublisher()
    }
    
    init(card: Card) {
        self.card = card
    }
    
    func update(card: Card) {
        self.card = card
    }
    
}
