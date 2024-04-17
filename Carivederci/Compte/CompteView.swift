//
//  CompteView.swift
//  Carivederci
//
//  Created by Maxime on 28/02/2024.
//

import SwiftUI

struct CompteView: View {
    @State var points : String = ""
    @State var showMessage : Bool = false
    @State var errorText : String = ""
    var body: some View {
        GeometryReader {
            geometry in
            ZStack{
                Color("BlancRosé").ignoresSafeArea()
                VStack{
                    Text("Compte").font(.title).foregroundColor(Color("Marron")).padding()
                        .frame(width: geometry.size.width, height: geometry.size.height*0.1)
                        .background(Rectangle().fill(Color("RosePale")).cornerRadius(10))
                    NavigationView {
                        ZStack{
                            Color("BlancRosé").ignoresSafeArea()
                            VStack{
                                HStack{
                                    Spacer()
                                    Image("Logo").resizable().scaledToFit().frame(width: geometry.size.height*0.3, height: geometry.size.height*0.3)
                                    Spacer()
                                }
                                HStack{
                                    Spacer()
                                    Text(AppUser.shared.getUser()?.pseudo ?? "Error").bold().font(.title3)
                                        .foregroundColor(Color("Marron"))
                                    Spacer()
                                }
                                if (AppUser.shared.getFamille() != nil){
                                    HStack{
                                        Spacer()
                                        Text(AppUser.shared.getFamille()?.name ?? "Error").bold().font(.title3)
                                            .foregroundColor(Color("Marron"))
                                        Spacer()
                                    }
                                }
                                ScrollView{
                                    HStack{
                                        NavigationLink(destination: PasswordView()) { Label("Changer de mot de passe", systemImage: "lock.shield.fill")
                                                .font(.title3)
                                                .foregroundColor(Color("Marron"))
                                            Spacer()
                                        }
                                    }
                                    HStack{
                                        Text("Mes points : ")
                                            .font(.title3)
                                            .foregroundColor(Color("Marron"))
                                        Spacer()
                                        Text("\(AppUser.shared.getUser()?.score ?? -1) points")
                                            .font(.title3)
                                            .foregroundColor(Color("Marron"))
                                        
                                    }
                                    if(AppUser.shared.getFamille() != nil && !showMessage)
                                    {
                                        Button{
                                            showMessage = true
                                        }label :{
                                            Text("Quitter la Famille").font(.title3).bold()
                                                .foregroundColor(Color("RoseBlanc")).padding(5)
                                        }.frame(width: geometry.size.width*0.9)
                                            .background(Rectangle().fill(Color("Bordeaux")).cornerRadius(10))
                                    }
                                    if(AppUser.shared.getUser()?.isAdmin ?? false) {
                                        VStack{
                                            Text("Generer un QR-Code")
                                                .font(.title3)
                                                .foregroundColor(Color("Marron"))
                                            TextField("Nombre de points", text: $points)
                                                .keyboardType(.numberPad)
                                                .font(.title3)
                                                .foregroundColor(Color("Marron"))
                                                .padding(.horizontal,5)
                                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Marron")))
                                            NavigationLink(destination :
                                                            QRCodeView(points: .constant (Int(points) ?? 0))
                                            ){
                                                Text("Generer").font(.title3)
                                                    .foregroundColor(Color("BlancRosé"))
                                                    .padding(5)
                                                    .frame(width: geometry.size.width*0.9)
                                                    .background(RoundedRectangle(cornerRadius: 10)
                                                        .fill(Color("Bordeaux")))
                                            }
                                        }
                                    }
                                    
                                }.padding(.horizontal,15)
                                Spacer()
                                VStack{
                                    Text("L'association Carivederci est responsable du traitement des données nécessaires au fonctionnement de l'application")
                                        .font(.footnote)
                                        .foregroundColor(Color("Marron"))
                                    Link("Plus d'informations en cliquant ici", destination: URL(string: "https://carivederci.site/rgpd")!)
                                        .font(.footnote)
                                        .foregroundColor(Color("Marron"))
                                }
                            }
                        }
                    }.accentColor(Color("Marron"))
                        .allowsHitTesting(!showMessage)
                        .edgesIgnoringSafeArea([.top, .bottom])
                }
                if (showMessage) {
                    VStack(alignment : .leading) {
                        Text("Voulez vous vraiment abandonner votre famille ?")
                            .foregroundColor(Color("Marron")).padding(5)
                        Text("Vous allez être remis sur l'écran de selection des familles")
                            .foregroundColor(Color("Marron")).padding(5)
                        Text(errorText).font(.callout).foregroundColor(.red).padding(5)
                        HStack{
                            Spacer()
                            Button{
                                Task{
                                    await leave()
                                }
                            }label :{
                                Text("Oui").bold().foregroundColor(Color("Marron")).padding(5)
                            }.scaledToFill()
                            Button{
                                showMessage = false
                            }label :{
                                Text("Non").bold().foregroundColor(Color("Marron")).padding(5)
                            }.scaledToFill()
                            Spacer()
                        }
                    }.padding().background(Rectangle().fill(Color("Rose")).cornerRadius(10)).frame(width: geometry.size.width*0.9).navigationBarBackButtonHidden(showMessage).onAppear(){
                        errorText = ""
                    }
                }
            }
        }
    }
    func leave() async {
        guard let url = URL(string : hostName+"/leave") else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        guard let token = Auth.shared.getAccessToken() else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        do{
            var request = URLRequest(url : url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            
            let (data,response) = try await URLSession.shared.data(for : request)
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode != 201 {
                if let decodedResponse = try? JSONDecoder().decode(Message.self, from: data) {
                    errorText = decodedResponse.message
                }
            } else {
                showMessage = false
                await MainActor.run{
                    AppUser.shared.setFamille(famille: nil)
                }
            }
        } catch {
            errorText = error.localizedDescription
        }
    }
}





