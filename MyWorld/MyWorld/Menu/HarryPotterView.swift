//
//  HarryPotterView.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI

struct HarryPotterView: View {
    @StateObject var harryBookService = HarryBookService()
    var body: some View {
        HStack {
            Text("Hello, Harry Potter View!")
        }
        .onAppear{
            var harryBook = HarryBook(title: "Harry Potter and the Philosopher's Stone", image_url: "https://static.wikia.nocookie.net/harrypotter/images/7/7a/Harry_Potter_and_the_Philosopher%27s_Stone_%E2%80%93_Bloomsbury_2014_Children%27s_Edition_%28Paperback_and_Hardcover%29.jpg", artists: [], release_date: "1997-06-26T00:00:00.000Z")
            harryBookService.createBook(harryBook: harryBook)
        }
        
    }
}

struct HarryPotterView_Previews: PreviewProvider {
    static var previews: some View {
        HarryPotterView()
    }
}
