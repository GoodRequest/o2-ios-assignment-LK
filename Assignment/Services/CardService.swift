//
//  CardService.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 06/11/2025.
//

import Foundation
import Combine

final class CardService {
    
    private enum Constants {
        static let minimalActivationVersionNumber: Double = 6.1
    }
    
    private let cacheManager: CacheManagerType
    private let requestManager: RequestManagerType

    var card: Card { cacheManager.card }
    
    var cardPublisher: AnyPublisher<Card, Never> {
        cacheManager.cardPublisher
    }
    
    init(cacheManager: CacheManagerType, requestManager: RequestManagerType) {
        self.cacheManager = cacheManager
        self.requestManager = requestManager
    }
    
    func scratch() -> AsyncStream<Double> {
        return AsyncStream<Double> { continuation in
            let task = Task {
                let duration: TimeInterval = 2.0
                let updateInterval: TimeInterval = 0.05
                let steps = Int(duration / updateInterval)
                
                for step in 0...steps {
                    guard !Task.isCancelled else {
                        continuation.finish()
                        
                        return
                    }
                    
                    let progress = Double(step) / Double(steps)
                    continuation.yield(progress)
                    
                    if step < steps {
                        try? await Task.sleep(for: .seconds(updateInterval))
                    }
                }
                
                let scratchedCard = scratch(card: card)
                cacheManager.update(card: scratchedCard)
                continuation.finish()

            }
            
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
    
    func activate(code: String) async throws(AppError) -> Card {
        try? await Task.sleep(for: .seconds(2))
        let version = try await requestManager.activateCard(code: code)
        if let versionNumber = version?.number, versionNumber > Constants.minimalActivationVersionNumber {
            var card = cacheManager.card
            card.state = .activated
            cacheManager.update(card: card)
        } else {
            throw AppError.activationCardError
        }

        return cacheManager.card
    }
    
    // MARK: - Private Methods
    
    private func scratch(card: Card) -> Card {
        var card = card
        card.state = .scratched

        return card
    }
     
}
