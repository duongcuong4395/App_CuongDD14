//
//  HarryBookService.swift
//  MyWorld
//
//  Created by pc on 14/05/2023.
//

import Foundation
import SwiftUI

//HarryPotterService
@MainActor class HarryBookService: ObservableObject {
    
    @Published var harryBooks : [HarryBook] = []
    @Published var harryBook = HarryBook(title: "", image_url: "", artists: [], release_date: "")
    
    //private let harryAPI : HarryAPI
    //private let bag = DisposeBag()
    
    init() {
        //self.harryAPI = harryAPI
    }
    
    func getBooks() {
        
    }
    
    func createBook(harryBook : HarryBook) {
        FireBaseBackendAPI<HarryBook>().save(harryBook) { response in
            print("Add Book")
            print(response as Any)
            if let response = response, response {
                print("Add Book")
                print(response)
                //self.msgLbl.text = "New Book object successfuly saved"
            } else {
                //self.msgLbl.text = "Unable to save Book object"
            }
        }
    }
}
