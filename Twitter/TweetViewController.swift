//
//  TweetViewController.swift
//  Twitter
//
//  Created by Rutvij Shah on 3/20/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var theTweet: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        theTweet.becomeFirstResponder()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!theTweet.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: theTweet.text) {
                self.dismiss(animated: true)
            } failure: { Error in
                print("Error posting tweet \(Error)")
            }
        } else {
            dismiss(animated: true)
        }
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
