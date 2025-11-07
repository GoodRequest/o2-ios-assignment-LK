//
//  Card.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import Foundation

struct Card: Equatable {
    
    let id: UUID
    let brand: String
    let description: String
    var state: CardState
    
    init(
        id: UUID = UUID(),
        brand: String,
        description: String,
        state: CardState = .initial
    ) {
        self.id = id
        self.brand = brand
        self.description = description
        self.state = state
    }
    
    static func sample() -> Card {
        Card(
            brand: "O2",
            description: L10n.everyoneWinsSomething
        )
    }
    
}

