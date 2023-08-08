//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.titleApp
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessage()
        
    }
    
    private func loadMessage(){
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
            self.messages = []
            if let e = error {
                print("There was an issue retrieving data from data: \(e)")
            } else {
                if let snapshotDoc = querySnapshot?.documents {
                    for snap in snapshotDoc {
                        let data = snap.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                            let message = Message(sender: messageSender, body: messageBody)
                            self.messages.append(message)
                            // reloead table data
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]){ (error) in
                if let e = error {
                    print("save error: \(e)")
                }else{
                    print("save success")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logoutPress(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = self.messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.bodyLable.text = self.messages[indexPath.row].body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.youImageView.isHidden = true
            cell.avaImageView.isHidden = false
            cell.bubleView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.bodyLable.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            cell.youImageView.isHidden = false
            cell.avaImageView.isHidden = true
            cell.bubleView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.bodyLable.textColor = UIColor(named: K.BrandColors.purple)
        }
        
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
