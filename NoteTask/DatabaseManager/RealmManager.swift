//
//  RealmManager.swift
//  NoteTask
//
//  Created by Duc Nguyen on 3/23/17.
//  Copyright © 2017 Duc Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let realm = try! Realm()
    
    static func deleteDatabase() {
        try! realm.write({
            realm.deleteAll()
        })
    }
    
     static func saveObjects(objs: [Object]) {
        try! realm.write({
            realm.add(objs, update: true)
        })
    }
    
     static func getObjects(type: Object.Type) -> Results<Object>? {
        return realm.objects(type)
    }
}

