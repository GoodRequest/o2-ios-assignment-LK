//
//  CardView.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

struct CardView<BottomContent: View>: View {
    
    let model: Model
    let bottomContent: BottomContent
    
    init(model: Model, @ViewBuilder bottomContent: () -> BottomContent) {
        self.model = model
        self.bottomContent = bottomContent()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CardBrandView(brandText: model.brand)
            
            VStack(spacing: 26) {
                CardInfoTextView(
                    scratchText: model.title,
                    winsText: model.description
                )
                
                if let stateMessage = model.stateMessage {
                    InfoBoxView(message: stateMessage)
                }
                
                bottomContent
            }
            .padding()
        }
        .background(Color.App.gray)
        .cornerRadius(16)
        .clipped()
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

extension CardView where BottomContent == EmptyView {
    
    init(model: Model) {
        self.model = model
        self.bottomContent = EmptyView()
    }
    
}

extension CardView {

    struct Model {
        let id: UUID
        let brand: String
        let title: String
        let description: String
        let state: CardState
        
        init(card: Card, title: String) {
            self.id = card.id
            self.brand = card.brand
            self.title = title
            self.description = card.description
            self.state = card.state
        }
        
        var stateMessage: String? {
            switch state {
            case .initial:
                return nil
            case .scratched:
                return L10n.codeRevealedAndReadyForActivationWithDot
            case .activated:
                return L10n.thisCouponIsActivated
            }
        }
                   
    }
    
}

#Preview {

    VStack {
        CardView(
            model: .init(
                card: .sample(),
                title: L10n.clickToRevealHiddenCode)
        )
        .padding()
        
        CardView(
            model: .init(
                card: .sample(),
                title: L10n.clickToRevealHiddenCode)
        ) {
            Text("Custom bottom content")
                .foregroundColor(.blue)
        }
        .padding()
    }
    
}

