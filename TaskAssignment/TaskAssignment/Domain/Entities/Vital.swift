import Foundation
import UIKit

struct Vital: Codable {
    let id: String
    let patientId: String
    let type: VitalType
    let value: Double
    let secondaryValue: Double?
    let unit: String
    let status: VitalStatus
    let recordedAt: Date
    
    var displayValue: String {
        if let secondary = secondaryValue {
            return "\(Int(value))/\(Int(secondary))"
        }
        return type == .temperature ? String(format: "%.1f", value) : "\(Int(value))"
    }
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: recordedAt, relativeTo: Date())
    }
}

enum VitalType: String, Codable {
    case bloodPressure
    case heartRate
    case temperature
    case bloodOxygen
    case respiratoryRate
    case bloodGlucose
    
    var displayName: String {
        switch self {
        case .bloodPressure: return "Blood Pressure"
        case .heartRate: return "Heart Rate"
        case .temperature: return "Body Temp"
        case .bloodOxygen: return "Blood Oxygen"
        case .respiratoryRate: return "Respiratory Rate"
        case .bloodGlucose: return "Blood Glucose"
        }
    }
    
    var icon: UIImage? {
        let systemName: String
        switch self {
        case .heartRate: systemName = "heart.fill"
        case .bloodPressure: systemName = "waveform.path.ecg"
        case .temperature: systemName = "thermometer"
        case .bloodOxygen: systemName = "drop.fill"
        case .respiratoryRate: systemName = "wind"
        case .bloodGlucose: systemName = "scalemass.fill"
        }
        return UIImage(systemName: systemName)
    }
    
    var iconColor: UIColor {
        switch self {
        case .heartRate: return UIColor(red: 0.95, green: 0.26, blue: 0.42, alpha: 1.0)
        case .bloodPressure: return UIColor(red: 0.40, green: 0.52, blue: 0.98, alpha: 1.0)
        case .temperature: return UIColor(red: 0.95, green: 0.55, blue: 0.26, alpha: 1.0)
        case .bloodOxygen: return UIColor(red: 0.26, green: 0.70, blue: 0.95, alpha: 1.0)
        case .respiratoryRate: return UIColor(red: 0.60, green: 0.80, blue: 0.95, alpha: 1.0)
        case .bloodGlucose: return UIColor(red: 0.26, green: 0.85, blue: 0.70, alpha: 1.0)
        }
    }
}

enum VitalStatus: String, Codable {
    case normal
    case warning
    case critical
    
    var displayName: String {
        switch self {
        case .normal: return "Normal"
        case .warning: return "Warning"
        case .critical: return "Critical"
        }
    }
    
    var color: UIColor {
        switch self {
        case .normal: return UIColor(red: 0.30, green: 0.85, blue: 0.39, alpha: 1.0)
        case .warning: return UIColor(red: 1.0, green: 0.80, blue: 0.0, alpha: 1.0)
        case .critical: return UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
        }
    }
}
