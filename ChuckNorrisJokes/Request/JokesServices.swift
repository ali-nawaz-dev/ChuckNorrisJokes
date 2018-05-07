//
//  JokesServices.swift
//  ChuckNorrisJokes
//
//  Created by Apple on 07/05/2018.
//  Copyright © 2018 Apple. All rights reserved.
//


import Foundation
import SwiftyJSON

class JokesServices {
    
    
    //MARK:-  Get User Subscription
    
    static func SubscriptionUser(param: [String : Any], completionHandler:@escaping (_ success: Bool,_ response: JSON?,_ error: Any?)->Void) {
        
        Request.GetRequest(fromSavedUrl: ServiceApiEndPoints.userSubscription, parameters: param, callback: { (response, error) in
            
            Alert.hideLoader()
            
            if error != nil {
                print("Error: \(String(describing: (error?.localizedDescription)!))")
                completionHandler(false, nil, error)
                
                Alert.showAlert(title: "Alert", message: String(describing: (error?.localizedDescription)!))
                return
            }
            
            if response?["Response"].stringValue != "2000" {
                let msg = response?["Message"].stringValue
                print("Message: \(String(describing: msg!))")
                completionHandler(false, response!, nil)
                
               // Alert.showAlert(title: "Alert", message: (response?["Message"].stringValue)!)
                return
            }
            completionHandler(true, response!, nil)
        })
    }
    
}
