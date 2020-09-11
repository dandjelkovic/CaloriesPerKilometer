//
//  StravaAuthVC.swift
//  CaloriesPerKilometer
//
//  Created by Dalibor Andjelkovic on 10.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

import UIKit
import AuthenticationServices

class StravaAuthVC: UIViewController {

    var authSucceeded = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Network.authenticateStrava(context: self)
    }
}

extension StravaAuthVC: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }


}
