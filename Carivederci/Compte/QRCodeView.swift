//
//  QRCodeView.swift
//  Carivederci
//
//  Created by Maxime on 17/03/2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let points: Int
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var image : Image? {
        return generateQRCode(from: String(points))
    }
    var body: some View {
        GeometryReader{
            geometry in
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                VStack{
                    if (image != nil ) {
                        image!.interpolation(.none).resizable().scaledToFit().overlay(Rectangle().stroke()).frame(width: geometry.size.width*0.9, height: geometry.size.width*0.9)
                        Text("\(points) points").font(.title3).foregroundColor(Color("AccentColor")).bold()
                    }else {
                        Text("Une erreur est survenue")
                    }
                }
            }
        }
        
        
    }
    func generateQRCode(from string : String) -> Image?  {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let image = context.createCGImage(outputImage, from: outputImage.extent) {
                return Image(uiImage: UIImage(cgImage: image))
            }
        }
        return nil
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView(points: 10)
    }
}
