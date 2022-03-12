//
//  LoginViewController.swift
//  Twitter
//
//  Created by Rutvij Shah on 3/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
        let secretKey = Bundle.main.object(forInfoDictionaryKey: "SECRET_KEY") as? String
        
        guard let key = apiKey, !key.isEmpty else {
            print("Key Not Found.")
            return
        }
        
        guard let secret = secretKey, !secret.isEmpty else {
            print("Secrete Not Found.")
            return
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        
        let loginUrl = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(
            url: loginUrl,
            success: {
                
                UserDefaults.standard.set(true, forKey: "userLoggedIn")
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            
            },
            failure: { Error in
                print("Couldn't login.")
            })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
