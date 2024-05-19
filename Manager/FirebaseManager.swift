//
//  FirebaseManager.swift
//  Messenger
//
//  Created by Shaquille McGregor on 19/05/2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class FirebaseManger: NSObject {
    let auth: Auth
    let storage: Storage
    let firebase: Firestore

    static let shared = FirebaseManger()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firebase = Firestore.firestore()
        
        super.init()
    }
}
