import SwiftUI


struct LoginPage1: View {
    @State private var username = ""
    @State private var password = ""
    @State private var loginState = false
    @State private var loginError = ""
    @State private var isAdmin = false
    @State private var isTeacher = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    CurvedTopShape()
                        .fill(Color.green)
                        .frame(height: 200)
                        .ignoresSafeArea()
                    Spacer()
                    CurvedBottomShape()
                        .fill(Color.green)
                        .frame(height: 100)
                        .ignoresSafeArea()
                }

                VStack {
                    Spacer().frame(height: 100)
                    
                    Image("biitLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .padding(.bottom, 20)
                        .offset(y: 20)

                    Text("Login Details")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.bottom, 20)

                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
                        .padding(.horizontal)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
                        .padding(.horizontal)
                        .padding(.top, 10)

                    if !loginError.isEmpty {
                        Text(loginError)
                            .foregroundColor(.red)
                            .padding(.top, 5)
                    }

                    Button(action: { loginUser() }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 5)
                    }
                    .padding(.top, 20)

                    Spacer()
                }
                .padding(.top, 40)

                NavigationLink(destination: destinationView, isActive: $loginState) { EmptyView() }
                    .opacity(0)
            }
            .background(Color.white.ignoresSafeArea())
            .ignoresSafeArea()
        }
    }

    private var destinationView: some View {
        print("Navigating: isAdmin = \(isAdmin), isTeacher = \(isTeacher)")
        if isAdmin {
            return AnyView(AdminView())
        } else if isTeacher {
            return AnyView(TeacherMainView())
        } else {
            return AnyView(AdminUploadingNotice())
        }
    }

    private func loginUser() {
        Task {
            let urlString = Constants.baseUrl + "/user/getusers"
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Accept")

            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code:", httpResponse.statusCode)
                }

                guard let jsonArray = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                    print("Invalid JSON format")
                    DispatchQueue.main.async { loginError = "Invalid response from server." }
                    return
                }

                print("Raw Data:", jsonArray)

                if let user = jsonArray.first(where: { $0["UserName"] as? String == username }) {
                    if user["Password"] as? String == password {
                        DispatchQueue.main.async {
                            if let role = user["UserRole"] as? String {
                                let trimmedRole = role.trimmingCharacters(in: .whitespacesAndNewlines)
                                print("User Role from API:", trimmedRole)
                                
                                switch trimmedRole {
                                case "Teacher":
                                    isTeacher = true
                                    isAdmin = false
                                case "Admin":
                                    isAdmin = true
                                    isTeacher = false
                                default:
                                    isAdmin = false
                                    isTeacher = false
                                }
                            }
                            loginState = true
                        }
                    } else {
                        DispatchQueue.main.async { loginError = "Incorrect password." }
                    }
                } else {
                    DispatchQueue.main.async { loginError = "Username not found." }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Network request failed: \(error)")
                    loginError = "Network error. Try again later."
                }
            }
        }
    }
}

struct CurvedTopShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height), control: CGPoint(x: rect.width / 2, y: rect.height - 100))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        return path
    }
}

struct CurvedBottomShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.width, y: 0), control: CGPoint(x: rect.width / 2, y: 100))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}

#Preview {
    LoginPage1()
}
