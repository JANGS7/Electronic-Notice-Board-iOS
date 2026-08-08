//
//  LoginPage.swift
//  ElectronicNoticeBoard
//
//  Created by Shahbaz Jang on 14/11/2024.
//

import SwiftUI

struct LoginPage: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showEmailError = false
    
    var body: some View {
        ZStack {
            // Background with wave shape
            VStack {
                Spacer()
                WaveShape()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.5)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 200)
                    .offset(y: 50) // Adjust as needed
            }
            .ignoresSafeArea()
            
            // Login Form
            VStack {
                Spacer()
                
                // Illustration Image at the top
                Image("biitLogo") // Ensure "biitLogo" matches exactly with the name in Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 20)
                
                // Login Title
                Text("Login Details")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                
                // Email Field
                VStack(alignment: .leading, spacing: 5) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
                        .onChange(of: email) {
                            showEmailError = !isValidEmail(email)
                        }
                    
                    if showEmailError {
                        Text("Please enter valid email!")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .padding(.horizontal)
                
                // Password Field
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                // Forgot Password Button
                HStack {
                    Spacer()
                    Button("Forgot Password?") {
                        // Action for forgot password
                    }
                    .foregroundColor(.blue)
                    .font(.caption)
                    .padding(.trailing, 20)
                    .padding(.top, 10)
                }
                
                // Login Button
                Button(action: {
                    // Action for login
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                
                // OR Divider
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    Text("Or Sign up With")
                        .foregroundColor(.gray)
                        .font(.caption)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
                
                // Social Media Icons
                HStack(spacing: 30) {
                    Image("google-icon") // Replace with actual Google icon asset
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image("facebook-icon") // Replace with actual Facebook icon asset
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image("apple-icon") // Replace with actual Apple icon asset
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(.top, 10)
                
                Spacer()
                
            }
            .padding(.top, 40)
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

// Custom Wave Shape
struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height * 0.3))
        path.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height * 0.3),
                          control: CGPoint(x: rect.width * 0.5, y: rect.height * 0.6))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}



#Preview {
    LoginPage()
}
