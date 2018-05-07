//
//  Request.swift
//  ChuckNorrisJokes
//
//  Created by Apple on 07/05/2018.
//  Copyright © 2018 Apple. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

class Request: NSObject {
    
    /// GET Method with header
    ///
    /// - Parameters:
    ///     - url: URL in string format for request
    ///     - header: Headers in dictionary format for request
    /// - Returns: void
 
    static func GetRequestWHeader(fromSavedUrl url: String, header:[String:String], parameters: [String: Any], callback: ((JSON?, Error?) -> Void)?) {
        
        print("API - Request URL: \(url)")
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON{ (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.isSuccess {
                    if let value: Any = response.result.value as AnyObject? {
                        let response = JSON(value)
                        callback?(response, nil)
                    }
                }
                else {
                    print("Request failed with error: \(response.result.error!.localizedDescription)")
                    callback?(nil, response.result.error!)
                }
            case .failure(_):
                print("Request failed with error: \(response.result.error!.localizedDescription)")
                callback?(nil, response.result.error!)
                break
            }
        }
    }
    
    static func GetRequest(fromSavedUrl url: String, parameters: [String: Any], callback: ((JSON?, Error?) -> Void)?) {
        
        print("API - Request URL: \(url)")
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: [:]).responseJSON{ (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.isSuccess {
                    if let value: Any = response.result.value as AnyObject? {
                        let response = JSON(value)
                        callback?(response, nil)
                    }
                }
                else {
                    print("Request failed with error: \(response.result.error!.localizedDescription)")
                    callback?(nil, response.result.error!)
                }
            case .failure(_):
                print("Request failed with error: \(response.result.error!.localizedDescription)")
                callback?(nil, response.result.error!)
                break
            }
        }
    }
    
    static func PostRequestWHeader(fromSavedUrl url: String, header:[String:String], parameters: [String: Any], callback: ((JSON?, Error?) -> Void)?) {
        
        print("API - Request URL: \(url)")
        
        Alamofire.request(url, method: .post, parameters: parameters, headers: header).responseJSON{ (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.isSuccess {
                    if let value: Any = response.result.value as AnyObject? {
                        let response = JSON(value)
                        callback?(response, nil)
                    }
                }
                else {
                    print("Request failed with error: \(response.result.error!.localizedDescription)")
                    callback?(nil, response.result.error!)
                }
            case .failure(_):
                print("Request failed with error: \(response.result.error!.localizedDescription)")
                callback?(nil, response.result.error!)
                break
            }
        }
    }
    
    static func PostRequest(fromSavedUrl url: String, parameters: [String: Any], callback: ((JSON?, Error?) -> Void)?) {
        
        print("API - Request URL: \(url)")
        
        Alamofire.request(url, method: .post, parameters: parameters, headers: [:]).responseJSON{ (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.isSuccess {
                    if let value: Any = response.result.value as AnyObject? {
                        let response = JSON(value)
                        callback?(response, nil)
                    }
                }
                else {
                    print("Request failed with error: \(response.result.error!.localizedDescription)")
                    callback?(nil, response.result.error!)
                }
            case .failure(_):
                print("Request failed with error: \(response.result.error!.localizedDescription)")
                callback?(nil, response.result.error!)
                break
            }
        }
    }
    
    static func DeleteRequestWHeader(fromSavedUrl url: String, header:[String:String], parameters: [String: Any], callback: ((JSON?, Error?) -> Void)?) {
        
        print("API - Request URL: \(url)")
        
        Alamofire.request(url, method: .delete, parameters: parameters, headers: header).responseJSON{ (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.isSuccess {
                    if let value: Any = response.result.value as AnyObject? {
                        let response = JSON(value)
                        callback?(response, nil)
                    }
                }
                else {
                    print("Request failed with error: \(response.result.error!.localizedDescription)")
                    callback?(nil, response.result.error!)
                }
            case .failure(_):
                print("Request failed with error: \(response.result.error!.localizedDescription)")
                callback?(nil, response.result.error!)
                break
            }
        }
    }
    
    static func DeleteRequest(fromSavedUrl url: String, parameters: [String: Any], callback: ((JSON?, Error?) -> Void)?) {
        
        print("API - Request URL: \(url)")
        
        Alamofire.request(url, method: .delete, parameters: parameters, headers: [:]).responseJSON{ (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.isSuccess {
                    if let value: Any = response.result.value as AnyObject? {
                        let response = JSON(value)
                        callback?(response, nil)
                    }
                }
                else {
                    print("Request failed with error: \(response.result.error!.localizedDescription)")
                    callback?(nil, response.result.error!)
                }
            case .failure(_):
                print("Request failed with error: \(response.result.error!.localizedDescription)")
                callback?(nil, response.result.error!)
                break
            }
        }
    }
    
    static func UploadMultipleImages(fromSavedUrl url: String, parameters: [String: Any], images: [UIImage], callback: ((JSON?, Error?) -> Void)?) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (index, img) in images.enumerated() {
                let imageData = UIImageJPEGRepresentation(img, 0.0)
                multipartFormData.append(imageData!, withName: "ad_images[\(index)]", fileName: "post.jpg", mimeType: "image/jpg")
            }
            for (key, value) in parameters {
                multipartFormData.append(("\(value)" as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                print("Key::\(key) -> Value::\(value)")
            }
        }, to: url)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("progress::\(progress)")
                })
                //self.uploadRequest = upload.responseData(completionHandler: { response in
                upload.responseData(completionHandler: { response in
                    
                    if response.result.isSuccess {
                        print("SUCCESS")
                        let jsonData = JSON.init(data: response.data!)
                        callback?(jsonData, nil)
                    }
                    else {
                        print("FAILURE")
                        print("\(String(describing: (response.error?.localizedDescription)!))")
                        callback?(nil, response.error)
                    }
                })
                
            case .failure(let encodingError):
                print("Fail:: \(encodingError.localizedDescription)")
                callback?(nil, encodingError)
                
                break
            }
        }
    }
    
    static func UploadImage(fromSavedUrl url: String, parameters: [String: Any], image: UIImage, callback: ((JSON?, Error?) -> Void)?) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            let imageData = UIImageJPEGRepresentation(image, 0.0)
            multipartFormData.append(imageData!, withName: "profile_picture", fileName: "post.jpg", mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append(("\(value)" as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                print("Key::\(key) -> Value::\(value)")
            }
        }, to: url)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("progress::\(progress)")
                })
                //self.uploadRequest = upload.responseData(completionHandler: { response in
                upload.responseData(completionHandler: { response in
                    
                    if response.result.isSuccess {
                        print("SUCCESS")
                        let jsonData = JSON.init(data: response.data!)
                        callback?(jsonData, nil)
                    }
                    else {
                        print("FAILURE")
                        print("\(String(describing: (response.error?.localizedDescription)!))")
                        callback?(nil, response.error)
                    }
                })
                
            case .failure(let encodingError):
                print("Fail:: \(encodingError.localizedDescription)")
                callback?(nil, encodingError)
                
                break
            }
        }
    }
    
    /*
    func fetchData(fromSavedUrl url: String, parameters: [String: Any], callback: ((JSON?, Error?) -> Void)?) {
        
        print("API - Request URL: \(url)")
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                 multipartFormData.append(("\(value)" as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                print("Key::\(key) -> Value::\(value)")
            }
        }, to: url)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("progress::\(progress)")
                })
                
                self.uploadRequest = upload.responseData(completionHandler: { response in
                    
                    if response.result.isSuccess {
                        print("SUCCESS")
                        let jsonData = JSON.init(data: response.data!)
                        callback?(jsonData, nil)
                    }
                    else {
                        print("FAILURE")
                        print("\(String(describing: (response.error?.localizedDescription)!))")
                        callback?(nil, response.error)
                    }
                })
                
            case .failure(let encodingError):
                print("Fail:: \(encodingError.localizedDescription)")
                callback?(nil, encodingError)
                
                break
            }
        }
    }
    
    func fetchWImageData(fromSavedUrl url: String, parameters: [String: Any], image: [UIImage], callback: ((JSON?, Error?) -> Void)?) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (index, img) in image.enumerated() {
                let imageData = UIImageJPEGRepresentation(img, 0.0)
                multipartFormData.append(imageData!, withName: "images[\(index)]", fileName: "post.jpg", mimeType: "image/jpg")
            }
            for (key, value) in parameters {
                multipartFormData.append(("\(value)" as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                print("Key::\(key) -> Value::\(value)")
            }
        }, to: url)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("progress::\(progress)")
                })
                
                self.uploadRequest = upload.responseData(completionHandler: { response in
                    
                    if response.result.isSuccess {
                        print("SUCCESS")
                        let jsonData = JSON.init(data: response.data!)
                        callback?(jsonData, nil)
                    }
                    else {
                        print("FAILURE")
                        print("\(String(describing: (response.error?.localizedDescription)!))")
                        callback?(nil, response.error)
                    }
                })
                
            case .failure(let encodingError):
                print("Fail:: \(encodingError.localizedDescription)")
                callback?(nil, encodingError)
                
                break
            }
        }
    }
 */

}
