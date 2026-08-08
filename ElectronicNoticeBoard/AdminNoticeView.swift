import SwiftUI

struct AdminRequestView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Request List
                List {
                    RequestItem(
                        title: "Naat And Qirat",
                        subtitle: "Requested by : Sir Saeed",
                        action: {
                            // Action for "Naat And Qirat"
                            print("Naat And Qirat tapped")
                        }
                    )
                    RequestItem(
                        title: "Happy Teacher Day",
                        subtitle: "Requested by : Sir Khaled",
                        action: {
                            // Action for "Happy Teacher Day"
                            print("Happy Teacher Day tapped")
                        }
                    )
                    RequestItem(
                        title: "New Admission",
                        subtitle: "Requested by : Sir Raheem",
                        action: {
                            // Action for "New Admission"
                            print("New Admission tapped")
                        }
                    )
                }
                .listStyle(PlainListStyle())
                
                // Footer with Home Icon
                ZStack {
                    Color.green
                        .frame(height: 100) // Footer height
                        .edgesIgnoringSafeArea(.bottom)
                    
                    Button(action: {
                        // Home button action
                        print("Home button tapped")
                    }) {
                        Image(systemName: "house")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationTitle("Notices")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white)
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct RequestItem: View {
    var title: String
    var subtitle: String
    var action: () -> Void // Action to perform on tap
    
    var body: some View {
        Button(action: {
            action() // Perform the action
        }) {
            HStack {
                Image(systemName: "person")
                    .font(.system(size: 24))
                    .foregroundColor(.green)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(PlainButtonStyle()) // Removes default button styling
    }
}

struct AdminRequestView_Previews: PreviewProvider {
    static var previews: some View {
        AdminRequestView()
    }
}
