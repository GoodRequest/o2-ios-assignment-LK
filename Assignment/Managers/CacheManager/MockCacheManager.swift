//
//  MockCacheManager.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 06/11/2025.
//

import Combine

class MockCacheManager: CacheManagerType {
    
    var card: Card { _card }
    
    @Published private var _card: Card
    
    var cardPublisher: AnyPublisher<Card, Never> {
        $_card.eraseToAnyPublisher()
    }
    
    init(card: Card) {
        self._card = card
    }
    
    func update(card: Card) {
        self._card = card
    }
    
}
