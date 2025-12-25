import Foundation

protocol DataSourceProtocol {
    func fetchPatient(id: String, completion: @escaping (Result<Patient, Error>) -> Void)
    func fetchVitals(patientId: String, completion: @escaping (Result<[Vital], Error>) -> Void)
    func fetchAppointments(patientId: String, completion: @escaping (Result<[Appointment], Error>) -> Void)
    func fetchAppointment(id: String, completion: @escaping (Result<Appointment, Error>) -> Void)
}

final class MockDataSource: DataSourceProtocol {
    
    // MARK: - Helper Methods
    private func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("❌ Failed to locate \(filename).json in bundle")
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("❌ Failed to load \(filename).json")
            return nil
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            print("❌ Failed to decode \(filename).json")
            return nil
        }
        
        return decoded
    }
    
    // MARK: - Completion Handler Methods
    func fetchPatient(id: String, completion: @escaping (Result<Patient, Error>) -> Void) {
        DispatchQueue.global().async {
            // Simulate network delay
            Thread.sleep(forTimeInterval: 0.5)
            
            if let patient = self.loadJSON(filename: "patient", type: Patient.self) {
                DispatchQueue.main.async {
                    completion(.success(patient))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "MockDataSource", code: 404, userInfo: [NSLocalizedDescriptionKey: "Patient not found"])))
                }
            }
        }
    }
    
    func fetchVitals(patientId: String, completion: @escaping (Result<[Vital], Error>) -> Void) {
        DispatchQueue.global().async {
            // Simulate network delay
            Thread.sleep(forTimeInterval: 0.5)
            
            if let vitals = self.loadJSON(filename: "vitals", type: [Vital].self) {
                DispatchQueue.main.async {
                    completion(.success(vitals))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "MockDataSource", code: 404, userInfo: [NSLocalizedDescriptionKey: "Vitals not found"])))
                }
            }
        }
    }
    
    func fetchAppointments(patientId: String, completion: @escaping (Result<[Appointment], Error>) -> Void) {
        DispatchQueue.global().async {
            // Simulate network delay
            Thread.sleep(forTimeInterval: 0.5)
            
            if let appointments = self.loadJSON(filename: "appointments", type: [Appointment].self) {
                DispatchQueue.main.async {
                    completion(.success(appointments))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "MockDataSource", code: 404, userInfo: [NSLocalizedDescriptionKey: "Appointments not found"])))
                }
            }
        }
    }
    
    func fetchAppointment(id: String, completion: @escaping (Result<Appointment, Error>) -> Void) {
        fetchAppointments(patientId: "") { result in
            switch result {
            case .success(let appointments):
                if let appointment = appointments.first(where: { $0.id == id }) {
                    completion(.success(appointment))
                } else {
                    completion(.failure(NSError(domain: "MockDataSource", code: 404, userInfo: [NSLocalizedDescriptionKey: "Appointment not found"])))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
