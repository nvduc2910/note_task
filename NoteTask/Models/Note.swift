//
//  Note.swift
//  NoteTask
//
//  Created by Duc Nguyen on 3/21/17.
//  Copyright © 2017 Duc Nguyen. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

public class Note : Object
{
    dynamic var key : String = ""
    dynamic var title : String = ""
    dynamic var content : String = ""
    dynamic var isSync : Bool = false

    
    convenience init(key: String, title : String, content: String, isSync: Bool) {
        
        self.init()
        self.key = key
        self.title = title
        self.content = content
        self.isSync = isSync
    }
    
    override public static func primaryKey() -> String? {
        return "key"
    }
    
    convenience init(snapshot: FIRDataSnapshot) {

        self.init()
        
        self.key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.title = snapshotValue["title"] as! String
        self.content = snapshotValue["content"] as! String
        self.isSync = snapshotValue["isSync"] as! Bool
        
    }
    
    
    func toNSDictionary() -> NSDictionary{
        return [
            "title" : self.title,
            "content" : self.content,
            "isSync": self.isSync
        ]
    }
    
}


