import Foundation

protocol VitalRepositoryProtocol {
    func getVitals(patientId: String, completion: @escaping (Result<[Vital], Error>) -> Void)
    func addVital(_ vital: Vital, for patientId: String, completion: @escaping (Result<Void, Error>) -> Void)
}
