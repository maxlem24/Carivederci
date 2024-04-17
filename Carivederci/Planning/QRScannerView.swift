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
                if let decodedError = try? JSONDecoder().decode([Score].self, from: data) {
                    AppUser.shared.user?.score = decodedError[0].score
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
