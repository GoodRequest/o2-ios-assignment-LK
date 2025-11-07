//
//  DependencyContainer.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 05/11/2025.
//

final class DependencyContainer {
    
    let requestManager: RequestManagerType
    let cacheManager: CacheManagerType
    
    // MARK: - Card Service
    
    weak var cardServiceInstance: CardService?
    
    var cardService: CardService {
        get {
            let instance = cardServiceInstance ?? CardService(cacheManager: self.cacheManager, requestManager: self.requestManager)
            cardServiceInstance = instance
            
            return instance
        }
    }
    
    init(requestManager: RequestManagerType, cacheManager: CacheManagerType) {
        self.requestManager = requestManager
        self.cacheManager = cacheManager
    }
    
}
