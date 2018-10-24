//
//  ViewController.swift
//  LyricsObtainer
//
//  Created by Kaleb Allen on 10/23/18.
//  Copyright © 2018 Kaleb Allen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var ArtistText: UITextField!
    @IBOutlet weak var SongTitle: UITextField!
    @IBOutlet weak var LyricsFeild: UITextView!
    @IBOutlet weak var SubmitButton: UIButton!
    
    let lyricsAPIBaseURL = "https://api.lyrics.ovh/v1/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ArtistText.delegate = self
        SongTitle.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    @IBAction func
        submiteButtonTapped(_ sender: Any) {
        
        guard let artistName = ArtistText.text,
            let songTitle = SongTitle.text else {
                return
        }
        
        let artistNameURLComponet = artistName.replacingOccurrences(of: " ", with: "+")
        
        
        let songTitleURLComponet = songTitle.replacingOccurrences(of: " ", with: "+")
        
        
        //Full URL for the request we will make to the API
        let requestURL = lyricsAPIBaseURL + artistNameURLComponet + "/" + songTitleURLComponet
        //using Alamo fire to create an actual request
        let request = Alamofire.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        //now we actually got to make our request
        request.responseJSON { response in
            //we switch based on wather we scucced or not
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                self.LyricsFeild.text = json["lyrics"].stringValue
                
                //in the case of suceed and we've gottne data
                print("sucess!")
            case .failure(let error):
                //in the case of a failure the request did not get data back
                print("error:(")
            }
        }
    }
    
}

