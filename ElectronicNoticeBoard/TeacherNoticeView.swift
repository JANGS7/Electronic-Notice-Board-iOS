import SwiftUI

struct TeacherNoticeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showMenu = false

//    // Sample notice data
    @State var notices: [Notice] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // Top Blue Bar with Back Button
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        
                        Spacer()
                        
                        Text("Teacher Dashboard")
                            .font(.title2)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                showMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .navigationBarBackButtonHidden(true) // Hides default back button

                    // Notice List
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(notices, id: \.id) { notice in
                                NoticeRow(notice: notice)
                            }
                        }
                        .padding()
                    }
                    Spacer()

                    // Bottom Curved Navigation Bar
                    ZStack {
                        TeacherCurvedBottomShape()
                            .fill(Color.blue)
                            .frame(height: 120)
                            .overlay(
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                            )
                    }
                }

                // Drop-down menu
                if showMenu {
                    VStack {
                        Spacer()
                        MenuView()
                            .transition(.move(edge: .top))
                            .shadow(radius: 5)
                    }
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
                    .onTapGesture {
                        withAnimation {
                            showMenu = false
                        }
                    }
                }
            }
            .task {
                Task {
                    let urlString = Constants.baseUrl + "/notices/getnotices"
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

                        let decodedOBject = try JSONDecoder().decode([Notice].self, from: data)
                        
                        DispatchQueue.main.async {
                            self.notices = decodedOBject
                        }

                    } catch {
                       
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

// Notice Row View
struct NoticeRow: View {
    let notice: Notice

    var body: some View {
        HStack {
//            Image(notice.imageName)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 40, height: 40)
//                .clipShape(Circle())

            Text(notice.title)
                .font(.headline)
                .foregroundColor(.black)

            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

// Drop-down menu
struct MenuView: View {
    let menuItems = ["Library Screen", "Hall Screen", "DataCell Screen", "Admin Screen"]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(menuItems, id: \.self) { item in
                Button(action: {
                    print("\(item) selected")
                }) {
                    Text(item)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(8)
                }
            }
        }
        .frame(width: 200)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.top, 10)
        
    }
}

// Bottom curved shape
struct TeacherCurvedBottomShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.width, y: 0), control: CGPoint(x: rect.width / 2, y: 150))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}

// Notice Data Model
//struct Notice: Identifiable {
//    let id: UUID
//    let title: String
//    let imageName: String
//}

// Preview
#Preview {
    TeacherNoticeView()
}
