//
//  SismosDetailsViewController.swift
//  Sismos-Chile
//
//  Created by Jose David Bustos H on 18-07-24.
//
import UIKit
import MapKit

class SismosDetailsViewController: UIViewController {
    let sismos: Event
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // Lazy properties for UI elements
    lazy var lbllatitude: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        return label
    }()
 
    lazy var lbllongitude: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var lbldepth: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var viewWebButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ver Web", for: .normal)
        button.addTarget(self, action: #selector(viewWebButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var lblGeoReference: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var lblFechaDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var lblFechautcDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var lblMagnitude: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewTapped))
        mapView.addGestureRecognizer(tapGesture)
        return mapView
    }()
    
    
    init(sismos: Event) {
        self.sismos = sismos
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure(with: sismos)
        loadMap()
    }
    
    private func loadMap() {
        let coordinate = CLLocationCoordinate2D(latitude: sismos.latitude, longitude: sismos.longitude)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Epicenter"
        mapView.addAnnotation(annotation)
    }
    
    func configure(with sis: Event) {
        lblGeoReference.text = "Geo: \(sis.geoReference)"
        lblFechaDate.text = "Local Date: \(sis.localDate)"
        lblFechautcDate.text = "utcDate: \(sis.utcDate)"
        lblMagnitude.text = "Mag: \(sis.magnitude.value)"
        lbldepth.text = "Depth: \(sis.depth)"
        lbllongitude.text = "Lon: \(sis.longitude)"
        lbllatitude.text = "Lat: \(sis.latitude)"
    }
    
    private func setupUI() {
        title = "Sismos Details"
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Add contentView subviews
        contentView.addSubview(mapView)
        contentView.addSubview(lblGeoReference)
        contentView.addSubview(lblFechaDate)
        contentView.addSubview(lblFechautcDate)
        contentView.addSubview(lblMagnitude)
        contentView.addSubview(lbldepth)
        contentView.addSubview(lbllongitude)
        contentView.addSubview(lbllatitude)
        contentView.addSubview(viewWebButton)
        
        // Set constraints
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // ContentView constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // Ensures contentView matches scrollView width
            
            // MapView constraints
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mapView.heightAnchor.constraint(equalToConstant: 200),
            mapView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32), // Adjust width to match contentView
            
            // UILabel constraints
            lblGeoReference.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10),
            lblGeoReference.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lblGeoReference.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            lblFechaDate.topAnchor.constraint(equalTo: lblGeoReference.bottomAnchor, constant: 8),
            lblFechaDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lblFechaDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            lblFechautcDate.topAnchor.constraint(equalTo: lblFechaDate.bottomAnchor, constant: 8),
            lblFechautcDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lblFechautcDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            lblMagnitude.topAnchor.constraint(equalTo: lblFechautcDate.bottomAnchor, constant: 8),
            lblMagnitude.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lblMagnitude.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            lbldepth.topAnchor.constraint(equalTo: lblMagnitude.bottomAnchor, constant: 8),
            lbldepth.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lbldepth.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            lbllongitude.topAnchor.constraint(equalTo: lbldepth.bottomAnchor, constant: 8),
            lbllongitude.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lbllongitude.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            lbllatitude.topAnchor.constraint(equalTo: lbllongitude.bottomAnchor, constant: 8),
            lbllatitude.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lbllatitude.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            viewWebButton.topAnchor.constraint(equalTo: lbllatitude.bottomAnchor, constant: 16),
            viewWebButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            viewWebButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewWebButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func mapViewTapped() {
        guard let latitude = sismos.latitude as? Double, let longitude = sismos.longitude as? Double else {
            print("Invalid latitude or longitude")
            return
        }
        let fullMapVC = MapViewController(longitud: String(longitude), latitud: String(latitude))
        navigationController?.pushViewController(fullMapVC, animated: true)
    }
    
    @objc private func viewWebButtonTapped() {
//        guard let urlString = String(sismos.url) else {
//            print("Invalid URL")
//            return
//        }
        
        let webVC = WebViewController(urlStr: sismos.url)
        navigationController?.pushViewController(webVC, animated: true)
    }
}
