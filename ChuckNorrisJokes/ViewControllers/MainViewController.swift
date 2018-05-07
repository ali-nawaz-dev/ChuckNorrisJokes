//
//  JokesViewController.swift
//  ChuckNorrisJokes
//
//  Created by Apple on 07/05/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class JokesViewController: UIViewController {

    class func instantiateFromStoryboard() -> JokesViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! JokesViewController
    }
    
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var jokes: [JokeModel] = [JokeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func GetJokes(_ sender: UIButton) {
        self.GetJokes()
    }
    
    //MARK:-  Get Jokes Service
    
    func GetJokes() {
        
        Alert.showLoader(message: "")
        
        let param = ["firstName": self.txtFName.text!.capitalizeFirstLetter(),
                     "lastName": self.txtLName.text!.capitalizeFirstLetter()]
        
        JokesServices.GetJokes(param: param , completionHandler: {(status, response, error) in
            Alert.hideLoader()
            if !status {
                if error != nil {
                    Alert.showAlert(title: "Error", message: "\((error as! Error).localizedDescription)")
                    return
                }
                Alert.showAlert(title: "Error", message: "Something went wrong")
                return
            }
            
            let jokesArray = response?["value"].arrayValue
            print(jokesArray!)
            
            for resultObj in jokesArray! {
                let obj =  JokeModel(json: resultObj)
                self.jokes.append(obj)
            }
        })
    }

}

