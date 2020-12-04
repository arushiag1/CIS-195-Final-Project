//
//  DetailViewController.swift
//  NetworkingTracker
//
//  Created by Arushi Aggarwal on 12/3/20.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

protocol AddConnectionDelegate: class {
    func didCreate(_ connection: Connection)
}

class DetailViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    weak var delegate: AddConnectionDelegate?
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var role: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Done(_ sender: Any) {
        let newConnection: Connection? = createNewConnection()
        if newConnection != nil {
            self.delegate?.didCreate(newConnection!)
            
            let db = Firestore.firestore()
            let uid = Auth.auth().currentUser!.uid
            
            db.collection("users").document(uid).collection("connections").addDocument(data: [
                "firstName": newConnection!.firstName,
                "lastName": newConnection!.lastName,
                "company": newConnection!.company!,
                "role": newConnection!.role!,
                "email": newConnection!.email!,
                "phoneNumber": newConnection!.phoneNumber!
            ]) { err in
                if let err = err {
                    print("Error adding connection: \(err)")
                } else {
                    print("Connection successfully added!")
                }
            }
        }
    }
    
    func createNewConnection() -> Connection? {
        let connection: Connection? = Connection(firstName: firstName.text!, lastName: lastName.text!, company: company.text ?? "", role: role.text ?? "", email: email.text ?? "", phoneNumber: phoneNumber.text ?? "") ?? nil
        
        return connection
    }
    
}
