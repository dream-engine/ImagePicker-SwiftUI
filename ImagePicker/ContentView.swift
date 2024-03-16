//
//  ContentView.swift
//  ImagePicker
//
//  Created by Mohit Kumar Singh on 16/03/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var selectedImage: UIImage?
    @State var showPicker: Bool = false
    @State var showActionSheet: Bool = false
    @State var isSourceCamera: Bool = true
    
    var body: some View {
        ZStack {
            Color.black
            Button {
                self.showActionSheet = true
            } label: {
                imageView()
            }
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showPicker, content: {
            ImagePickerSwiftUI(
              selectedImage: $selectedImage,
              sourceType: self.isSourceCamera ? .camera : .photoLibrary, // or .photoLibrary
              allowsEditing: true
            )
            .presentationBackground(Color.black)
        })
        .confirmationDialog("Select Source", isPresented: self.$showActionSheet) {
            Button("Camera") {
                self.isSourceCamera = true
                self.showPicker = true
            }
            
            Button("Photos") {
                self.isSourceCamera = false
                self.showPicker = true
            }
        }
    }
    
    // MARK: Image View
    @ViewBuilder
    func imageView() -> some View {
        ZStack {
            if let image = self.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(50)
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.gray)
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
            }
        }
        .frame(width: 100, height: 100)
    }
}

#Preview {
    ContentView()
}
