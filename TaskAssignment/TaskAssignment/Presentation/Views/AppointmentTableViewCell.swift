import UIKit

final class AppointmentTableViewCell: UITableViewCell {
    
    static let identifier = "AppointmentTableViewCell"
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppTheme.Colors.cardBackground
        view.layer.cornerRadius = AppTheme.CornerRadius.medium
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let doctorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = AppTheme.Colors.background
        imageView.layer.cornerRadius = 35
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let doctorNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.bold(size: 20)
        label.textColor = AppTheme.Colors.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let specialtyLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.regular(size: 15)
        label.textColor = AppTheme.Colors.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private let dateTimeLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.medium(size: 15)
        label.textColor = AppTheme.Colors.primaryBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let clockIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock.fill")
        imageView.tintColor = AppTheme.Colors.primaryBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = AppTheme.Colors.textSecondary
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(doctorImageView)
        containerView.addSubview(doctorNameLabel)
        containerView.addSubview(specialtyLabel)
        containerView.addSubview(statusLabel)
        containerView.addSubview(clockIconImageView)
        containerView.addSubview(dateTimeLabel)
        containerView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppTheme.Spacing.medium),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppTheme.Spacing.medium),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            doctorImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AppTheme.Spacing.medium),
            doctorImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: AppTheme.Spacing.medium),
            doctorImageView.widthAnchor.constraint(equalToConstant: 70),
            doctorImageView.heightAnchor.constraint(equalToConstant: 70),
            
            doctorNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: AppTheme.Spacing.small),
            doctorNameLabel.leadingAnchor.constraint(equalTo: doctorImageView.trailingAnchor, constant: AppTheme.Spacing.medium),
            doctorNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor, constant: -8),
            
            specialtyLabel.topAnchor.constraint(equalTo: doctorNameLabel.bottomAnchor, constant: 4),
            specialtyLabel.leadingAnchor.constraint(equalTo: doctorNameLabel.leadingAnchor),
            specialtyLabel.trailingAnchor.constraint(equalTo: doctorNameLabel.trailingAnchor),
            
            statusLabel.centerYAnchor.constraint(equalTo: doctorNameLabel.centerYAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AppTheme.Spacing.medium),
            statusLabel.heightAnchor.constraint(equalToConstant: 28),
            statusLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            clockIconImageView.leadingAnchor.constraint(equalTo: doctorImageView.leadingAnchor),
            clockIconImageView.topAnchor.constraint(equalTo: doctorImageView.bottomAnchor, constant: AppTheme.Spacing.medium),
            clockIconImageView.widthAnchor.constraint(equalToConstant: 20),
            clockIconImageView.heightAnchor.constraint(equalToConstant: 20),
            clockIconImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -AppTheme.Spacing.medium),
            
            dateTimeLabel.centerYAnchor.constraint(equalTo: clockIconImageView.centerYAnchor),
            dateTimeLabel.leadingAnchor.constraint(equalTo: clockIconImageView.trailingAnchor, constant: 8),
            
            chevronImageView.centerYAnchor.constraint(equalTo: clockIconImageView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AppTheme.Spacing.medium),
            chevronImageView.widthAnchor.constraint(equalToConstant: 12),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        setPlaceholderImage()
    }
    
    private func setPlaceholderImage() {
        let size = CGSize(width: 70, height: 70)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(AppTheme.Colors.cardBackground.cgColor)
        context?.fillEllipse(in: CGRect(origin: .zero, size: size))
        
        let personImage = UIImage(systemName: "person.fill")
        let imageSize: CGFloat = 35
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
    
    // MARK: - Configuration
    func configure(with appointment: Appointment) {
        doctorNameLabel.text = appointment.doctorName
        specialtyLabel.text = appointment.specialty
        dateTimeLabel.text = appointment.formattedDateTime
        
        statusLabel.text = appointment.status.displayName
        statusLabel.textColor = appointment.status.color
        statusLabel.backgroundColor = appointment.status.color.withAlphaComponent(0.15)
    }
}
