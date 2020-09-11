//
//  Network.swift
//  CaloriesPerKilometer
//
//  Created by Dalibor Andjelkovic on 10.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

import Foundation
import UIKit
import AuthenticationServices

enum Network {
    private static var clientID: String {
        let fileURL = Bundle.main.url(forResource: "credentials", withExtension: "json")!
        do {
            let data = try Data(contentsOf: fileURL)
            guard
                let credentials = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
                let clientId = credentials["client_id"]
            else { return "" }

            return clientId
        }
        catch {
            return ""
        }
    }
    private static var clientSecret: String {
        let fileURL = Bundle.main.url(forResource: "credentials", withExtension: "json")!
        do {
            let data = try Data(contentsOf: fileURL)
            guard
                let credentials = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
                let clientSecret = credentials["client_secret"]
            else { return "" }
            
            return clientSecret
        }
        catch {
            return ""
        }
    }
    static var accessToken: String? {
        didSet {
            Network.getActivities() { activites in
                DispatchQueue.main.async {
                    store.actvities = activites
                }
            }
        }
    }
    static var refreshToken: String?

    static func authenticateStrava(context: UIViewController) {
        var authSession: ASWebAuthenticationSession?

        let appOAuthUrlStravaScheme = URL(string: "strava://oauth/mobile/authorize?client_id=\(clientID)&redirect_uri=callculatecalories%3A%2F%2Flocalhost&response_type=code&approval_prompt=auto&scope=read%2Cactivity%3Aread_all%2Cread_all&state=test")!

        let webOAuthUrl = URL(string: "https://www.strava.com/oauth/mobile/authorize?client_id=\(clientID)&redirect_uri=callculatecalories%3A%2F%2Flocalhost&response_type=code&approval_prompt=auto&scope=read%2Cactivity%3Aread_all%2Cread_all&state=test")!

        if UIApplication.shared.canOpenURL(appOAuthUrlStravaScheme) {
            UIApplication.shared.open(appOAuthUrlStravaScheme, options: [:])
        } else {
            authSession = ASWebAuthenticationSession(url: webOAuthUrl, callbackURLScheme: "callculatecalories://") { callbackURL, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let callbackURL = callbackURL {
                    let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
                    if let code = queryItems?.filter({ $0.name == "code" }).first?.value {
                        Network.getAccessTokenWithCode(code: code)
                        (context as! StravaAuthVC).authSucceeded = true
                        store.authSucceededButNotFinished = true
                    } else {
                        print("code empty")
                    }
                } else {
                    print("callbackURL is nil")
                }
            }
            authSession?.presentationContextProvider = context as? ASWebAuthenticationPresentationContextProviding
            authSession?.start()
        }
    }

    static func getAccessTokenWithCode(code: String) {
        let url = URL(string: "https://www.strava.com/api/v3/oauth/token")!
        let jsonDict : [String: Any] = [
            "client_id" : "\(clientID)",
            "client_secret" : "\(clientSecret)",
            "code" : "\(code)",
            "grant_type" : "authorization_code",
        ]

        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDict, options: [])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                do {
                    let authReponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                    Network.accessToken = authReponse.accessToken
                    Network.refreshToken = authReponse.refreshToken
                }
                catch let error {
                    print(error.localizedDescription)
                }
            }

        }.resume()
    }

    static func getActivities(completion: @escaping ([Activity]) -> Void) {
        guard let token = Network.accessToken else { return }
        // watch out for the page limit of ca. 250
        let url = URL(string: "https://www.strava.com/api/v3/athlete/activities?per_page=200")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([Activity].self, from: data)
                    completion(result)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

}
