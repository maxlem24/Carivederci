//
//  FamilleMenuView.swift
//  Carivederci
//
//  Created by Maxime on 14/02/2024.
//

import SwiftUI

struct FamilleMenuView: View {
    @Binding var skipFamille : Bool
    @State var errorText : String = ""
    var body: some View {
        NavigationView{
            GeometryReader{
                geometry in
                ZStack{
                    Color("Bordeaux").ignoresSafeArea()
                    VStack {
                        HStack{
                            Spacer()
                            Image("Logo").resizable().scaledToFit().frame(width: geometry.size.height*0.4, height: geometry.size.height*0.4).padding(.vertical,20)
                            Spacer()
                        }
                        Text(errorText).font(.callout).foregroundColor(.red).padding(5)
                        Text("Bonjour \(AppUser.shared.getUser()?.pseudo ?? "Error")").font(.title).bold().foregroundColor(Color("RoseBlanc")).padding(5)
                        NavigationLink(destination :
                                        FamilleView( newFamily : true)
                                       ,label: {
                                        Text("Créer une Famille").font(.title2).foregroundColor(Color("RoseBlanc")).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Taupe"))) .cornerRadius(10)
                                       }
                        )
                        NavigationLink(destination :
                                        FamilleView(newFamily : false)
                                       ,label: {
                                        Text("Rejoindre une famille").font(.title2).bold().foregroundColor(Color("RoseBlanc")).padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Taupe"))) .cornerRadius(10)
                                       }
                        )
                        Text("Accéder à l'application").font(.title2).foregroundColor(Color("RoseBlanc")).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(Rectangle().fill(Color("Taupe"))) .cornerRadius(10).onTapGesture {
                            skipFamille = true
                        }
                        Spacer()
                    }
                }
            }
        }
        .accentColor(Color("RoseBlanc"))
        .edgesIgnoringSafeArea([.top, .bottom])
        .task {
            await getFamille()
        }
    }
    func getFamille() async {
        guard let url = URL(string : hostName+"/getFamilleUser") else {
            errorText = "Une erreur est survenue, veuillez vous reconnecter"
            return
        }
        guard let token = Auth.shared.getAccessToken() else {
            errorText = "Une erreur est survenue, veuillez vous reconnecter"
            return
        }
        do{
            var request = URLRequest(url : url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            
            let (data,response) = try await URLSession.shared.data(for : request)
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 201 {
                if let decodedResponse = try? JSONDecoder().decode(Famille.self, from: data) {
                    await MainActor.run{
                        AppUser.shared.setFamille(famille: decodedResponse)
                    }
                }
            } else {
                if let decodedResponse = try? JSONDecoder().decode(Message.self, from: data) {
                    errorText = decodedResponse.message
                }
            }
        } catch {
            errorText = error.localizedDescription
        }
    }
}

