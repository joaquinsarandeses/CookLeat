//
//  ProfileView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ViewModel()
    // @State var user: [viewModel.UserPresentationModel] = []
    @State var image: UIImage?
    @State private var showImagePicker = false
    @State private var showSettings = false
    @State var base64Image: String?
    @Environment (\.presentationMode) var mode: Binding<PresentationMode>
    var onDismiss: () -> ()
    
    struct myEvents: Identifiable {
        let id = UUID()
        let image: Image
        let title: String
        let subtitle: String
        let examp: Image
        let cat: String
    }
    
    var body: some View {
        
        ZStack{
            
            VStack{
                navBar
                Spacer()
                Spacer()
                
                HStack{
                    if let imageUrlString = viewModel.profile.image as? String,
                       let imageUrl = URL(string: imageUrlString) {
                        RemoteImage(imageUrl: imageUrl)
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                            .padding(.trailing,20)
                    } else {
                        Image("ProfilePic")
                            .foregroundColor(.red)
                            .frame(width: 60, height: 60)
                            .padding(.trailing,20)
                    }

                    VStack{
                        Text(viewModel.profile.name)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                            .padding(.trailing,70)
                            .foregroundColor(Color("BackBut"))
                            .padding(.bottom,5)
                        
                        HStack{
                            NavigationLink(destination: FollowersView()) {
                                VStack{
                                    Text("\(viewModel.profile.followers)")
                                        .fontWeight(.bold)
                                        .font(.system(size: 30))
                                    Text("Seguidores")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("BackBut"))
                                    
                                }
                            }
                            .foregroundColor(Color.black)
                            .padding(.trailing,40)
                            NavigationLink(destination: FollowedView()) {
                                VStack{
                                    Text("\(viewModel.profile.follows)")
                                        .fontWeight(.bold)
                                        .font(.system(size: 30))
                                    Text("Seguidos")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("BackBut"))
                                }
                            }
                            .foregroundColor(Color.black)
                            .padding(.trailing,20)
                        }
                    }
                    
                }
                Spacer()
                
                ScrollView(.vertical){
                    //MARK: Posts
                    LazyVStack {
                        ForEach(viewModel.myEvents, id: \.id) { event in
                            NavigationLink(destination: PostView(viewModel: .init(event: event))) {
                                userItem(event)
                                    .background(.white)
                                    .cornerRadius(15)
                                    .padding(10)
                            }
                        }
                    }
                    .shadow(radius: 2)
                }
                .padding(10)
                
            }
            //MARK: Botón de ajustes
            if showSettings {
                Color.gray
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        VStack {
                            Text("Escoge que hacer")
                            HStack{
                                VStack{
                                    Button(action: {
                                        self.showImagePicker = true
                                        
                                    }) { if let image = image {
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: 90, height: 50)
                                            .sheet(isPresented: $showImagePicker) {
                                                ImagePicker(image:$image, sourceType: .photoLibrary)
                                            }
                                    } else {
                                        Text("Cambiar imagen")
                                            .foregroundColor(.white)
                                            .sheet(isPresented: $showImagePicker) {
                                                ImagePicker(image: $image, sourceType: .photoLibrary)
                                            }
                                    }
                                        
                                    }
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .frame(height: 100)
                                    Button("Guardar") {
                                        if let image = image {
                                            self.image = image
                                            self.base64Image = convertImageToBase64(image: image)
                                            viewModel.changePic(id: UserDefaults.standard.integer(forKey: "user_id") , image: base64Image ?? "")
                                            showSettings = false
                                        }
                                    }
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .frame(width: 150, height: 50)
                                }
                                VStack{
                                    Button("Cerrar") {
                                        showSettings = false
                                    }
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .frame(height: 100)
                                    
                                    Button("Cerrar Sesión") {
                                        mode.wrappedValue.dismiss()
                                        self.onDismiss()
                                    }
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .frame(height: 100)
                                    .frame(width: 100)
                                    
                                }
                                
                            }
                        }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                        
                    )
            }
        }
        
        .onAppear {
            viewModel.getProfileData()
            viewModel.getMyEvents()
            
        }
        
    }
    //MARK: Navbar
    private  var navBar: some View {
        //MARK: TopBar
        VStack{
            ZStack {
                Text("Profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                HStack()  {
                    Image("logo")
                        .resizable()
                        .frame(width: 60, height: 45)
                        .padding(.leading, 10)
                    Spacer()
                    
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing,10)
                }
            }
            .frame(height: 50)
            .background(Color("BackB"))
            
            
            
        }
    }
    
    
}

private func userItem (_ event: MyEventsPresentationModel) -> some View{
    HStack {
        if let imageUrlString = event.image as? String,
           let imageUrl = URL(string: imageUrlString) {
            RemoteImage(imageUrl: imageUrl)
                .frame(width: 90, height: 90)
                .scaledToFill()
        } else {
            Image("food")
                .foregroundColor(.red)
                .frame(width: 90, height: 90)
        }
        Spacer()
        
        VStack() {
            Text(event.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("TextY"))
                .lineLimit(1)
            Text(event.description)
                .font(.subheadline)
                .foregroundColor(Color.black)
            Text(event.category)
                .foregroundColor(Color.white)
                .frame(width: 60, height: 20)
                .background(.gray)
                .cornerRadius(10)
                .padding(.bottom, 10)
        }
        Spacer()

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(onDismiss: {})
    }
}

//MARK: profilePicker(foto)
struct ProfilePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ProfilePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ProfilePicker>) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ProfilePicker
        
        init(_ parent: ProfilePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

