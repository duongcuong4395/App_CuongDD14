//
//  AuthView.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State private var imgBack:String = "Anything ImageName here"
    
    @State private var text:String = "Sign In"
    let SignInS = "Sign In"
    let SignUpS = "Sign Up"

    @State private var isSquareVisible = false
    @State private var count = 0
    @State var isSignInOrUp = true

    @State var email = ""
    @State var password = ""
    
    // ALERT
    @State var showAlert: Bool = false
    @State var showAlertView: Bool = false
    @State var alertTitel: String = ""
    @State var alertMessage: String = ""
    @State var errorMessage = ""

    @State var show: Bool = true
    
    @State var souldShowImagePicker: Bool = false
    @State var avatarImage: UIImage?
    
    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    VStack {
                        SignTextView()
                            .padding(.horizontal, 10)
                        if !isSignInOrUp {
                            AvatarView()
                        }
                        
                        TextfieldView(EPtype: $email, icon: "envelope.fill", text: "Email")
                        LineView()
                        TextfieldView(EPtype: $password, icon: "key.fill", text: "Password")

                        HStack {
                            Spacer()
                            Text("Resset password")
                                .bold()
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.horizontal, 30)
                                .onTapGesture {
                                    sentRessestPassword()
                                }
                        }
                        
                        SignInOrUpButtonView()
                        
                        HStack(spacing: 8) {
                            
                            Button(action: {
                                viewModel.loginGG()
                            }, label: {
                                CustomButtonSocialView(isGoogle: true)
                            })
                            
                        }
                        .padding(.leading, -60)
                        .frame(maxWidth: .infinity)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(30)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .stroke(.black, lineWidth: 3)
                    })
                    .padding(.horizontal, 15)
                    
                    
                                    }
                VStack(alignment: .leading) {
                    Spacer()
                    HStack {
                        ButtonSwitchSignView()
                            .padding(.horizontal, 15)
                        Spacer()
                    }
                    
                }
            }
        }
        .background{
            VStack(spacing: 0) {
                Image(imgBack)
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                Spacer()
                Image(imgBack)
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
            }
            
        }
        .alert(isPresented: $showAlertView, content: {
            Alert(title: Text(alertTitel), message: Text(alertMessage), dismissButton: .cancel())
        })
    }
    
    
    
}






// MARK: - Extension Views
extension AuthView {
    
    // MARK: - SignTextView
    @ViewBuilder
    func SignTextView() -> some View {
        HStack{
            Text(text)
                .bold()
                .font(.largeTitle)
                .foregroundColor(.black)
            if isSquareVisible {
                Rectangle()
                    .frame(width: 3, height: 30)
                    .foregroundColor(.black)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 55)
    }
    
    // MARK: - AvatarView
    @ViewBuilder
    func AvatarView() -> some View {
        HStack{
            Button(action: {
                souldShowImagePicker.toggle()
            }, label: {
                VStack {
                    if let image = self.avatarImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 127, height: 127)
                            .cornerRadius(64)
                    } else {
                        Image(systemName: "person.fill")
                            .font(.system(size: 64))
                            .padding()
                            .foregroundColor(Color(.label))
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 64)
                        .stroke(Color.black, lineWidth: 3)
                )
                
            })
        }
    }
    
    // MARK: - Line View
    @ViewBuilder
    func LineView() -> some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 2)
            .padding(.horizontal, 10)
            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .leading, endPoint: .trailing))
    }
    
    // MARK: - Sign In Or Up Button View
    @ViewBuilder
    func SignInOrUpButtonView() -> some View {
        Button(action: {
            signInOrUp()
        }, label: {
            Text(isSignInOrUp ? "Sign In" : "Create Account")
                .bold()
                .font(.title2)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(.black)
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 3, y: 4)
                .shadow(color: .black.opacity(0.2), radius: 4, x: -3, y: -4)
        })
    }
    
    // MARK: - Custom Button Social View
    @ViewBuilder
    func CustomButtonSocialView(isGoogle: Bool = false) -> some View {
        HStack {
            Group{
                if isGoogle {
                    Image("Google")
                        .resizable()
                        .renderingMode(.template)
                } else {
                    Image(systemName: "applelogo")
                        .resizable()
                }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .frame(height: 45)
            Text("\(isGoogle ? "Google" : "Apple") Sign In")
                .font(.callout)
                .lineLimit(1)
            
        }
        .foregroundColor(.white)
        .padding(.horizontal, 15)
        .background{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.black)
        }
    }
    
    // MARK: - Custom Button Social View
    @ViewBuilder
    func ButtonSwitchSignView() -> some View {
        Button(action: {
            withAnimation{
                email = ""
                password = ""
                keyAniamtion()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.typeText()
                }
            }
            isSignInOrUp.toggle()
            
        }, label: {
            HStack {
                Image("Hackingwithswift")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                Text(isSignInOrUp ? "Sign Up" : "Sign In")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.black)
            }
        })
    }
}

// MARK: - Extension Events
extension AuthView {
    func signInOrUp()  {
        if isSignInOrUp {
            loginUser()
        } else {
            createNewAccount()
        }
    }
    
    // MARK: - Login
    func loginUser() {
        viewModel.loginEmailAndPass(email: email, password: password)
    }
    
    // MARK: - SignUp
    func createNewAccount() {
        viewModel.signUp(email: email, password: password)
    }
    
    // MARK: - Reset Password
    func sentRessestPassword() {
        viewModel.sentRessestPassword(email: email)
    }
    
    // MARK: - Reset Password
    func keyAniamtion() {
        if count == 5 {
            count = 0
            isSquareVisible = false
            return
        }
        withAnimation(.easeInOut(duration: 0.5)) {
            self.isSquareVisible.toggle()
        }
        count += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.keyAniamtion()
        }
    }
    
    func typeText() {
        text = ""
        for character in isSignInOrUp ? SignInS : SignUpS {
            text += "\(character)"
            RunLoop.current.run(until: Date() + 0.15)
        }
    }
}

struct TextfieldView : View {
    @Binding var EPtype: String
    var icon = ""
    var text = ""
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 44, height: 44)
                .foregroundColor(Color.gray)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: .black.opacity(0.20), radius: 5, x: 0, y: 5)
                .padding(.horizontal)
            TextField(text, text: $EPtype)
                .colorScheme(.light)
                .foregroundColor(.black)
        }
        .frame(height: 50)
    }
}

