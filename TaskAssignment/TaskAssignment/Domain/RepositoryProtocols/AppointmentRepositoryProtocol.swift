import Foundation

protocol AppointmentRepositoryProtocol {
    func getAppointments(patientId: String, completion: @escaping (Result<[Appointment], Error>) -> Void)
    func getAppointment(id: String, completion: @escaping (Result<Appointment, Error>) -> Void)
    func updateAppointmentStatus(id: String, status: AppointmentStatus, completion: @escaping (Result<Void, Error>) -> Void)
}
