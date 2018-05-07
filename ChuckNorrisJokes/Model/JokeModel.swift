//
//  Value.swift
//
//  Created by Apple on 07/05/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class JokeModel: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let id = "id"
        static let joke = "joke"
        static let categories = "categories"
    }
    
    // MARK: Properties
    public var id: Int?
    public var joke: String?
    public var categories: [String]?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: JSON) {
        self.init(json: object)
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        id = json[SerializationKeys.id].int
        joke = json[SerializationKeys.joke].string
        if let items = json[SerializationKeys.categories].array { categories = items.map { $0.stringValue } }
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = joke { dictionary[SerializationKeys.joke] = value }
        if let value = categories { dictionary[SerializationKeys.categories] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
        self.joke = aDecoder.decodeObject(forKey: SerializationKeys.joke) as? String
        self.categories = aDecoder.decodeObject(forKey: SerializationKeys.categories) as? [String]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(joke, forKey: SerializationKeys.joke)
        aCoder.encode(categories, forKey: SerializationKeys.categories)
    }
    
}

