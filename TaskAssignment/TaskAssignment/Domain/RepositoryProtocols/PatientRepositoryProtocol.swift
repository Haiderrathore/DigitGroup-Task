import Foundation

protocol PatientRepositoryProtocol {
    func getPatient(id: String, completion: @escaping (Result<Patient, Error>) -> Void)
    func updatePatient(_ patient: Patient, completion: @escaping (Result<Void, Error>) -> Void)
}
