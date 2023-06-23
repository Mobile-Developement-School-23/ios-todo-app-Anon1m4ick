
import UIKit

class ViewController: UIViewController {
    
    
    //    private lazy var label = makeLabel()
    private lazy var navBarContainerView = makeNavBarContainerView()
    private lazy var leftBarButton = makeBarButton(with: "Отменить") // TODO: - Localize
    private lazy var titleLabel = makeTitleLabel()
    private lazy var rightBarButton = makeBarButton(with: "Сохранить") // TODO: - Localize
    private lazy var scrollView = makeScrollView()
    private lazy var textView = makeTextView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
        private func makeStackView() -> UIStackView {
            let stackView = UIStackView(
                arrangedSubviews: [
                    textView,
//                    detailsSecondaryView,
//                    deleteButton
                ]
            )
            stackView.axis = .vertical
            stackView.spacing = 16
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }

    
        private func makeTextView() -> UITextView {
            let textView = UITextView()
            textView.font = DSFont.body.font
//            textView.delegate = self
            textView.isScrollEnabled = false
            textView.layer.cornerRadius = 16
            textView.textColor = DSColor.labelPrimary.color
            textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            textView.translatesAutoresizingMaskIntoConstraints = false
            return textView
    }
    
    
        private func makeScrollView() -> UIScrollView {
            let scrollView = UIScrollView()
//            scrollView.addSubview(stackView)
            scrollView.alwaysBounceVertical = true
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
    }

        private func makeBarButton(with title: String) -> UIButton {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = DSFont.body.font
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
        
        private func makeTitleLabel() -> UILabel {
            let label = UILabel()
            label.font = DSFont.body.font
            label.textAlignment = .center
            label.text = "Дело" // TODO: - Localize
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }
        
        private func makeNavBarContainerView() -> UIView {
            let view = UIView()
            [
                leftBarButton,
                titleLabel,
                rightBarButton
            ].forEach { view.addSubview($0) }
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
    
    private func setup() {
        [
            navBarContainerView,
            scrollView
        ].forEach { view.addSubview($0) }
        
        view.keyboardLayoutGuide.followsUndockedKeyboard = true
        
        setupColors()
        setupConstraints()
    }
    private func setupColors() {
        view.backgroundColor = DSColor.backPrimary.color
        textView.backgroundColor = DSColor.backSecondary.color
        titleLabel.textColor = DSColor.labelPrimary.color
        [leftBarButton, rightBarButton].forEach {
            $0.setTitleColor(DSColor.colorBlue.color, for: .normal)
        }
        rightBarButton.setTitleColor(DSColor.labelTertiary.color, for: .disabled)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                navBarContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                navBarContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                navBarContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                navBarContainerView.heightAnchor.constraint(equalToConstant: 56)
            ]
        )
        NSLayoutConstraint.activate(
            [
                leftBarButton.centerYAnchor.constraint(equalTo: navBarContainerView.centerYAnchor),
                leftBarButton.leadingAnchor.constraint(
                    equalTo: navBarContainerView.leadingAnchor,
                    constant: 16
                )
            ]
        )
        NSLayoutConstraint.activate(
            [
                titleLabel.centerXAnchor.constraint(equalTo: navBarContainerView.centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: navBarContainerView.centerYAnchor)
            ]
        )
        NSLayoutConstraint.activate(
            [
                rightBarButton.centerYAnchor.constraint(equalTo: navBarContainerView.centerYAnchor),
                rightBarButton.trailingAnchor.constraint(
                    equalTo: navBarContainerView.trailingAnchor,
                    constant: -16
                )
            ]
        )
        NSLayoutConstraint.activate(
            [
                scrollView.topAnchor.constraint(equalTo: navBarContainerView.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
//        NSLayoutConstraint.activate(
//            [
//                stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//                stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
//                stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
//                stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//                stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
//            ]
//        )
        NSLayoutConstraint.activate(
            [
                textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120)
            ]
        )
    }
    
    
        
    
    
}
