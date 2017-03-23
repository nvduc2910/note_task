
//
//  MainViewController.swift
//  NoteTask
//
//  Created by Duc Nguyen on 3/21/17.
//  Copyright © 2017 Duc Nguyen. All rights reserved.
//

import UIKit
import Firebase
import RNNotificationView

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblNotes: UITableView!
    
    let identifierTblNotes = "NoteTableViewCell"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let noteRef = (ApplicationAssembly.sharedInstance?.noteDataService() as! PNoteDataService).createDataTable(tableName: "list-note")
    var count = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tblNotes.delegate = self
        self.tblNotes.dataSource = self
        self.tblNotes.register(UINib(nibName: identifierTblNotes, bundle: nil), forCellReuseIdentifier: identifierTblNotes)
        
        if(Reachability.isInternetAvailable()){
            getDataNoteOnline()
        }
        else{
            getDataNoteOffline()
        }
    }
    
    
    func getDataNoteOffline()
    {
        
        if let objects = RealmManager.getObjects(type: Note.self) {
            for element in objects {
                if let noteItem = element as? Note {
                    appDelegate.notes.append(noteItem)
                }
            }
            if(self.appDelegate.notes.count == 0)
            {
                self.tblNotes.isHidden = true
            }
            else
            {
                self.tblNotes.isHidden = false;
                self.tblNotes.reloadData()
            }
            tblNotes.reloadData()
        }
    }
    
    func syncNoteToFireBase()
    {
        if let objects = RealmManager.getObjects(type: Note.self) {
            for element in objects {
                if let noteItem = element as? Note {
                    if(!noteItem.key.isEmpty && noteItem.isSync == false)
                    {
                        print(noteItem.key.isEmpty)
                        count += 1
                        if(Reachability.isInternetAvailable() == true)
                        {
                            try! RealmManager.realm.write {
                                 noteItem.isSync = true
                            }
                           
                            noteRef.child(noteItem.key).setValue(noteItem.toNSDictionary())
                        }
                    }
                }
            }
            if(count != 0 && Reachability.isInternetAvailable() == true)
            {
                RNNotificationView.show(withImage: UIImage(named: "ic_empty_note"),
                                        title: "Note",
                                        message: "synced " + String(count) + " notes",
                                        duration: 2,
                                        iconSize: CGSize(width: 22, height: 22), // Optional setup
                    onTap: {
                })
            }
        }

    }
    
    func getDataNoteOnline()
    {
        syncNoteToFireBase()
        
        let noteRef = (ApplicationAssembly.sharedInstance?.noteDataService() as! PNoteDataService).createDataTable(tableName: "list-note")
        (ApplicationAssembly.sharedInstance?.noteDataService() as! PNoteDataService).getAllNote(ref: noteRef).continue({ (task) -> Any? in
            if task.error == nil{
                let snapshot = task.result as! FIRDataSnapshot
                for item in snapshot.children{
                    
                    let snapshotValue = (item as! FIRDataSnapshot).value as! [String: AnyObject]
                    let noteItem = Note.init(key: "", title: snapshotValue["title"] as! String, content: snapshotValue["content"] as! String, isSync: snapshotValue["isSync"] as! Bool)
                    self.appDelegate.notes.append(noteItem)
                }
            }
            //update local database after sync all
            RealmManager.saveObjects(objs: self.appDelegate.notes)
            
            if(self.appDelegate.notes.count == 0){
                self.tblNotes.isHidden = true
            }
            else{
                self.tblNotes.isHidden = false;
                self.tblNotes.reloadData()
            }
            return nil
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createNewNote(_ sender: Any) {
        
        natigateToAddNote()
        
    }
    @IBAction func addNewNote(_ sender: Any) {
        natigateToAddNote()
    }
    
    func natigateToAddNote()
    {
        let addNoteViewController = AddNoteViewController(nibName: "AddNoteViewController", bundle: nil)
        self.navigationController?.pushViewController(addNoteViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierTblNotes, for: indexPath) as! NoteTableViewCell
        
        let noteItem = appDelegate.notes[indexPath.row]
        
        cell.lbTitle.text = noteItem.title
        cell.lbContent.text = noteItem.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.notes.count
    }
    
    
}
