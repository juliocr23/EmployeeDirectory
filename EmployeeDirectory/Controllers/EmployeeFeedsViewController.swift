//
//  ViewController.swift
//  EmployeeDirectory
//
//  Created by Julio Rosario on 3/10/24.
//

import UIKit

class EmployeeFeedsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let collectionViewController = CollectionViewController()
    var sections: [CollectionViewSection] = []
    var sectionProvider: EmployeeSummaryCollectionViewCellControllerSectionProvider!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupFloatingButton()
        setupProviders()
        fetchDataIfNeeded()
    }
   
    private func setupCollectionView() {
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .lightGray
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView?.register(EmployeeSummaryCollectionViewCell.nib, forCellWithReuseIdentifier: EmployeeSummaryCollectionViewCell.reuseableIdentifier)
        collectionViewController.collectionView = collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (view.frame.size.width/1),
                                 height: (view.frame.size.height/3))
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.frame = view.bounds
    }
    
    private func setupProviders() {
        sectionProvider = .init(dataSource: .shared,
                                collectionViewCellControllerProvider: EmployeeSummaryCollectionViewCellControllerProvider())
    }
    
    private func fetchDataIfNeeded() {
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray),
                                                    animation: nil,
                                                    transition: .crossDissolve(0.25))
        Task {
            do {
                let section = try await sectionProvider.provideCollectionViewSection()
                sections.append(section)
                toggleAppStateView(visible: sections.first?.cellControllers.isEmpty ?? false,
                                   appState: .empty)
            } catch {
                toggleAppStateView(visible: true,
                                   appState: .error)
            }
            
            await MainActor.run {
                self.collectionViewController.sections = sections
                self.collectionView.stopSkeletonAnimation()
                self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            }
        }
    }
    
    private func toggleAppStateView(visible: Bool, appState: AppState) {
        collectionView.backgroundView = visible ? provideAppState(appState: appState) : nil
    }
}

extension EmployeeFeedsViewController {
    func setupFloatingButton() {
        let floatingButton = UIButton(type: .custom)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.backgroundColor = .systemBlue
        floatingButton.setTitle("Reload", for: .normal)
        floatingButton.layer.cornerRadius = 30
        floatingButton.clipsToBounds = true
        view.addSubview(floatingButton)
        
        NSLayoutConstraint.activate([
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingButton.widthAnchor.constraint(equalToConstant: 60),
            floatingButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        view.bringSubviewToFront(floatingButton)
    }
    
    func provideAppState(appState: AppState) -> UIView {
        let emptyStateView = UIView(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        emptyStateView.backgroundColor = .white

        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = appState == .empty ? "No data available" : "Opps something went wrong."
        messageLabel.textColor = .gray
        messageLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        messageLabel.textAlignment = .center
        emptyStateView.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: emptyStateView.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor, constant: -20)
        ])

        return emptyStateView
    }
    
    @objc func floatingButtonTapped() {
       fetchDataIfNeeded()
    }
}

enum AppState {
    case empty
    case error
}
