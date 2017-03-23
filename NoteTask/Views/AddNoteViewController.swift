//
//  AddNoteViewController.swift
//  NoteTask
//
//  Created by Duc Nguyen on 3/21/17.
//  Copyright © 2017 Duc Nguyen. All rights reserved.
//

import UIKit
import RNNotificationView

class AddNoteViewController: UIViewController {

    @IBOutlet weak var tfNoteTitle: UITextField!
    
    @IBOutlet weak var tvNoteContent: PlaceholderTextView!
    
    @IBOutlet weak var btnAddNote: ButtonRoundCorner!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNote(_ sender: Any) {
        
        if (Reachability.isInternetAvailable())
        {
            let noteRef = (ApplicationAssembly.sharedInstance?.noteDataService() as! PNoteDataService).createDataTable(tableName: "list-note")
            
            let noteItem = Note.init(key: NSUUID().uuidString, title: tfNoteTitle.text!, content: tvNoteContent.text, isSync: true)
            
            noteRef.child(noteItem.key).setValue(noteItem.toNSDictionary())
   
            appDelegate.notes.append(noteItem)
            RealmManager.saveObjects(objs: appDelegate.notes)
            RNNotificationView.show(withImage: UIImage(named: "ic_empty_note"),
                                    title: "Note",
                                    message: "Add note sucessfully!",
                                    duration: 2,
                                    iconSize: CGSize(width: 22, height: 22), // Optional setup
                onTap: {
            })
        }
        else
        {
            let noteItem = Note.init(key: NSUUID().uuidString, title: tfNoteTitle.text!, content: tvNoteContent.text, isSync: false)
            appDelegate.notes.append(noteItem)
            RealmManager.saveObjects(objs: appDelegate.notes)
            
            RNNotificationView.show(withImage: UIImage(named: "ic_empty_note"),
                                    title: "Note",
                                    message: "Add note sucessfully!",
                                    duration: 2,
                                    iconSize: CGSize(width: 22, height: 22), // Optional setup
                onTap: {
            })
        }
        self.navigationController?.viewControllers.forEach { ($0 as? MainViewController)?.tblNotes.reloadData()}
        self.navigationController?.viewControllers.forEach { ($0 as? MainViewController)?.tblNotes.isHidden = false}
        self.navigationController?.popViewController(animated: false)
    }
    
}
