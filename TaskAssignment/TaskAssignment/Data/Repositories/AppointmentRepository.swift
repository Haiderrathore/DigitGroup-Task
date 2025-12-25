import Foundation

final class AppointmentRepository: AppointmentRepositoryProtocol {
    private let dataSource: DataSourceProtocol
    
    init(dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getAppointments(patientId: String, completion: @escaping (Result<[Appointment], Error>) -> Void) {
        dataSource.fetchAppointments(patientId: patientId, completion: completion)
    }
    
    func getAppointment(id: String, completion: @escaping (Result<Appointment, Error>) -> Void) {
        dataSource.fetchAppointment(id: id, completion: completion)
    }
    
    func updateAppointmentStatus(id: String, status: AppointmentStatus, completion: @escaping (Result<Void, Error>) -> Void) {
        // Not implemented for mock
        completion(.success(()))
    }
}
