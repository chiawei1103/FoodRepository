//
//  BarcodeScannerView.swift
//  FoodRepository
//
//  Created by Lawrence on 10/17/23.
//

import SwiftUI
import VisionKit

@MainActor
struct BarcodeScannerView: UIViewControllerRepresentable {
    var delegate: BarcodeLookUpDelegate
    var barcode = "" {
        didSet {
            delegate.barcodeLookup(barcode: barcode)
        }
    }
    
    
//    static let textDataType: DataScannerViewController.RecognizedDataType = .text(
//        languages: [
//            "en-US",
//            "ja_JP"
//        ]
//    )
    var scannerViewController: DataScannerViewController = DataScannerViewController(
        recognizedDataTypes: [.barcode()],
        qualityLevel: .accurate,
        recognizesMultipleItems: false,
        isHighFrameRateTrackingEnabled: false,
        isHighlightingEnabled: false
    )
    
    var scannerAvailable: Bool {
        DataScannerViewController.isSupported &&
        DataScannerViewController.isAvailable
    }
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        scannerViewController.delegate = context.coordinator
        try? scannerViewController.startScanning()
        
        
        // Add a button to start scanning
//        let scanButton = UIButton(type: .system)
//        scanButton.backgroundColor = UIColor.systemBlue
//        scanButton.setTitle(BarcodeScannerView.startScanLabel, for: .normal)
//        scanButton.setTitleColor(UIColor.white, for: .normal)
        
//        var config = UIButton.Configuration.filled()
//        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//        scanButton.configuration = config
//        //let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50), configuration: config)
//        
//        //scanButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        scanButton.addTarget(context.coordinator, action: #selector(Coordinator.startScanning(_:)), for: .touchUpInside)
//        scanButton.layer.cornerRadius = 5.0
//        scannerViewController.view.addSubview(scanButton)
//        
//        // Set up button constraints
//        scanButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            scanButton.centerXAnchor.constraint(equalTo: scannerViewController.view.centerXAnchor),
//            scanButton.bottomAnchor.constraint(equalTo: scannerViewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
//        ])
        
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        // Update any view controller settings here
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: BarcodeScannerView
        var roundBoxMappings: [UUID: UIView] = [:]
        
        init(_ parent: BarcodeScannerView) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            processAddedItems(items: addedItems)
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            processRemovedItems(items: removedItems)
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didUpdate updatedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            processUpdatedItems(items: updatedItems)
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            processItem(item: item)
        }
        
        
        func processAddedItems(items: [RecognizedItem]) {
            for item in items {
                processItem(item: item)
                //addRoundBoxToItem(item: item)
            }
        }
        
        func processRemovedItems(items: [RecognizedItem]) {
            for item in items {
                //processItem(item: item)
                removeRoundBoxFromItem(item: item)
            }
        }
        
        func processUpdatedItems(items: [RecognizedItem]) {
            for item in items {
                //processItem(item: item)
                updateRoundBoxToItem(item: item)
            }
        }
        
        func addRoundBoxToItem(frame: CGRect, text: String, item: RecognizedItem) {
            //let roundedRectView = RoundRectView(frame: frame)
//            let roundedRectView = RoundedRectLabel(frame: frame)
//            roundedRectView.setText(text: text)
//            parent.scannerViewController.overlayContainerView.addSubview(roundedRectView)
//            roundBoxMappings[item.id] = roundedRectView
        }
        
        func removeRoundBoxFromItem(item: RecognizedItem) {
            if let roundBoxView = roundBoxMappings[item.id] {
                if roundBoxView.superview != nil {
                    roundBoxView.removeFromSuperview()
                    roundBoxMappings.removeValue(forKey: item.id)
                }
            }
        }
        
        func updateRoundBoxToItem(item: RecognizedItem) {
            if let roundBoxView = roundBoxMappings[item.id] {
                if roundBoxView.superview != nil {
                    let frame = getRoundBoxFrame(item: item)
                    roundBoxView.frame = frame
                }
            }
        }
        
        func getRoundBoxFrame(item: RecognizedItem) -> CGRect {
            let frame = CGRect(
                x: item.bounds.topLeft.x,
                y: item.bounds.topLeft.y,
                width: abs(item.bounds.topRight.x - item.bounds.topLeft.x) + 15,
                height: abs(item.bounds.topLeft.y - item.bounds.bottomLeft.y) + 15
            )
            return frame
        }
        
        func processItem(item: RecognizedItem) {
            switch item {
            case .text(let text):
                print("Text Observation - \(text.observation)")
                print("Text transcript - \(text.transcript)")
                let frame = getRoundBoxFrame(item: item)
                addRoundBoxToItem(frame: frame, text: text.transcript, item: item)
            case .barcode(let barcode):
                if let barcode = barcode.payloadStringValue {
                    self.parent.barcode = barcode
                }
                
            @unknown default:
                print("Should not happen")
            }
        }
    }
}

