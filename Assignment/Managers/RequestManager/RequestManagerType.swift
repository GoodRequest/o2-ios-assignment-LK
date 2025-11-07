//
//  RequestManagerType.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

protocol RequestManagerType {

    func activateCard(code: String) async throws(AppError) -> Version?

}

