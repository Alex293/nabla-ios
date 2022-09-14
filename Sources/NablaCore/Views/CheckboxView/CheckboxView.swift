import UIKit

public extension NablaViews {
    final class CheckboxView: UIView {
        // MARK: - Public
        
        public var theme: Theme = .init() {
            didSet { updateAppearance() }
        }
        
        public var isChecked: Bool = false {
            didSet { updateAppearance() }
        }
        
        // MARK: Init
        
        override public init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
            updateAppearance()
        }
        
        public required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUp()
            updateAppearance()
        }
        
        // MARK: - Private
        
        // MARK: Life cycle
        
        override public func layoutSubviews() {
            super.layoutSubviews()
            backgroundView.layer.cornerRadius = min(frame.height, frame.width) / 2
        }
        
        // MARK: Subviews
        
        private lazy var imageView: UIImageView = {
            let view = UIImageView(image: UIImage(systemName: "checkmark"))
            view.tintColor = .white
            view.backgroundColor = .clear
            return view
        }()
        
        private lazy var backgroundView: UIView = {
            let view = UIView()
            view.layer.borderWidth = 1
            return view
        }()
        
        private func setUp() {
            addSubview(backgroundView)
            backgroundView.nabla.pinToSuperView()
            
            addSubview(imageView)
            imageView.nabla.pinToSuperView(insets: .nabla.all(4))
        }
        
        private func updateAppearance() {
            if isChecked {
                backgroundView.layer.borderColor = theme.checked.borderColor.cgColor
                backgroundView.backgroundColor = theme.checked.fillcolor
                imageView.isHidden = false
            } else {
                backgroundView.layer.borderColor = theme.unchecked.borderColor.cgColor
                backgroundView.backgroundColor = theme.unchecked.fillcolor
                imageView.isHidden = true
            }
        }
    }
}
