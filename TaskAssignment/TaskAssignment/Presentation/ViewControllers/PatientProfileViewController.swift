import UIKit

final class PatientProfileViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: PatientProfileViewModel
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = AppTheme.Colors.cardBackground
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = AppTheme.Colors.primaryBlue.cgColor
        imageView.layer.cornerRadius = 60 // Half of 120
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.bold(size: 28)
        label.textColor = AppTheme.Colors.textPrimary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageGenderLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.regular(size: 16)
        label.textColor = AppTheme.Colors.textSecondary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bloodGroupCard = ProfileInfoCardView()
    private let heightWeightCard = ProfileInfoCardView()
    private let allergiesCard = ProfileInfoCardView()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = AppTheme.Spacing.medium
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = AppTheme.Colors.primaryBlue
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Initialization
    init(viewModel: PatientProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.loadPatient(patientId: "patient_001")
    }
    
    // MARK: - Setup
    private func setupUI() {
        navigationItem.title = "Profile"
        view.backgroundColor = AppTheme.Colors.background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageGenderLabel)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(bloodGroupCard)
        stackView.addArrangedSubview(heightWeightCard)
        stackView.addArrangedSubview(allergiesCard)
        
        view.addSubview(loadingIndicator)
        
        bloodGroupCard.translatesAutoresizingMaskIntoConstraints = false
        heightWeightCard.translatesAutoresizingMaskIntoConstraints = false
        allergiesCard.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppTheme.Spacing.extraLarge),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: AppTheme.Spacing.medium),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppTheme.Spacing.medium),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppTheme.Spacing.medium),
            
            ageGenderLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: AppTheme.Spacing.small),
            ageGenderLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ageGenderLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: ageGenderLabel.bottomAnchor, constant: AppTheme.Spacing.extraLarge),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppTheme.Spacing.medium),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppTheme.Spacing.medium),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AppTheme.Spacing.extraLarge),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Set placeholder image
        setPlaceholderImage()
    }
    
    private func setPlaceholderImage() {
        let size = CGSize(width: 120, height: 120)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        // Draw circle background
        context?.setFillColor(AppTheme.Colors.cardBackground.cgColor)
        context?.fillEllipse(in: CGRect(origin: .zero, size: size))
        
        // Draw person icon
        let personImage = UIImage(systemName: "person.fill")
        let imageSize: CGFloat = 60
        let imageRect = CGRect(
            x: (size.width - imageSize) / 2,
            y: (size.height - imageSize) / 2,
            width: imageSize,
            height: imageSize
        )
        
        context?.setFillColor(AppTheme.Colors.textSecondary.cgColor)
        personImage?.withTintColor(AppTheme.Colors.textSecondary).draw(in: imageRect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        profileImageView.image = image
    }
    
    private func updateUI(with patient: Patient) {
        nameLabel.text = patient.fullName
        ageGenderLabel.text = "\(patient.age) yrs • \(patient.gender)"
        
        bloodGroupCard.configure(
            icon: UIImage(systemName: "drop.fill"),
            title: "BLOOD GROUP",
            value: patient.bloodGroup
        )
        
        heightWeightCard.configure(
            icon: UIImage(systemName: "ruler.fill"),
            title: "HEIGHT & WEIGHT",
            value: patient.heightWeightString
        )
        
        allergiesCard.configure(
            icon: UIImage(systemName: "cross.case.fill"),
            title: "ALLERGIES",
            value: patient.allergiesString
        )
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - PatientProfileViewModelDelegate
extension PatientProfileViewController: PatientProfileViewModelDelegate {
    func patientDidLoad(_ patient: Patient) {
        updateUI(with: patient)
    }
    
    func loadingStateDidChange(isLoading: Bool) {
        if isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    func didReceiveError(_ error: Error) {
        showError(error)
    }
}
