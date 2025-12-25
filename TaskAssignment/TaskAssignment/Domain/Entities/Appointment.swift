import Foundation
import UIKit

struct Appointment: Codable {
    let id: String
    let patientId: String
    let doctorName: String
    let specialty: String
    let dateTime: Date
    let duration: TimeInterval
    let status: AppointmentStatus
    let reason: String
    let notes: String?
    let location: String
    let roomNumber: String?
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM dd, yyyy"
        return formatter.string(from: dateTime)
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: dateTime)
    }
    
    var formattedDateTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy • h:mm a"
        return formatter.string(from: dateTime)
    }
    
    var fullLocation: String {
        if let room = roomNumber {
            return "\(location)\n\(room)"
        }
        return location
    }
    
    var isUpcoming: Bool {
        return dateTime > Date()
    }
}

enum AppointmentStatus: String, Codable {
    case scheduled
    case confirmed
    case inProgress
    case completed
    case cancelled
    
    var displayName: String {
        switch self {
        case .scheduled: return "PENDING"
        case .confirmed: return "CONFIRMED"
        case .inProgress: return "IN PROGRESS"
        case .completed: return "COMPLETED"
        case .cancelled: return "CANCELLED"
        }
    }
    
    var color: UIColor {
        switch self {
        case .scheduled: return UIColor(red: 1.0, green: 0.60, blue: 0.0, alpha: 1.0)
        case .confirmed: return UIColor(red: 0.30, green: 0.85, blue: 0.39, alpha: 1.0)
        case .inProgress: return AppTheme.Colors.primaryBlue
        case .completed: return AppTheme.Colors.textSecondary
        case .cancelled: return UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
        }
    }
}
