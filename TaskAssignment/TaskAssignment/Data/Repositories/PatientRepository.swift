import Foundation

final class PatientRepository: PatientRepositoryProtocol {
    private let dataSource: DataSourceProtocol
    
    init(dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getPatient(id: String, completion: @escaping (Result<Patient, Error>) -> Void) {
        dataSource.fetchPatient(id: id, completion: completion)
    }
    
    func updatePatient(_ patient: Patient, completion: @escaping (Result<Void, Error>) -> Void) {
        // Not implemented for mock
        completion(.success(()))
    }
}
