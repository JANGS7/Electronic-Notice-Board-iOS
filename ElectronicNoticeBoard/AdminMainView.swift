import SwiftUI

struct AdminView: View {
    @Environment(\.presentationMode) var presentationMode  // Enables back navigation

    var body: some View {
        VStack {
            // Menu List
            List {
                MenuItem(icon: "tv", title: "ADD Screen", subtitle: "Add New Screen", iconColor: .green)
                MenuItem(icon: "tv", title: "Screen Authorization", subtitle: "Authorize Screen to Users", iconColor: .green)
                MenuItem(icon: "tv", title: "Screen List", subtitle: "List of All the Screens", iconColor: .green)

                // ✅ Navigation to AdminRequestView
                NavigationLink(destination: AdminRequestView()) {
                    MenuItem(icon: "bell", title: "Current Notices", subtitle: "View all current Notices.", iconColor: .green)
                }

                MenuItem(icon: "tray", title: "Alerts", subtitle: "Manage your alerts and preferences.", iconColor: .green)
                MenuItem(icon: "calendar", title: "Scheduled", subtitle: "Notices Scheduled for later.", iconColor: .green)
            }
            .listStyle(PlainListStyle())

            Spacer()

            // Floating Action Button (FAB) for Upload
            HStack {
                Spacer()
                NavigationLink(destination: AdminUploadingNotice()) {
                    Image(systemName: "plus")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding()
            }
        }
        .navigationTitle("Dashboard")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)  // ✅ Hides extra back buttons
        .toolbar {
            // ✅ Single Back Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()  // ✅ Dismiss view
                }) {
                    Image(systemName: "arrow.left")  // ✅ Only one back button
                        .foregroundColor(.black)
                }
            }

            // ✅ Notification Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Notification action
                }) {
                    Image(systemName: "bell")
                        .foregroundColor(.black)
                }
            }
        }
        .background(Color.white)
        .toolbarBackground(Color.green, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

// Custom Menu Item Component
struct MenuItem: View {
    var icon: String
    var title: String
    var subtitle: String
    var iconColor: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(iconColor)
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
}

// Preview
struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {  // ✅ Wrap in NavigationView ONLY for preview
            AdminView()
        }
    }
}
