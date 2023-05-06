//
//  AuthViewModel.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import Foundation
import Firebase

import GoogleSignIn
import SwiftUI
//import Alamofire
// https://blog.codemagic.io/google-sign-in-firebase-authentication-using-swift/
// https://www.youtube.com/watch?v=IzyOdKm0bWE

class AuthenticationViewModel: NSObject, ObservableObject {

    
    @Published var userLogin = UserSocial(id: "0", email: "", photoURL: nil, multiFactorString: "")
    @Published var isLoginSuccessed = false
      
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var state: SignInState = .signedOut

    override init() {
        super.init()
    }
    
    func CheckUserLoggedIn() {
        Auth.auth().addStateDidChangeListener{ auth, user in
            if user != nil {
                self.state = .signedIn
            } else
            {
                self.state = .signedOut
            }
        }
    }
    
    func loginGG() {
        signInWithGoogle();
        CheckUserLoggedIn();
        getUserLogin();
    }
    
    func getUserLogin() {
        let user = Auth.auth().currentUser
        if let user = user {
            // User is signed in.
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            
            userLogin.id = user.uid
            userLogin.email = user.email
            userLogin.photoURL = user.photoURL
            userLogin.multiFactorString = "MultiFactor: "
            
            print("User Infor:  \(userLogin.id) - \(String(describing: userLogin.email)) - \(userLogin.photoURL)")
            for info in user.multiFactor.enrolledFactors {
              userLogin.multiFactorString! += info.displayName ?? "[DispayName]"
              userLogin.multiFactorString! += " "
            }
            // ...
        } else {
            // No user is signed in.
            print("No user Login")
        }
    }

        
    // 5
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        do {
            try Auth.auth().signOut()

            state = .signedOut
        } catch let signOutError as NSError {
            print(signOutError.localizedDescription)
        }
    }
}


extension AuthenticationViewModel {
    
    
    
  func signInWithGoogle() {
    guard let clientID = FirebaseApp.app()?.options.clientID else {
      fatalError("No client ID found in Firebase configuration")
    }
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config
      
      GIDSignIn.sharedInstance.signIn(withPresenting: ApplicationUtility.rootViewController) { user, error in
          if let error = error {
              print(error.localizedDescription)
              return
          }
          
          guard
            let user = user?.user,
            let idToken = user.idToken else { return }
          
          let accessToken = user.accessToken
          let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                         accessToken: accessToken.tokenString)
          
          Auth.auth().signIn(with: credential) { res, error in
              if let error = error {
                  print(error.localizedDescription)
                  return
              }
              
              guard let user = res?.user else { return }
              print( user )
              
              self.userLogin.id = user.uid
              self.userLogin.email = user.email
              self.userLogin.photoURL = user.photoURL
              self.userLogin.multiFactorString = "MultiFactor: "
              
              print("User Infor:  \(self.userLogin.id) - \(String(describing: self.userLogin.email)) - \(self.userLogin.photoURL)")
          }
      }
  }
}
