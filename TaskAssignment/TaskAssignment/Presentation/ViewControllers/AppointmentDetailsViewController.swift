import UIKit

final class AppointmentDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: AppointmentDetailsViewModel
    private let appointment: Appointment
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let doctorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = AppTheme.Colors.cardBackground
        imageView.layer.cornerRadius = 60
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.semibold(size: 12)
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doctorNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.bold(size: 26)
        label.textColor = AppTheme.Colors.textPrimary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let specialtyLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.medium(size: 16)
        label.textColor = AppTheme.Colors.primaryBlue
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppTheme.Colors.cardBackground
        view.layer.cornerRadius = AppTheme.CornerRadius.medium
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let reasonTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "REASON FOR VISIT"
        label.font = AppTheme.Fonts.semibold(size: 12)
        label.textColor = AppTheme.Colors.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reasonLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.regular(size: 15)
        label.textColor = AppTheme.Colors.textPrimary
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reasonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppTheme.Colors.cardBackground
        view.layer.cornerRadius = AppTheme.CornerRadius.medium
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialization
    init(viewModel: AppointmentDetailsViewModel, appointment: Appointment) {
        self.viewModel = viewModel
        self.appointment = appointment
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithAppointment()
    }
    
    // MARK: - Setup
    private func setupUI() {
        navigationItem.title = "Appointment Details"
        view.backgroundColor = AppTheme.Colors.background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(doctorImageView)
        contentView.addSubview(statusLabel)
        contentView.addSubview(doctorNameLabel)
        contentView.addSubview(specialtyLabel)
        contentView.addSubview(detailsContainerView)
        contentView.addSubview(reasonTitleLabel)
        contentView.addSubview(reasonContainerView)
        reasonContainerView.addSubview(reasonLabel)
        
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
            
            doctorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppTheme.Spacing.large),
            doctorImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            doctorImageView.widthAnchor.constraint(equalToConstant: 120),
            doctorImageView.heightAnchor.constraint(equalToConstant: 120),
            
            statusLabel.topAnchor.constraint(equalTo: doctorImageView.bottomAnchor, constant: AppTheme.Spacing.medium),
            statusLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 28),
            statusLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            doctorNameLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: AppTheme.Spacing.medium),
            doctorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppTheme.Spacing.medium),
            doctorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppTheme.Spacing.medium),
            
            specialtyLabel.topAnchor.constraint(equalTo: doctorNameLabel.bottomAnchor, constant: AppTheme.Spacing.small),
            specialtyLabel.leadingAnchor.constraint(equalTo: doctorNameLabel.leadingAnchor),
            specialtyLabel.trailingAnchor.constraint(equalTo: doctorNameLabel.trailingAnchor),
            
            detailsContainerView.topAnchor.constraint(equalTo: specialtyLabel.bottomAnchor, constant: AppTheme.Spacing.extraLarge),
            detailsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppTheme.Spacing.medium),
            detailsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppTheme.Spacing.medium),
            
            reasonTitleLabel.topAnchor.constraint(equalTo: detailsContainerView.bottomAnchor, constant: AppTheme.Spacing.extraLarge),
            reasonTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppTheme.Spacing.medium),
            reasonTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppTheme.Spacing.medium),
            
            reasonContainerView.topAnchor.constraint(equalTo: reasonTitleLabel.bottomAnchor, constant: AppTheme.Spacing.medium),
            reasonContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppTheme.Spacing.medium),
            reasonContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppTheme.Spacing.medium),
            reasonContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AppTheme.Spacing.extraLarge),
            
            reasonLabel.topAnchor.constraint(equalTo: reasonContainerView.topAnchor, constant: AppTheme.Spacing.medium),
            reasonLabel.leadingAnchor.constraint(equalTo: reasonContainerView.leadingAnchor, constant: AppTheme.Spacing.medium),
            reasonLabel.trailingAnchor.constraint(equalTo: reasonContainerView.trailingAnchor, constant: -AppTheme.Spacing.medium),
            reasonLabel.bottomAnchor.constraint(equalTo: reasonContainerView.bottomAnchor, constant: -AppTheme.Spacing.medium)
        ])
        
        setupDetailsContainer()
        setPlaceholderImage()
    }
    
    private func setupDetailsContainer() {
        let dateRow = createDetailRow(icon: "calendar", title: "Date", value: "")
        let timeRow = createDetailRow(icon: "clock", title: "Time", value: "")
        let locationRow = createDetailRow(icon: "mappin.circle", title: "Location", value: "")
        
        detailsContainerView.addSubview(dateRow)
        detailsContainerView.addSubview(timeRow)
        detailsContainerView.addSubview(locationRow)
        
        dateRow.tag = 100
        timeRow.tag = 101
        locationRow.tag = 102
        
        NSLayoutConstraint.activate([
            dateRow.topAnchor.constraint(equalTo: detailsContainerView.topAnchor, constant: AppTheme.Spacing.medium),
            dateRow.leadingAnchor.constraint(equalTo: detailsContainerView.leadingAnchor),
            dateRow.trailingAnchor.constraint(equalTo: detailsContainerView.trailingAnchor),
            dateRow.heightAnchor.constraint(equalToConstant: 60),
            
            timeRow.topAnchor.constraint(equalTo: dateRow.bottomAnchor),
            timeRow.leadingAnchor.constraint(equalTo: detailsContainerView.leadingAnchor),
            timeRow.trailingAnchor.constraint(equalTo: detailsContainerView.trailingAnchor),
            timeRow.heightAnchor.constraint(equalToConstant: 60),
            
            locationRow.topAnchor.constraint(equalTo: timeRow.bottomAnchor),
            locationRow.leadingAnchor.constraint(equalTo: detailsContainerView.leadingAnchor),
            locationRow.trailingAnchor.constraint(equalTo: detailsContainerView.trailingAnchor),
            locationRow.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            locationRow.bottomAnchor.constraint(equalTo: detailsContainerView.bottomAnchor, constant: -AppTheme.Spacing.medium)
        ])
    }
    
    private func createDetailRow(icon: String, title: String, value: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let iconView = UIImageView()
        iconView.image = UIImage(systemName: icon)
        iconView.tintColor = AppTheme.Colors.primaryBlue
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = AppTheme.Fonts.medium(size: 15)
        titleLabel.textColor = AppTheme.Colors.textPrimary
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = AppTheme.Fonts.regular(size: 15)
        valueLabel.textColor = AppTheme.Colors.textSecondary
        valueLabel.textAlignment = .right
        valueLabel.numberOfLines = 0
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.tag = 999
        
        container.addSubview(iconView)
        container.addSubview(titleLabel)
        container.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: AppTheme.Spacing.medium),
            iconView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: AppTheme.Spacing.medium),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: AppTheme.Spacing.medium),
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -AppTheme.Spacing.medium),
            valueLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        return container
    }
    
    private func setPlaceholderImage() {
        let size = CGSize(width: 120, height: 120)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(AppTheme.Colors.cardBackground.cgColor)
        context?.fillEllipse(in: CGRect(origin: .zero, size: size))
        
        let personImage = UIImage(systemName: "person.fill")
        let imageSize: CGFloat = 60
        let imageRect = CGRect(
            x: (size.width - imageSize) / 2,
            y: (size.height - imageSize) / 2,
            width: imageSize,
            height: imageSize
        )
        
        personImage?.withTintColor(AppTheme.Colors.textSecondary).draw(in: imageRect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        doctorImageView.image = image
    }
    
    private func configureWithAppointment() {
        doctorNameLabel.text = appointment.doctorName
        specialtyLabel.text = appointment.specialty
        reasonLabel.text = appointment.reason
        
        statusLabel.text = appointment.status.displayName
        statusLabel.textColor = appointment.status.color
        statusLabel.backgroundColor = appointment.status.color.withAlphaComponent(0.15)
        
        // Update detail rows
        if let dateRow = detailsContainerView.viewWithTag(100),
           let valueLabel = dateRow.viewWithTag(999) as? UILabel {
            valueLabel.text = appointment.formattedDate
        }
        
        if let timeRow = detailsContainerView.viewWithTag(101),
           let valueLabel = timeRow.viewWithTag(999) as? UILabel {
            valueLabel.text = appointment.formattedTime
        }
        
        if let locationRow = detailsContainerView.viewWithTag(102),
           let valueLabel = locationRow.viewWithTag(999) as? UILabel {
            valueLabel.text = appointment.fullLocation
        }
    }
}
