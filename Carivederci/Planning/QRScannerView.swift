//
//  QRScannerView.swift
//  Carivederci
//
//  Created by Maxime on 02/04/2024.
//

import SwiftUI
import CodeScanner

struct QRScannerView: View {
    @Environment(\.dismiss) private var dismiss
    @State var errorText : String = ""
    @State var showMessage : Bool = false
    var resultScan : String = ""
    var body: some View {
        GeometryReader {
            geometry in
            ZStack{
                Color("BlancRosé").ignoresSafeArea()
                VStack{
                    CodeScannerView(codeTypes : [.qr], scanMode: .manual) { response in
                        if case let .success(result) = response {
                            Task {
                                await getPoints(token: result.string)
                            }
                        }else {
                            errorText = "Erreur : Impossible de charger le texte"
                        }
                    }
                    Text(errorText).font(.callout).foregroundColor(.red).padding(5)
                }.allowsHitTesting(!showMessage)
                if (showMessage) {
                    VStack {
                        Text("Les points ont été ajoutés").foregroundColor(Color("RoseBlanc")).padding(5)
                        Button{
                            dismiss()
                        }label :{
                            Text("Ok").bold().foregroundColor(Color("RoseBlanc")).padding(5)
                        }.scaledToFill()
                    }.padding().background(Rectangle().fill(Color("Taupe")).cornerRadius(10)).frame(width: geometry.size.width*0.9).padding(.horizontal,5).navigationBarBackButtonHidden(true)
                }
            }
        }
    }
    
    func getPoints(token scan : String) async {
        guard let getRequest = URLComponents(string: hostName+"/scan-qrcode/\(scan)") else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        
        
        guard let url = getRequest.url else {
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
            if httpResponse?.statusCode == 201 {
                if let decodedMessage = try? JSONDecoder().decode([Score].self, from: data) {
                    await MainActor.run{
                        AppUser.shared.setScore(score: decodedMessage[0].score)
                    }
                    showMessage = true
                }
            }else {
                if let decodedError = try? JSONDecoder().decode(Message.self, from: data) {
                    errorText = decodedError.message
                }
            }
        } catch {
            errorText = error.localizedDescription
        }
    }
}
