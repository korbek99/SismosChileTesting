//
//  SismosTableViewCell.swift
//  Sismos-Chile
//
//  Created by Jose David Bustos H on 18-07-24.
//
import UIKit

struct SismosTableViewModel {
    let localDate: String
    let utcDate: String
    let magnitude: String
    let geoReference: String
    
    init(localDate: String, utcDate: String, magnitude: String, geoReference: String) {
        self.localDate = localDate
        self.utcDate = utcDate
        self.magnitude = magnitude
        self.geoReference = geoReference
    }
}

class SismosTableViewCell: UITableViewCell {
    static let identifier = "SismosTableViewCell"
    
    lazy var imageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "location-icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var lblGeoReference: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var lblFecha: UILabel = {
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
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIUX()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblGeoReference.text = nil
        lblFecha.text = nil
        lblMagnitude.text = nil
    }
    
    func configure(_ model: SismosTableViewModel) {
        
        lblFecha.text = "Date: \(model.utcDate)"
        lblGeoReference.text = "Geo: \(model.geoReference)"
        lblMagnitude.text = "Magnitude: \(model.magnitude)"
    }

    private func setupUIUX() {
        backgroundColor = .white
        addSubview(imageIcon)
        addSubview(lblGeoReference)
        addSubview(lblFecha)
        addSubview(lblMagnitude)
        
        NSLayoutConstraint.activate([
            imageIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            imageIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageIcon.widthAnchor.constraint(equalToConstant: 100),
            imageIcon.heightAnchor.constraint(equalToConstant: 100),
            
            lblGeoReference.leadingAnchor.constraint(equalTo: imageIcon.trailingAnchor, constant: 15),
            lblGeoReference.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            lblGeoReference.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            lblFecha.leadingAnchor.constraint(equalTo: imageIcon.trailingAnchor, constant: 15),
            lblFecha.topAnchor.constraint(equalTo: lblGeoReference.bottomAnchor, constant: 4),
            lblFecha.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            lblMagnitude.leadingAnchor.constraint(equalTo: imageIcon.trailingAnchor, constant: 15),
            lblMagnitude.topAnchor.constraint(equalTo: lblFecha.bottomAnchor, constant: 4),
            lblMagnitude.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            lblMagnitude.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
