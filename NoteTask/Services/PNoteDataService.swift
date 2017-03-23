//
//  PNoteDataService.swift
//  NoteTask
//
//  Created by Duc Nguyen on 3/22/17.
//  Copyright © 2017 Duc Nguyen. All rights reserved.
//

import Foundation
import Firebase
import Bolts
protocol PNoteDataService {
    
    func createDataTable(tableName: String) -> FIRDatabaseReference
    func getAllNote(ref: FIRDatabaseReference) -> BFTask<AnyObject>
    func syncNote(ref: FIRDatabaseReference, noteItem: AnyObject, key: String)
    func deleteNote()
    func editNote()
    func getNoteDetail()
}
