import Foundation

final class VitalRepository: VitalRepositoryProtocol {
    private let dataSource: DataSourceProtocol
    
    init(dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getVitals(patientId: String, completion: @escaping (Result<[Vital], Error>) -> Void) {
        dataSource.fetchVitals(patientId: patientId, completion: completion)
    }
    
    func addVital(_ vital: Vital, for patientId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // Not implemented for mock
        completion(.success(()))
    }
}
