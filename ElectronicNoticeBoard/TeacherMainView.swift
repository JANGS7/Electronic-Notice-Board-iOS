//
//  TeacherMainView.swift
//  ElectronicNoticeBoard
//
//  Created by Shahbaz Jang on 30/03/2025.
//

import SwiftUI

struct TeacherMainView: View {
    @Environment(\.presentationMode) var presentationMode  // Enables view dismissal

    var body: some View {
        NavigationView {
            VStack {
                // Menu List
                List {
                    TeacherMenuItem(icon: "doc.text", title: "Upload Notice", subtitle: "Add a new notice", iconColor: .blue)
                    TeacherMenuItem(icon: "list.bullet", title: "Manage Notices", subtitle: "Edit or delete existing notices", iconColor: .blue)

                    // ✅ Navigation to TeacherNoticeView
                    NavigationLink(destination: TeacherNoticeView()) {
                        TeacherMenuItem(icon: "eye", title: "Current Notices", subtitle: "View all current notices", iconColor: .blue)
                    }

                    TeacherMenuItem(icon: "calendar", title: "Schedule Notices", subtitle: "Plan notices for later", iconColor: .blue)
                    TeacherMenuItem(icon: "person", title: "Profile", subtitle: "Manage your account", iconColor: .blue)
                }
                .listStyle(PlainListStyle())

                Spacer()

                // Floating Action Button (FAB) to Add Notices
                HStack {
                    Spacer()
                    Button(action: {
                        // Action for adding a new notice
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding()
                }
            }
            .navigationTitle("Teacher Dashboard")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // ✅ Back Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()  // Dismiss the view
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                        }
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
            .toolbarBackground(Color.blue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

// Custom Teacher Menu Item Component
struct TeacherMenuItem: View {
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
#Preview {
    TeacherMainView()
}
