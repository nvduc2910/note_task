//
//  NoteDataService.swift
//  NoteTask
//
//  Created by Duc Nguyen on 3/22/17.
//  Copyright © 2017 Duc Nguyen. All rights reserved.
//

import Foundation
import Firebase
import Bolts
public class NoteDataService : NSObject, PNoteDataService
{
    
    
    func createDataTable(tableName: String) -> FIRDatabaseReference {
        
        return FIRDatabase.database().reference(withPath: tableName);
        
    }
    
    func getAllNote(ref: FIRDatabaseReference) -> BFTask<AnyObject>{
        
        
        let taskCompletionSource = BFTaskCompletionSource<AnyObject>()
        var snapShot = FIRDataSnapshot()
        ref.observe(.value, with: { snapshot in
            snapShot = snapshot
            taskCompletionSource.trySetResult(snapShot)
        })
        return taskCompletionSource.task
    }
    
    func syncNote(ref: FIRDatabaseReference, noteItem: AnyObject, key: String) {
        
        let child = ref.child(key)
        child.setValue(noteItem)
        
    }
    
    func deleteNote() {
        
    }
    
    func editNote() {
        
    }
    func getNoteDetail() {
        
    }
    
}
