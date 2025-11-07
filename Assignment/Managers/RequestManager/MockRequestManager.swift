//
//  MockRequestManager.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 06/11/2025.
//

import Foundation

final class MockRequestManager: RequestManagerType {
    
    var versionToReturn: Version?
    var errorToThrow: AppError?
    
    init(versionToReturn: Version? = nil, errorToThrow: AppError? = nil) {
        self.versionToReturn = versionToReturn
        self.errorToThrow = errorToThrow
    }
    
    func activateCard(code: String) async throws(AppError) -> Version? {
        if let errorToThrow {
            throw errorToThrow
        }
        return versionToReturn
    }
    
}
