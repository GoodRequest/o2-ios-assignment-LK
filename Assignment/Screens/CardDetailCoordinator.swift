//
//  CardDetailCoordinator.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import SwiftUI

protocol CardDetailCoordinatorType: AnyObject {

    func start() -> UIViewController
    func navigateToActivation()
    func navigateToScratchCard()

}

final class CardDetailCoordinator: CardDetailCoordinatorType {
    
    private weak var navigationController: UINavigationController?
    private let di: DependencyContainer
    
    init(navigationController: UINavigationController, di: DependencyContainer) {
        self.navigationController = navigationController
        self.di = di
    }
    
    func start() -> UIViewController {
        let containerView = CardDetailViewContainer(coordinator: self, cardService: di.cardService)
        let hostingController = UIHostingController(rootView: containerView)
        hostingController.title = L10n.yourCoupon

        return hostingController
    }
    
    func navigateToActivation() {
        let containerView = ActivationCardViewContainer(cardService: di.cardService)
        let hostingController = UIHostingController(rootView: containerView)
        hostingController.title = L10n.useCoupon
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    func navigateToScratchCard() {
        let containerView = ScratchCardDetailViewContainer(cardService: di.cardService)
        let hostingController = UIHostingController(rootView: containerView)
        hostingController.title = L10n.scratchAndWinTitle
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
}

