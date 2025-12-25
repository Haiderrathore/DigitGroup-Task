import Foundation

protocol PatientProfileViewModelDelegate: AnyObject {
    func patientDidLoad(_ patient: Patient)
    func loadingStateDidChange(isLoading: Bool)
    func didReceiveError(_ error: Error)
}

final class PatientProfileViewModel {
    // MARK: - Properties
    private let dataSource: DataSourceProtocol
    private weak var coordinator: PatientProfileCoordinator?
    weak var delegate: PatientProfileViewModelDelegate?
    
    private(set) var patient: Patient?
    
    // MARK: - Initialization
    init(dataSource: DataSourceProtocol, coordinator: PatientProfileCoordinator) {
        self.dataSource = dataSource
        self.coordinator = coordinator
    }
    
    // MARK: - Methods
    func loadPatient(patientId: String) {
        delegate?.loadingStateDidChange(isLoading: true)
        
        dataSource.fetchPatient(id: patientId) { [weak self] result in
            guard let self = self else { return }
            
            self.delegate?.loadingStateDidChange(isLoading: false)
            
            switch result {
            case .success(let patient):
                self.patient = patient
                self.delegate?.patientDidLoad(patient)
            case .failure(let error):
                self.delegate?.didReceiveError(error)
            }
        }
    }
}
