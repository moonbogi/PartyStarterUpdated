//
//  ViewController.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-22.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookCore
import FacebookLogin
import FirebaseAuth


class ViewController: UIViewController, LoginButtonDelegate {
    

    var id:String?
    var logButton : FBLoginButton = FBSDKLoginButton()

    override func viewDidLoad() {

        logButton.readPermissions = ["email", "public_profile", "user_friends", "user_events"]

        logButton.center = view.center
        
        logButton.delegate = self
        
        view.addSubview(logButton)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        if let accessToken = AccessToken.current {
            
            performSegue(withIdentifier: "tableViewSegue", sender: self)
            
            id = accessToken.id
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton!) {
        
        print("logged out")
        
    }
    
    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
        
        if(error != nil) {
            
            self.logButton.isHidden = false
            
        }
        else if (result.isCancelled) {
            
            self.logButton.isHidden = false
            
        }
            
        else  {
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            Auth.auth()?.signIn(with: credential) { (user, error) in
                
                UserDefaults.standard.set(FIRAuth.auth()!.currentUser!.uid, forKey: "uid")
                
                UserDefaults.standard.synchronize()
                
            }
            
        }
        
        
        
        performSegue(withIdentifier: "tableViewSegue", sender: self)

        self.logButton.isHidden = true
        
    }

}

