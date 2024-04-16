//
//  QRCodeView.swift
//  Carivederci
//
//  Created by Maxime on 17/03/2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


struct QRCodeView: View {
    @Binding var points : Int
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State var image : Image?
    @State var errorText : String = ""
    var body: some View {
        GeometryReader{
            geometry in
            ZStack {
                Color("BlancRosé").ignoresSafeArea()
                VStack{
                    if (image != nil ) {
                        image!.resizable().scaledToFit().overlay(Rectangle().stroke(Color("Marron"))).frame(width: geometry.size.width*0.9, height: geometry.size.width*0.9)
                        Text("\(points) points").font(.title3).foregroundColor(Color("Marron")).bold()
                    }
                    Text(errorText).font(.callout).foregroundColor(.red).padding(5)
                }
            }.task{
                    await getQRCode()
            }
        }
    }
    func getQRCode() async {
        guard let url = URL(string : hostName+"/generate")else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        guard let token = Auth.shared.getAccessToken() else {
            errorText = "Une erreur est survenue, veuillez réessayer"
            return
        }
        do{
            guard let encoded = try? JSONEncoder().encode(Score(score: points)) else {
                errorText = "Une erreur est survenue, veuillez réessayer"
                return
            }
            var request = URLRequest(url : url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let (data,response) = try await URLSession.shared.upload(for : request, from: encoded)
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 201 {
                if let decodedResponse = try? JSONDecoder().decode(QrCode.self, from: data) {
                    filter.message = Data(decodedResponse.qrToken.utf8)
                    if let outputImage = filter.outputImage , let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                        image = Image(uiImage: UIImage(cgImage: cgImage))
                    }
                }
            }else {
                if let decodedError = try? JSONDecoder().decode(Message.self, from: data) {
                    errorText = decodedError.message
                    return
                }
            }
        } catch {
            errorText = error.localizedDescription
        }
    }
}
