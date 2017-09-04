//
//  ProfileRequest.swift
//  DatePlayAssignment
//
//  Created by Rick Williams on 9/1/17.
//  Copyright © 2017 Rick Williams. All rights reserved.
//

import Foundation
import FacebookCore

struct ProfileRequest: GraphRequestProtocol {
    struct Response: GraphResponseProtocol {
        init(rawResponse: Any?) {
            // Decode JSON from rawResponse into other properties here.
        }
    }
    
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
}
