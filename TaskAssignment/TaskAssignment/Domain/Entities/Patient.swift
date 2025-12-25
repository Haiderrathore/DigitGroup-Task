import Foundation

struct Patient: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
    let gender: String
    let contactNumber: String?
    let email: String?
    let address: String?
    let bloodGroup: String
    let height: Double // in cm
    let weight: Double // in kg
    let allergies: [String]
    let profileImageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id, firstName, lastName, dateOfBirth, gender
        case contactNumber, email, address, bloodGroup
        case height, weight, allergies, profileImageUrl
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    var age: Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: Date())
        return ageComponents.year ?? 0
    }
    
    var heightWeightString: String {
        return "\(Int(height)) cm / \(Int(weight)) kg"
    }
    
    var allergiesString: String {
        return allergies.isEmpty ? "None" : allergies.joined(separator: ", ")
    }
}
