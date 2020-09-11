//
//  AuthResponse.swift
//  CaloriesPerKilometer
//
//  Created by Dalibor Andjelkovic on 10.09.20.
//  Copyright © 2020 Dalibor Andjelkovic. All rights reserved.
//

/*
 Example response from

 curl -X POST https://www.strava.com/api/v3/oauth/token \
 -d client_id=ReplaceWithClientID \
 -d client_secret=ReplaceWithClientSecret \
 -d code=ReplaceWithCode \
 -d grant_type=authorization_code

 {
   "token_type": "Bearer",
   "expires_at": 1568775134,
   "expires_in": 21600,
   "refresh_token": "e5n567567...",
   "access_token": "a4b945687g...",
   "athlete": {
     #{summary athlete representation}
   }
 }
 */

struct AuthResponse: Decodable {
    var accessToken: String
    var refreshToken: String

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        accessToken = try container.decode(String.self, forKey: .accessToken)
        refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
}
