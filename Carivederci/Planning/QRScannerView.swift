//
//  QRScannerView.swift
//  Carivederci
//
//  Created by Maxime on 02/04/2024.
//

import SwiftUI

struct QRScannerView: View {
    @EnvironmentObject var appUser : AppUser
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    var body: some View {
        GeometryReader {
            geometry in
            ZStack{
                Color("BlancRosé").ignoresSafeArea()
                VStack{
                    /*CodeScannerView(codeTypes : [.qr]) { response in
                        if case let .success(result) = response {
                            await getPoints(token: result.string)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }*/
                }
            }
        }
    }
    /*
    func getPoints(token : String) async {
        guard let url = URL(string : hostName+"/scan-qrcode")else {
            return
        }
        do{
            var request = URLRequest(url : url)
            request.setValue(token, forHTTPHeaderField: "Authorization")
            let (data,_) = try URLSession.shared.data(with : request)
            if let decodedResponse = try? JSONDecoder().decode(Points.self, from: data) {
                appUser.user?.score += decodedResponse.points
            }
        } catch {
            
        }
    }
    */
}

struct QRScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRScannerView()
    }
}
