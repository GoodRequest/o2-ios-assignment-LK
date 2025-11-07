//
//  CacheManagerType.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import Combine

protocol CacheManagerType: Sendable {
    
    var card: Card { get }
    var cardPublisher: AnyPublisher<Card, Never> { get }
    func update(card: Card)
    
}
