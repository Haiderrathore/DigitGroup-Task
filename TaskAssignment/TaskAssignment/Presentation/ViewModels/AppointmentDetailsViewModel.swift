import Foundation

protocol AppointmentDetailsViewModelDelegate: AnyObject {
    func appointmentDidLoad(_ appointment: Appointment)
    func loadingStateDidChange(isLoading: Bool)
    func didReceiveError(_ error: Error)
}

final class AppointmentDetailsViewModel {
    // MARK: - Properties
    private let appointmentId: String
    private let dataSource: DataSourceProtocol
    private weak var coordinator: AppointmentsCoordinator?
    weak var delegate: AppointmentDetailsViewModelDelegate?
    
    private(set) var appointment: Appointment?
    
    // MARK: - Initialization
    init(appointmentId: String, dataSource: DataSourceProtocol, coordinator: AppointmentsCoordinator) {
        self.appointmentId = appointmentId
        self.dataSource = dataSource
        self.coordinator = coordinator
    }
    
    // MARK: - Methods
    func loadAppointmentDetails() {
        delegate?.loadingStateDidChange(isLoading: true)
        
        dataSource.fetchAppointment(id: appointmentId) { [weak self] result in
            guard let self = self else { return }
            
            self.delegate?.loadingStateDidChange(isLoading: false)
            
            switch result {
            case .success(let appointment):
                self.appointment = appointment
                self.delegate?.appointmentDidLoad(appointment)
            case .failure(let error):
                self.delegate?.didReceiveError(error)
            }
        }
    }
}
