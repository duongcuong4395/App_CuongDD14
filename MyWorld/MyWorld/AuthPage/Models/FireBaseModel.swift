//
//  FireBaseModel.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import Foundation
import Firebase
//import FirebaseStorage
import UIKit

class FireBaseModel: NSObject{
    let auth: Auth
    //let storage: Storage
    
    static let shared = FireBaseModel()
    
    override init() {
        self.auth = Auth.auth()
        
        //self.storage = Storage.storage()
        super.init()
    }
}
