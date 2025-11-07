//
//  CardServiceTests.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 06/11/2025.
//

import Testing
import Combine
import Foundation

@testable import Assignment

@Suite("Card Service Tests")
@MainActor
struct CardServiceTests {
    
    @Test("Activate card with version > minimal version")
    func activateWithNewVersionSucceeds() async throws {
        let cacheManager = MockCacheManager(card: .sample())
        let requestManager = MockRequestManager(versionToReturn: .init(number: 6.2))
        let service = CardService(cacheManager: cacheManager, requestManager: requestManager)
        let result = try await service.activate(code: "VALID")
        
        #expect(result.state == .activated)
    }
    
    @Test("Activate card with version < minimal version")
    func activateWithOldVersionFails() async throws {
        let cacheManager = MockCacheManager(card: .sample())
        let requestManager = MockRequestManager(versionToReturn: .init(number: 6.0))
        let service = CardService(cacheManager: cacheManager, requestManager: requestManager)
        
        await #expect(throws: AppError.activationCardError) {
            try await service.activate(code: "OLD")
        }
    }
    
    @Test("Activate card when nil version is returned")
    func activateWithNilVersionFails() async throws {
        let cacheManager = MockCacheManager(card: .sample())
        let requestManager = MockRequestManager(versionToReturn: nil)
        let service = CardService(cacheManager: cacheManager, requestManager: requestManager)
        
        await #expect(throws: AppError.activationCardError) {
            try await service.activate(code: "NONE")
        }
    }
    
    @Test("Scratch completed and updates card at the end")
    func scratchCompleted() async throws {
        let cacheManager = MockCacheManager(card: .sample())
        let requestManager = MockRequestManager(versionToReturn: .init(number: 6.5))
        let service = CardService(cacheManager: cacheManager, requestManager: requestManager)
        // wait for scratch
        for await _ in service.scratch() { }
        
        #expect(cacheManager.card.state == .scratched)
    }
    
    @Test("Scratch in progress card state should not be changed")
    func scratchInProgress() async throws {
        let cacheManager = MockCacheManager(card: .sample())
        let requestManager = MockRequestManager(versionToReturn: .init(number: 6.5))
        let service = CardService(cacheManager: cacheManager, requestManager: requestManager)
        
        let _ = service.scratch()
        
        #expect(cacheManager.card.state == .initial)
    }
    
    @Test("Scratch cancelled")
    func scratchCancelled() async throws {
        let cacheManager = MockCacheManager(card: .sample())
        let requestManager = MockRequestManager(versionToReturn: .init(number: 6.5))
        let service = CardService(cacheManager: cacheManager, requestManager: requestManager)
        
        let task = Task {
            for await _ in service.scratch() { }
        }
        
        try await Task.sleep(for: .seconds(1))
        task.cancel()
        
        #expect(cacheManager.card.state == .initial)
    }
    
}
