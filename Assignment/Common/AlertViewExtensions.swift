//
//  AlertViewExtensions.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 05/11/2025.
//

import SwiftUI

extension View {
    
    func errorAlert(error: Binding<AppError?>, buttonTitle: String = L10n.ok) -> some View {
        return alert(isPresented: .constant(error.wrappedValue != nil), error: error.wrappedValue) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "")
        }
    }
    
}
