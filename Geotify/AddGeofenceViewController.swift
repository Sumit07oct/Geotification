

//  Created by Sumeet on 3/18/19.
//  Copyright © 2019 Sumeet. All rights reserved.
//



import UIKit
import MapKit

protocol AddGeofenceViewControllerDelegate {
  func addGeotificationViewController(_ controller: AddGeofenceViewController, didAddCoordinate coordinate: CLLocationCoordinate2D,
                                      radius: Double, identifier: String, note: String, eventType: Geotification.EventType)
}

class AddGeofenceViewController: UITableViewController {
  
  @IBOutlet var addButton: UIBarButtonItem!
  @IBOutlet var zoomButton: UIBarButtonItem!
  @IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
  @IBOutlet weak var radiusTextField: UITextField!
  @IBOutlet weak var noteTextField: UITextField!
  @IBOutlet weak var mapView: MKMapView!
  
  var delegate: AddGeofenceViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItems = [addButton, zoomButton]
    addButton.isEnabled = false
  }
  
  @IBAction func textFieldEditingChanged(sender: UITextField) {
    addButton.isEnabled = !radiusTextField.text!.isEmpty && !noteTextField.text!.isEmpty
  }
  
  @IBAction func onCancel(sender: AnyObject) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction private func onAdd(sender: AnyObject) {
    let coordinate = mapView.centerCoordinate
    let radius = Double(radiusTextField.text!) ?? 0
    let identifier = NSUUID().uuidString
    let note = noteTextField.text
    let eventType: Geotification.EventType = (eventTypeSegmentedControl.selectedSegmentIndex == 0) ? .onEntry : .onExit
    delegate?.addGeotificationViewController(self, didAddCoordinate: coordinate, radius: radius, identifier: identifier, note: note!, eventType: eventType)
  }
  
  @IBAction private func onZoomToCurrentLocation(sender: AnyObject) {
    mapView.zoomToUserLocation()
  }
}
