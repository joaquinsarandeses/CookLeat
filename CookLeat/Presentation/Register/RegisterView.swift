//
//  RegisterView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 13/2/23.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @State var name: String = ""
    @State var password: String = ""
    @State var reppassword: String = ""
    @State var email: String = ""
    @State private var alert = false
    @State private var alertMessage = ""
    var body: some View {
        ZStack{
            bgc
            VStack {
                
                Image("logo")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 200.0, height: 150.0)
                    .padding(.top,100)
                
                TextField("Nombre de usuario", text: $name)
                    .customDesign()
                    .padding(.top,80)
                TextField("Correo electrónico", text: $email)
                    .customDesign()
                    .padding(.top,5)
                SecureField("Contraseña", text: $password)
                    .customDesign()
                    .padding(.top,5)
                SecureField("Repite tu contraseña", text: $reppassword)
                    .customDesign()
                    .padding(.top,5)
                    
                Button{
                        checkFields()
                }label: {
                    Text("Register")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color("BackBut"))
                        .cornerRadius(10)
                }.alert("Error", isPresented: $alert) {
                    Button {
                        
                    } label: {
                        Text("OK")
                    }
                    
                } message: {
                    Text(alertMessage)
                }
                .padding(.horizontal,30)
                    .padding(.top,30)
                    
                
                Text("¿Ya estás registrado?\(Text("Pulsa aquí.").underline())")
                    .foregroundColor(Color.white)
                    .padding(.top,60)
                    .padding(.bottom,50)
                
            }
            ZStack {
                NavigationLink(destination: CustomTab(), isActive: $viewModel.shouldShowHome) {
                    EmptyView()
                }
                .hidden()
            }
        }
        
    }
    var bgc: some View{
        
        Color("BackA")
            .ignoresSafeArea()
        
    }
    
    func checkFields(){
        if email.isEmpty || password.isEmpty || reppassword.isEmpty || name.isEmpty{
            alertMessage = "All fields must be filled."
            self.alert = true
        } else if password != reppassword {
            alertMessage = "Passwords don´t match."
            self.alert = true
        } else if password.count < 7{
            alertMessage = "Passwords must be at least 8 characters."
            self.alert = true
        } else {
            viewModel.register(name: name, email: email, password: password)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
    
    
    
}
