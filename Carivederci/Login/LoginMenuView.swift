//
//  LoginMenuView.swift
//  Carivederci
//
//  Created by Maxime on 12/02/2024.
//

import SwiftUI

struct LoginMenuView: View {
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
                        NavigationLink(destination :
                                        LoginView(newUser : true)
                                       ,label: {
                            Text("Inscription").font(.title2).foregroundColor(Color("RoseBlanc")).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(RoundedRectangle(cornerRadius: 10).fill(Color("Taupe")))
                        })
                        NavigationLink(destination :
                                        LoginView(newUser : false)
                                       ,label: {
                            Text("Connexion").font(.title2).foregroundColor(Color("RoseBlanc")).bold().padding().frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1).background(RoundedRectangle(cornerRadius: 10).fill(Color("Taupe")))
                        })
                        Spacer()
                    }
                }
            }
        }
        .accentColor(Color("RoseBlanc"))
        .edgesIgnoringSafeArea([.top, .bottom])
        .task{
            if Auth.shared.hasAccessToken() {
                    await getUser()
            }
        }
    }
    func getUser() async {
        guard let url = URL(string : hostName+"/current-user") else {
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
                if let decodedResponse = try? JSONDecoder().decode(UserResponse.self, from: data) {
                    await MainActor.run{
                        AppUser.shared.setUser(user: ResponseToApp(res: decodedResponse))
                    }
                    await getFamille()
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

