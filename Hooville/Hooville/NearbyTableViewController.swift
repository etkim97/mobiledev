//
//  NearbyTableViewController.swift
//  Hooville
//
//  Created by Elliott Kim on 4/24/18.
//  Copyright © 2018 Amanda Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreLocation

class NearbyTableViewController: UITableViewController, CLLocationManagerDelegate {
    // Properties - Events
    var nameText:String = ""
    var latitude:String = ""
    var longitude:String = ""
    // var eventItems = [eventItem]()
    var nearbyEventsList = [event]()

    func loadSampleItems() {
        //let item1 = BucketItem(name: "My Awesomeness", date: Date(), noteText: "Here is some stuff!")
        //bucketItems += [item1]
        //let item2 = BucketItem(name: "More Notes!", date: Date(), noteText: "Here is some stuff!")
        //bucketItems += [item2]
        /*
        let eventitem1 = eventItem(name: "Go hiking")
        eventItems += [eventitem1]
        let eventitem2 = eventItem(name: "Go biking")
        eventItems += [eventitem2]
        let eventitem3 = eventItem(name: "Go piking")
        eventItems += [eventitem3]
         */
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference(withPath: "Activities")
        ref.observe(.value, with: { snapshot in
            //print(snapshot.value ?? "false")
        })

        /*
        ref.observe(.value, with: { snapshot in
            var newItems: [eventItem] = []
            for item in snapshot.children {
                let event = eventItem(snapshot: item as! DataSnapshot)
                newItems.append(event)
            }
            self.eventItems = newItems
            self.tableView.reloadData()
        })
        */
        self.startGPS()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Table Functions

    // Override to show how many lists there should be
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Override to show how many notes are in the list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearbyEventsList.count
    }


    // Override to show what each cell should have in it based on the note in the list
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "NearbyTableViewCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NearbyTableViewCell

        // Fetches the appropriate note for the data source layout.
        let item = nearbyEventsList[indexPath.row]
        cell.itemNameLabel.text = item.name
        cell.itemDateLabel.text = item.date
        cell.itemAddressLabel.text = item.address
        /*
         let dateFormatter = DateFormatter()
         dateFormatter.dateStyle = .short
         let convertedDate = dateFormatter.string(from: item.date)
         cell.dateLabel.text = convertedDate

         if item.complete {
         cell.backgroundColor = UIColor.lightGray
         }
         else{
         cell.backgroundColor = UIColor.white
         }
         */
        return cell
    }

    // GPS stuff

    var locationManager: CLLocationManager?
    // @IBOutlet weak var lat: UILabel!
    // @IBOutlet weak var lon: UILabel!

    func createLocationManager(startImmediately: Bool){
        // Add code to start the locationManager
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        // locationManager?.startUpdatingLocation()
        locationManager?.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Add your code here
        // Code here is called when the location updates
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        latitude = "\(locValue.latitude)"
        longitude = "\(locValue.longitude)"
        // lat.text = "Lat: " + "\(locValue.latitude)"
        // lon.text = "Lon: " + "\(locValue.longitude)"
        if longitude != "" {
            self.nearbyEvents()
        }

    }

    // @IBAction func startGPS(_ sender: UIButton) {
    func startGPS() {
        // Helper function provided to manage authorization - no edits needed.

        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
            case .authorizedAlways:
                /* Yes, always */
                createLocationManager(startImmediately: true)
            case .authorizedWhenInUse:
                /* Yes, only when our app is in use  */
                createLocationManager(startImmediately: true)
            case .denied:
                /* No */
                displayAlertWithTitle(title: "Not Determined",
                                      message: "Location services are not allowed for this app")
            case .notDetermined:
                /* We don't know yet, we have to ask */
                createLocationManager(startImmediately: false)
                if let manager = self.locationManager{
                    manager.requestWhenInUseAuthorization()
                }
            case .restricted:
                /* Restrictions have been applied, we have no access
                 to location services */
                displayAlertWithTitle(title: "Restricted",
                                      message: "Location services are not allowed for this app")
            }


        } else {
            /* Location services are not enabled.
             Take appropriate action: for instance, prompt the
             user to enable the location services */
            print("Location services are not enabled")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        // Code here is called on an error - no edits needed.
        print("Location manager failed with error = \(error)")
    }

    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // Code here is called when authoization changes - no edits needed.
        print("The authorization status of location services is changed to: ", terminator: "")

        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways:
            print("Authorized")
        case .authorizedWhenInUse:
            print("Authorized when in use")
        case .denied:
            print("Denied")
        case .notDetermined:
            print("Not determined")
        case .restricted:
            print("Restricted")
        }

    }

    func displayAlertWithTitle(title: String, message: String){
        // Helper function for displaying dialog windows - no edits needed.
        let controller = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: .alert)

        controller.addAction(UIAlertAction(title: "OK",
                                           style: .default,
                                           handler: nil))

        present(controller, animated: true, completion: nil)

    }

    // Web Service Stuff
    func nearbyEvents(completion: (() -> ())? = nil) {
        let url = URL(string: "https://www.eventbriteapi.com/v3/events/search/?location.longitude="+longitude+"&location.latitude="+latitude+"&location.within=2mi&token=O7PTPV6ZLZHSGNX5MXII&expand=organizer%2Cvenue")

        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in

            if error != nil {
                print("error: ", error!)
            } else {
                do {
                    // var nearby = [event]()
                    if let coordinateArray = try JSONSerialization.jsonObject(with: data!) as? [String:Any],
                        let events = coordinateArray["events"] as? [[String:Any]] {

                        for activity in events {
                            let e = event()
                            if let nameJson = activity["name"] as? [String:AnyObject] {
                                if let name = nameJson["text"] as? String {
                                    e.setName(n: name)
                                }
                            }
                            if let venueJson = activity["venue"] as? [String:AnyObject] {
                                if let addrJson = venueJson["address"] as? [String:AnyObject] {
                                    if let address = addrJson["address_1"] as? String {
                                        e.setAddress(a: address)
                                    }
                                }
                            }
                            if let descJson = activity["description"] as? [String:AnyObject] {
                                if let text = descJson["text"] as? String {
                                    e.setDesc(d: text)
                                }
                            }
                            if let startJson = activity["start"] as? [String:AnyObject] {
                                if let local = startJson["local"] as? String {
                                    e.setDate(d: local)
                                }
                            }
                            self.nearbyEventsList += [e]
                        }

                    }
                    DispatchQueue.main.async {
                        completion?()
                        self.tableView.reloadData()
                     }
                } catch {
                    print (error)
                }
            }

            for each in self.nearbyEventsList {
                print(each.name)
            }
        }
        task.resume()
    }
}
