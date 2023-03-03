//
//  AddPostView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI
import UIKit
import Photos

struct AddPostView: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @State var name: String = ""
    @State var description: String = ""
    let options = [("Carne", 1), ("Pescado", 2), ("Vegano", 3), ("Dulce", 4), ("Aperitivo", 5), ("Sopas", 6), ("Repostería", 7), ("Otros", 8)]
    @State var selectedOption = 1
    @State var showImagePicker = false
    @State var image: UIImage?
    @State var base64Image: String?
    
    
    var body: some View {
        ZStack{
            VStack (spacing: 20){
                navBar
            
                TextField("Buscar receta o categoría", text: $name)
                    .customDesign()
                    .shadow(radius: 2)
                
                VStack() {
                    TextEditor(text: $description)
                                    .frame(height: 250)
                                    .padding()
                                    .background(Color("BackTF"))
                                    .cornerRadius(15)
                                    .padding(.horizontal)
                                   
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: UIScreen.main.bounds.size.width-18, height: 32)
                            .foregroundColor(Color("BackBut"))
                        Picker(selection: $selectedOption, label: Text("Escoge una categoría:")) {
                            ForEach(options, id: \.0) { option in
                                Text(option.0)
                                    .tag(option.1)
                            }
                            .foregroundColor(.white)
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 100)
                        
                    }
                    .background(Color("BackPick"))
                    .cornerRadius(20)
                    .frame(width:UIScreen.main.bounds.size.width-18)
                    .padding(.top,20)
                    
                    HStack{
                        Button(action: {
                            self.showImagePicker = true
                        }) { if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .sheet(isPresented: $showImagePicker) {
                                            ImagePicker(image: self.$image, sourceType: .photoLibrary)
                                        }
                        } else {
                            Image("PostPic")
                                .foregroundColor(.red)
                                .frame(width: 150, height: 150)
                                .sheet(isPresented: $showImagePicker) {
                                            ImagePicker(image: self.$image, sourceType: .photoLibrary)
                                        }
                        }
                            
                        }
                        .background(Color("BackA"))
                        .cornerRadius(15)
                        .padding(.leading)
                        
                        Button{
                            if let image = image {
                                self.image = image
                                self.base64Image = convertImageToBase64(image: image)
                                viewModel.addPost(name: name, description: description, user: UserDefaults.standard.integer(forKey: "user_id") ?? 1, category: selectedOption, image: base64Image ?? "")
                                name=""
                                description=""
                                
                            }
                            
                            
                        }label: {
                            Text("Publicar")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(height: 110)
                                .frame(width: 110)
                                .frame(maxWidth: .infinity)
                                .background(Color("BackBut"))
                                .cornerRadius(10)
                                .padding(.trailing)
                        }
                        .frame(height: 100)
                    }
                    .padding(.top,20)
                }
                
                Spacer()
            }
        }
        
    }
    private  var navBar: some View {
        ZStack {
            Text("Crear Post")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            
            HStack()  {
                Image("logo")
                    .resizable()
                    .frame(width: 60, height: 45)
                    .padding(.leading, 10)
                Spacer()
            }
        }
        .frame(height: 50)
        .background(Color("BackB"))
    }
}

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView()
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    var sourceType: UIImagePickerController.SourceType

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
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

func convertImageToBase64(image: UIImage) -> String? {
    guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
    return imageData.base64EncodedString()
}
