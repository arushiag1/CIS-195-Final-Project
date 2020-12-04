//
//  ConnectionsTableViewController.swift
//  NetworkingTracker
//
//  Created by Arushi Aggarwal on 12/2/20.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class ConnectionsTableViewController: UITableViewController, AddConnectionDelegate {
    func didCreate(_ connection: Connection) {
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Add(_ sender: Any) {
        performSegue(withIdentifier: "add", sender: sender)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return db.collection("users").document(uid).collection("connections")
        //return db.collection("users").get().then(snapshot => console.log(snapshot.size));
        //var count = 1
        var count = 0
        db.collection("users").document(uid).collection("connections").getDocuments
        {
            (snapshot, err) in

            if let err = err
            {
                print("Error getting documents: \(err)")
            }
            else
            {
                /*for _ in snapshot!.documents {
                    count += 1
                    print("COUNT : \(count)")
                    //print("\(document.documentID) => \(document.data())");
                }*/
                //count = snapshot?.documents.count ?? 0
                count = snapshot?.count ?? 0
                print("Count: \(count)")
            }
        }
        print("COUNT IS : \(count)")
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototype", for: indexPath)
        //let docRef =
        db.collection("users").document(uid).collection("connections").getDocuments {(snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                let firstName = snapshot?.documents[indexPath.row].data()["firstName"] as? String ?? nil
                cell.textLabel?.text = firstName
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            let vc = segue.destination as! UINavigationController
            let tc = vc.topViewController as! DetailViewController
            tc.delegate = self
        }
    }
    
}
