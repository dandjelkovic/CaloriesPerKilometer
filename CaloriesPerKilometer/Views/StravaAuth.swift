//
//  StravaAuth.swift
//  CaloriesPerKilometer
//
//  Created by Dalibor Andjelkovic on 10.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

import UIKit
import SwiftUI

struct StravaAuth: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    func updateUIViewController(_ uiViewController: StravaAuthVC, context: Context) {
        if uiViewController.authSucceeded {
            presentationMode.wrappedValue.dismiss()
        }
    }

    func makeUIViewController(context: Context) -> StravaAuthVC {
        StravaAuthVC()
    }
}
