//
//  FireBaseBackendAPI.swift
//  MyWorld
//
//  Created by pc on 14/05/2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Runtime // https://github.com/wickwirew/Runtime.git


class FireBaseBackendAPI<T : Codable>: NSObject, Codable {
    
    // MARK: - Create/Add New repord
    public func save(_ obj: T, onCompletion: @escaping (Bool?) -> Void){
        var objData = obj
        let docIdStr = "doc_id"
        let typeNameStr = String(describing: type(of: obj.self))
        do {
            let info = try typeInfo(of: T.self)
            let docId = try info.property(named: docIdStr)
            if docId.name != "" {
                var ref: DocumentReference? = nil
                ref = Firestore.firestore().collection(typeNameStr).document()
                try info.property(named: docIdStr).set(value: ref?.documentID as Any, on: &objData)
                if let ref = ref {
                    do {
                        try Firestore.firestore().collection(typeNameStr).document(ref.documentID).setData(from: objData)
                        print("New upload document successfully saved \(ref)")
                        onCompletion(true)
                    } catch let error {
                        print (error)
                        onCompletion(false)
                    }
                }
            } else {
                print("Type missing mandatory property \(docIdStr)")
                onCompletion(false)
            }
        } catch let error {
            print(error)
        }
    }
    
    // MARK: - Get repords by ID
    public func get(docId: String, onCompletion: @escaping (T?) -> Void){
          let typeNameStr = String(describing: T.self)
          Firestore.firestore().collection(typeNameStr).whereField("doc_id", isEqualTo: docId).getDocuments() { (query, error) in
              if let error = error {
                  print(error)
              }
              if let query = query {
                  let doc = query.documents.first
                  let result = Result {
                      try doc.flatMap {
                          try $0.data(as: T.self)
                      }
                  }
                  switch  result {
                  case .success(let doc):
                      if let doc = doc {
                          onCompletion(doc)
                      } else {
                          onCompletion(nil)
                      }
                  default:
                     onCompletion(nil)
                  }
              }
          }
      }
    
    // MARK: - Get repords by Fields
    public func get(getByField: String, getByValue: String,onCompletion: @escaping ([T?]?, Error?) -> Void) {
      let typeNameStr = String(describing: T.self)
      var docs:[T] = []
      Firestore.firestore().collection(typeNameStr).whereField(getByField, isEqualTo: getByValue).getDocuments { query, error in
          if let error = error {
              onCompletion(nil, error)
          } else {
              for document in query!.documents {
                  print("\(document.documentID) => \(document.data())") // This line returns the snapshot documents correctly!
                  let doc = document as QueryDocumentSnapshot?
                  let result = Result {
                      try doc.flatMap {
                          try $0.data(as: T.self)
                      }
                  }
                  if let error = error {
                      print(error)
                  }
                  switch result {
                  case .success(let uploadDocument) :
                      if let uploadDocument = uploadDocument {
                          docs.append(uploadDocument)
                      } else {
                          
                      }
                  case .failure(let error):
                      print("Error decoding Document \(error)")
                      onCompletion(nil, error)
                  }
              }
              onCompletion(docs, nil)
          }
      }
    }

    // MARK: - Updade repord
    public func update(_ obj: T, onCompletion: @escaping (Bool?) -> Void) {
        let docIdName =  "doc_id"
        let typeNameStr = String(describing: T.self)
        do {
            let info = try typeInfo(of: T.self)
            let docId = try info.property(named: docIdName)
            if docId.name != "" {
                var ref: DocumentReference? = nil
                ref = Firestore.firestore().collection(typeNameStr).document()
                if let ref = ref {
                    do {
                        try Firestore.firestore().collection(typeNameStr).document(ref.documentID).setData(from: obj)
                        print("New upload document successfully saved \(ref)")
                        onCompletion(true)
                    } catch let error {
                        print("Type missing mandatory property \(docIdName) \(error)")
                        onCompletion(false)
                    }
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    // MARK: - Delete repord
    public func delete(docId: String, onCompletion: @escaping (Bool?) -> Void) {
        let typeNameStr = String(describing: T.self)
        Firestore.firestore().collection(typeNameStr).whereField("doc_id", isEqualTo: docId).getDocuments { query, err in
            if let err = err {
                print("Error deleting document: \(err)")
                onCompletion(false)
            } else {
                if let document = query!.documents.first {
                    document.reference.delete()
                    onCompletion(true)
                }
            }
        }
    }
}
