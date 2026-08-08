//
//  Notice.swift
//  ElectronicNoticeBoard
//
//  Created by Shahbaz Jang on 30/03/2025.
//

import Foundation

struct Notice: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let status: String
    let user: UserDto
    let schedule: Schedule?
    let days: [Days]
    let images: [Images]
    let screens: [String]

    enum CodingKeys: String, CodingKey {
        case id = "Notice_ID"
        case title = "Title"
        case description = "Description"
        case status = "Status"
        case user = "User"
        case schedule = "Schedule"
        case days = "Days"
        case images = "Images"
        case screens = "Screens"
    }
}

struct UserDto: Codable {
    let userName: String
    let userRole: String

    enum CodingKeys: String, CodingKey {
        case userName = "UserName"
        case userRole = "UserRole"
    }
}

struct Schedule: Codable {
    let startDate: String
    let endDate: String

    enum CodingKeys: String, CodingKey {
        case startDate = "StartDate"
        case endDate = "EndDate"
    }
}

struct Days: Codable {
    let day: String
    let starttime: String
    let endtime: String

    enum CodingKeys: String, CodingKey {
        case day = "Day"
        case starttime = "Starttime"
        case endtime = "Endtime"
    }
}

struct Images: Codable {
    let image: String

    enum CodingKeys: String, CodingKey {
        case image = "Image"
    }
}
