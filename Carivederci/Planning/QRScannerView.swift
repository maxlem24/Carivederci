//
//  QRScannerView.swift
//  Carivederci
//
//  Created by Maxime on 02/04/2024.
//

import SwiftUI
import CodeScanner

struct QRScannerView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @State var errorText : String = ""
    var resultScan : String = ""
    var body: some View {
        GeometryReader {
            geometry in
            ZStack{
                Color("BlancRosé").ignoresSafeArea()
                VStack{
                    CodeScannerView(codeTypes : [.qr]) { response in
                        if case let .success(result) = response {
                            Task {
                                await getPoints(token: result.string)
                            }
                        }else {
                            errorText = "Erreur : Impossible de charger le texte"
                        }
                    }
                    Text(errorText).font(.callout).foregroundColor(.red).padding(5)
                }
            }
        }
    }
    
    func getPoints(token scan : String) async {
        guard var getRequest = URLComponents(string: hostName+"/scan-qrcode") else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        getRequest.queryItems = [
            URLQueryItem(name: "token", value: scan)
        ]
        
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
            request.setValue(token, forHTTPHeaderField: "authorization")
            let (data,response) = try await URLSession.shared.data(for : request)
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 201 {
                self.presentationMode.wrappedValue.dismiss()
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

struct QRScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRScannerView()
    }
}
