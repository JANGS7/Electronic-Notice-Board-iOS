//
//  Adminnoticedetailsview.swift
//  ElectronicNoticeBoard
//
//  Created by Shahbaz Jang on 12/03/2025.
//

import SwiftUI

struct Adminnoticedetailsview: View {
    var body: some View {
           NavigationView {
               VStack {
                   // Green top bar
                   Rectangle()
                       .fill(Color.green)
                       .frame(height: 60)
                       .overlay(
                           Text("Admin")
                               .font(.title2)
                               .fontWeight(.bold)
                               .foregroundColor(.white)
                       )
                   
                   Image("Image 12-03-2025 at 7.34 PM") // Replace with your image name
                       .resizable()
                       .scaledToFit()
                       .frame(height: 200)
                       .cornerRadius(10)
                       .padding()
                   
                   Text("Title")
                       .font(.title2)
                       .fontWeight(.bold)
                       .padding(.top, 10)
                   
                   Text("Fire Alert")
                       .font(.title3)
                       .padding(.bottom, 5)
                   
                   Text("Attention all students, faculty, and staff,")
                       .font(.body)
                       .multilineTextAlignment(.center)
                       .padding(.horizontal)
                   
                   Text("There is currently a fire in University. Please remain calm.")
                       .font(.body)
                       .multilineTextAlignment(.center)
                       .padding()
                   
                   Button(action: {
                       // Add alert action here
                   }) {
                       Text("Send Alert")
                           .font(.headline)
                           .foregroundColor(.white)
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.green)
                           .cornerRadius(10)
                           .shadow(radius: 3)
                   }
                   .padding(.horizontal)
                   
                   Spacer()
                   
                   // Green bottom bar
                   ZStack {
                       Rectangle()
                           .fill(Color.green)
                           .frame(height: 80)
                           .cornerRadius(30)
                       
                       Image(systemName: "house.fill")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 30, height: 30)
                           .foregroundColor(.white)
                   }
               }
               .edgesIgnoringSafeArea(.bottom)
           }
       }
   }

#Preview {
    Adminnoticedetailsview()
}

