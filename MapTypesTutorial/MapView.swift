import SwiftUI
import MapKit
import Combine

struct MapView: UIViewRepresentable {
    
    private var counter = 0
    private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.3811, longitude: 4.6373),
                                               span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
    @EnvironmentObject private var mapSettings: MapSettings

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.region = mapRegion
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateMapType(uiView)
    }
    
    private func updateMapType(_ uiView: MKMapView) {
        switch mapSettings.mapType {
        case 0:
            let configuration = MKStandardMapConfiguration(elevationStyle: elevationStyle(), emphasisStyle: emphasisStyle())
            configuration.pointOfInterestFilter = MKPointOfInterestFilter(including: [.atm])
            configuration.pointOfInterestFilter = MKPointOfInterestFilter(excluding: [.bakery])
            configuration.showsTraffic = false
            uiView.preferredConfiguration = MKStandardMapConfiguration(elevationStyle: elevationStyle(), emphasisStyle: emphasisStyle()) // the flat visualization of map
        case 1:
            uiView.preferredConfiguration = MKHybridMapConfiguration(elevationStyle: elevationStyle())// this uses satelite images and road names, can se the globe in realistic
        case 2:
            uiView.preferredConfiguration = MKImageryMapConfiguration(elevationStyle: elevationStyle()) //flat - just images dont see the globe, realistic 3D realistic building can see the globe
        default:
            break
        }
        
    }
    
    private func elevationStyle() -> MKMapConfiguration.ElevationStyle {
        if mapSettings.showElevation == 0 {
            return MKMapConfiguration.ElevationStyle.realistic
        } else {
            return MKMapConfiguration.ElevationStyle.flat
        }
    }
    
    private func emphasisStyle() -> MKStandardMapConfiguration.EmphasisStyle {
        if mapSettings.showEmphasisStyle == 0 {
            return MKStandardMapConfiguration.EmphasisStyle.default
        } else {
            return MKStandardMapConfiguration.EmphasisStyle.muted // muted shows grayed streets and buildings - need to test this
        }
    }
}
