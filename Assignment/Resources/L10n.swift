//
//  L10n.swift
//  Assignment
//
//  Generated from Localizable.strings
//  DO NOT EDIT - This file is auto-generated
//

import Foundation

enum L10n {
    
    nonisolated static let activate = tr("Localizable", "activate")
    nonisolated static let activated = tr("Localizable", "activated")
    nonisolated static let clickButtonToRevealCode = tr("Localizable", "clickButtonToRevealCode")
    nonisolated static let clickToRevealHiddenCode = tr("Localizable", "clickToRevealHiddenCode")
    nonisolated static let codeAlreadyActivated = tr("Localizable", "codeAlreadyActivated")
    nonisolated static let codeRevealedAndReadyForActivation = tr("Localizable", "codeRevealedAndReadyForActivation")
    nonisolated static let codeRevealedAndReadyForActivationWithDot = tr("Localizable", "codeRevealedAndReadyForActivationWithDot")
    nonisolated static let couponActivated = tr("Localizable", "couponActivated")
    nonisolated static let couponNotYetActivatedClickButtonBelowToActivate = tr("Localizable", "couponNotYetActivatedClickButtonBelowToActivate")
    nonisolated static let everyoneWinsSomething = tr("Localizable", "everyoneWinsSomething")
    nonisolated static let failedToActivateCoupon = tr("Localizable", "failedToActivateCoupon")
    nonisolated static let hidden = tr("Localizable", "hidden")
    nonisolated static let ifYouDontUseCouponImmediatelyItWillBeAddedToMyCoupons = tr("Localizable", "ifYouDontUseCouponImmediatelyItWillBeAddedToMyCoupons")
    nonisolated static let ok = tr("Localizable", "ok")
    nonisolated static let scratch = tr("Localizable", "scratch")
    nonisolated static let scratchAndWin = tr("Localizable", "scratchAndWin")
    nonisolated static let scratchAndWinTitle = tr("Localizable", "scratchAndWinTitle")
    nonisolated static let scratchToRevealTheWinningCode = tr("Localizable", "scratchToRevealTheWinningCode")
    nonisolated static let thisCouponIsActivated = tr("Localizable", "thisCouponIsActivated")
    nonisolated static let useCoupon = tr("Localizable", "useCoupon")
    nonisolated static let yourAppVersionIsLowerThanRequiredForCardActivationPleaseUpdateToTheLatestVersion = tr("Localizable", "yourAppVersionIsLowerThanRequiredForCardActivationPleaseUpdateToTheLatestVersion")
    nonisolated static let yourCoupon = tr("Localizable", "yourCoupon")

}

extension L10n {
    
    nonisolated private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = Bundle.main.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
    
}
