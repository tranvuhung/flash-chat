//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let messages = [
        Message(title: "Hey", body: "Hello there!"),
        Message(title: "Hey Hello", body: "Hello there 1!"),
        Message(title: "Alo", body: "Hello there 2!"),
        Message(title: "Ciaos", body: "Hello there 3!")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.titleApp
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.bodyLable.text = self.messages[indexPath.row].body

        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
