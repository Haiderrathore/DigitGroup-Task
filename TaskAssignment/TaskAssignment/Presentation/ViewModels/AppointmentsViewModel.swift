import Foundation

enum AppointmentFilter {
    case upcoming
    case past
}

protocol AppointmentsViewModelDelegate: AnyObject {
    func appointmentsDidUpdate()
    func loadingStateDidChange(isLoading: Bool)
    func didReceiveError(_ error: Error)
}

final class AppointmentsViewModel {
    // MARK: - Properties
    private let dataSource: DataSourceProtocol
    private weak var coordinator: AppointmentsCoordinator?
    weak var delegate: AppointmentsViewModelDelegate?
    
    private var allAppointments: [Appointment] = []
    private(set) var filteredAppointments: [Appointment] = []
    private(set) var selectedFilter: AppointmentFilter = .upcoming
    
    // MARK: - Initialization
    init(dataSource: DataSourceProtocol, coordinator: AppointmentsCoordinator) {
        self.dataSource = dataSource
        self.coordinator = coordinator
    }
    
    // MARK: - Methods
    func loadAppointments(patientId: String) {
        delegate?.loadingStateDidChange(isLoading: true)
        
        dataSource.fetchAppointments(patientId: patientId) { [weak self] result in
            guard let self = self else { return }
            
            self.delegate?.loadingStateDidChange(isLoading: false)
            
            switch result {
            case .success(let appointments):
                self.allAppointments = appointments
                self.applyFilter()
            case .failure(let error):
                self.delegate?.didReceiveError(error)
            }
        }
    }
    
    func setFilter(_ filter: AppointmentFilter) {
        selectedFilter = filter
        applyFilter()
    }
    
    private func applyFilter() {
        let now = Date()
        
        switch selectedFilter {
        case .upcoming:
            filteredAppointments = allAppointments
                .filter { $0.dateTime > now }
                .sorted { $0.dateTime < $1.dateTime }
        case .past:
            filteredAppointments = allAppointments
                .filter { $0.dateTime <= now }
                .sorted { $0.dateTime > $1.dateTime }
        }
        
        delegate?.appointmentsDidUpdate()
    }
    
    func didSelectAppointment(_ appointment: Appointment) {
        coordinator?.showAppointmentDetails(appointment: appointment)
    }
}
