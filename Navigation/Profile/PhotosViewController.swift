//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Евгений Стафеев on 20.11.2022.
//

import UIKit
import StorageService
import iOSIntPackage


class PhotosViewController: UIViewController {
    
    private var images: [UIImage] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var imageProcessor = ImageProcessor()
    
    private var imagePublisherFacade = ImagePublisherFacade()
    private var photos = [UIImage]()
    private var photoModel = PhotoModel.makeModel()
    
    
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 8
        $0.minimumInteritemSpacing = 8
        return $0
    }(UICollectionViewFlowLayout())
    
    private lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.dataSource = self
        $0.delegate = self
        $0.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: self.layout))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        self.title = "Фото Галерея"
        self.navigationController?.navigationBar.isHidden = false
        setupLayout()
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 1, repeat: 20, userImages: photoModel)
        benchmarkBackgrpundQOS()
        benchmarkDefaultQOS()
        benchmarkUserInteractiveQOS()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imagePublisherFacade.removeSubscription(for: self)
        imagePublisherFacade.rechargeImageLibrary()
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
     func receive(images: [UIImage]) {
         photos = images
     collectionView.reloadData()
     }
 }

extension PhotosViewController {

     func benchmarkBackgrpundQOS() {
         let startTime = Date()
         imageProcessor.processImagesOnThread(sourceImages: images, filter: .fade, qos: .background) { [weak self] images in
             print("backgroundQOS")
             DispatchQueue.main.async {
                 var newImages: [UIImage] = []
                 images.forEach { image in
                     guard let newImage = image else { return }
                     newImages.append(UIImage(cgImage: newImage))
                 }
                 self?.images = newImages
             }
         }
         let endTime = Date()

         let timeElapsed = endTime.timeIntervalSince(startTime)
         print("Time elapsed: \(timeElapsed) s for backgroundQOS")
     }

     func benchmarkDefaultQOS() {
         let startTime = Date()
         imageProcessor.processImagesOnThread(sourceImages: images, filter: .chrome, qos: .default) { [weak self] images in
             print("defaultQOS")
             DispatchQueue.main.async {
                 var newImages: [UIImage] = []
                 images.forEach { image in
                     guard let newImage = image else { return }
                     newImages.append(UIImage(cgImage: newImage))
                 }
                 self?.images = newImages
             }
         }
         let endTime = Date()

         let timeElapsed = endTime.timeIntervalSince(startTime)
         print("Time elapsed: \(timeElapsed) s for defaultQOS")
         }

     func benchmarkUserInteractiveQOS() {
         let startTime = Date()
         imageProcessor.processImagesOnThread(sourceImages: images, filter: .sepia(intensity: 1), qos: .userInteractive) { [ weak self ] images in
             print("userInteractiveQOS")
             DispatchQueue.main.async {
                 var newImages: [UIImage] = []
                 images.forEach { image in
                     guard let newImage = image else { return }
                     newImages.append(UIImage(cgImage: newImage))
                 }
                 self?.images = newImages
             }
         }
         let endTime = Date()

         let timeElapsed = endTime.timeIntervalSince(startTime)
         print("Time elapsed: \(timeElapsed) s userInteractiveQOS")
     }

 }
