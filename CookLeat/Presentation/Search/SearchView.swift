//
//  SearchView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI

struct SearchView: View {
    let options = ["Recetas", "Categorías"]
    @State var selectedOption = 0
    @ObservedObject var viewModel = ViewModel()
    @State var search: String = ""
    @State var showCat: Bool = true
    
    var filteredRecipes: [AllPresentationModel] {
        if selectedOption == 0 {
            return viewModel.all.filter { $0.name.localizedCaseInsensitiveContains(search) }
        } else {
            return viewModel.all.filter { $0.category.localizedCaseInsensitiveContains(search) }
        }
    }
    
    var body: some View {
        NavigationView {
            
            ZStack {
                VStack(spacing: 20) {
                    navBar
                    
                    TextField("Buscar receta o categoría", text: $search)
                        .customDesign()
                        .shadow(radius: 2)
                    
                    Picker(selection: $selectedOption, label: Text("Escoge una categoría:")) {
                        ForEach(0..<options.count) { index in
                            Text(self.options[index]).tag(index)
                        }
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                        
                              
                    //MARK: aquí tenemos la tabla donde aparece todo lo que busquemos
                    ScrollView(.vertical){
                        
                        LazyVStack {
                            ForEach(filteredRecipes, id: \.id) { recipe in
                                NavigationLink(destination: PostView(viewModel: .init(allSearch: recipe))) {
                                    item(recipe)
                                }
                            }
                            
                        }
                        .shadow(radius: 2)
                    }
                    .padding(10)
                }
            }
            .onAppear(){
                viewModel.getAll()
            }
        }
    }
    private  var navBar: some View {
         ZStack {
             Text("Buscador")
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


private func item(_ all: AllPresentationModel) -> some View {
    HStack {
        if let imageUrlString = all.image as? String,
           let imageUrl = URL(string: imageUrlString) {
            RemoteImage(imageUrl: imageUrl)
                .frame(width: 90, height: 90)
        } else {
            Image("food")
                .foregroundColor(.red)
                .frame(width: 90, height: 90)
        }
        
        Spacer()
        VStack  {
            Text(all.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color("TextY"))
                .lineLimit(1)
            Text(all.user)
                .font(.subheadline)
                .foregroundColor(Color.black)
            Text(all.category)
                .foregroundColor(Color.white)
                .frame(width: 65, height: 25)
                .background(.gray)
                .cornerRadius(10)
                .foregroundColor(Color.black)
            
        }
        
        Spacer()
        
        if let imageUrlString = all.userPic as? String,
           let imageUrl = URL(string: imageUrlString) {
            RemoteImage(imageUrl: imageUrl)
                .frame(width: 90, height: 90)
        } else {
            Image("food")
                .foregroundColor(.red)
                .frame(width: 90, height: 90)
        }
        
    }
    .background(.white)
    .cornerRadius(15)
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
