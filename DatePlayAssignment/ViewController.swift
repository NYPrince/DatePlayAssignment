//
//  ViewController.swift
//  DatePlayAssignment
//
//  Created by Rick Williams on 9/1/17.
//  Copyright © 2017 Rick Williams. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class ViewController: UIViewController, LoginButtonDelegate {
    
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
 
    struct MyProfileRequest: GraphRequestProtocol {
        struct Response: GraphResponseProtocol {
            init(rawResponse: Any?) {
                // Decode JSON from rawResponse into other properties here.
            }
        }
        
        var graphPath = "/me"
        var parameters: [String : Any]? = ["fields": "id, first_name,last_name,email, picture"]
        var accessToken = AccessToken.current
        var httpMethod: GraphRequestHTTPMethod = .GET
        var apiVersion: GraphAPIVersion = .defaultVersion
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email,])
        loginButton.center = view.center
        loginButton.delegate = self
        
        view.addSubview(loginButton)
        
        if let accessToken = AccessToken.current {
         fetchProfile()
        }
        
    }
    
    func fetchProfile(){
        if let accessToken = AccessToken.current {
            
            let graphRequest = GraphRequest.init(graphPath: "me", parameters: ["fields": "email,first_name,last_name,picture"], accessToken: accessToken, httpMethod: GraphRequestHTTPMethod.GET, apiVersion: GraphAPIVersion.defaultVersion)
            
            graphRequest.start({ (response, result) in
                
                            switch result {
                    
                case .success(let graphResponse):
                    
                    var responseDictionary = graphResponse.dictionaryValue
                    
                    //          print("Custom Graph Request Succeeded: \(response)")
                    
                    //          print("My facebook id is \(String(describing: response.dictionaryValue?["id"]))")
                    
                    //          print("My name is \(String(describing: response.dictionaryValue?["name"]))")
                    
                    print("MY EMAIL IS \(responseDictionary?["email"] as! String)")
                    self.email.text = responseDictionary?["email"] as? String
                    
                    print("MY FIRST NAME IS \(responseDictionary?["first_name"] as! String)")
                    self.firstName.text = responseDictionary?["first_name"] as? String
                                
                    print("MY LAST NAME IS \(responseDictionary?["last_name"] as! String)")
                    self.lastName.text = responseDictionary?["last_name"] as? String
                    print("This is my picture \(responseDictionary?["picture"] as! NSDictionary)")
                                
                    // self.profilePhoto.image = data
                                  case .failed(let error):
                    
                    print("Custom Graph Request Failed: \(error)")
                    
                }
                
            })
            
        }
        
    }
    
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("Logged in successfully")
        
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me")) { httpResponse, result in
            switch result {
            case .success(let response):
                print("Graph Request Succeeded: \(response)")
            case .failed(let error):
                print("Graph Request Failed: \(error)")
                                
            }
        }
        connection.start()
      
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
    
    
}
