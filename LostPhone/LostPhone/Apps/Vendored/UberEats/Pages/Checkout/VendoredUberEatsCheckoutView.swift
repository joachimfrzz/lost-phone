//
//  VendoredUberEatsCheckoutView.swift
//  food-delivery-ui-kit-v1
//
//  Created by Sopheamen VAN on 2/5/25.
//

import SwiftUI
import Kingfisher
import MapKit

struct VendoredUberEatsCheckoutView: View {
    @Environment(\.dismiss) var dismiss
    var cart:VendoredUberEatsCartResponse
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom){
                // scrollable content
                ScrollView {
                    VStack (spacing:12){
                        // map
                        VendoredUberEatsMapCartView()
                        // address list
                        VendoredUberEatsAddressCartView()
                        // delivery options list
                        VendoredUberEatsDeliveryOptionView()
                        // order list
                        VendoredUberEatsOrderSummaryView(cart: cart)
                        // promotion
                        VendoredUberEatsPromotionView()
                        // total summary
                        VendoredUberEatsTotalSummaryView(cart: cart)
                        // master card
                        VendoredUberEatsMasterCardView()
                    }
                    .padding()
                    .padding(.bottom, 60)
                }
                // footer button
                Text("Checkout")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.vendoredUberEatsDarkButtonColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
               
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // leading
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                    }
                }
                // title
                ToolbarItem (placement: .principal){
                    Text("Checkout")
                        .font(.title2)
                }
            }
        }
    }
}

#Preview {
    VendoredUberEatsCheckoutView(cart: cartData[0])
}

struct VendoredUberEatsMapCartView:View {
    // map const
    @State private var region = MKCoordinateRegion(
           center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
           span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
       )
       @State private var animatedPolyline: MKPolyline?
       @State private var startAnnotation: MKPointAnnotation?
       @State private var endAnnotation: MKPointAnnotation?
       @State private var routeCoordinates: [CLLocationCoordinate2D] = []
       @State private var animationTimer: Timer?
    
    var body: some View {
        VendoredUberEatsMapView(
            region: $region,
            polyline: $animatedPolyline,
            startAnnotation: $startAnnotation,
            endAnnotation: $endAnnotation
        )
        .ignoresSafeArea()
        .onAppear {
            let start = CLLocationCoordinate2D(latitude: 35.8730, longitude: 14.4410)
            let end = CLLocationCoordinate2D(latitude: 35.8745, longitude: 14.4435)
            calculateRoute(from: start, to: end)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
       
    }
    // func
    func calculateRoute(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) {
            region.center = start

            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: start))
            request.destination = MKMapItem(placemark: .init(coordinate: end))
            request.transportType = .automobile

            MKDirections(request: request).calculate { response, error in
                guard let route = response?.routes.first else {
                    print("Route error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                routeCoordinates = route.polyline.coordinates
                region = MKCoordinateRegion(route.polyline.boundingMapRect)
                animatePolyline()

                let startAnn = MKPointAnnotation()
                startAnn.coordinate = start
                startAnn.title = "Start"
                self.startAnnotation = startAnn

                let endAnn = MKPointAnnotation()
                endAnn.coordinate = end
                endAnn.title = "Destination"
                self.endAnnotation = endAnn
            }
        }

        func animatePolyline() {
            animationTimer?.invalidate()
            var index = 1
            animationTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                guard index <= self.routeCoordinates.count else {
                    timer.invalidate()
                    return
                }
                let sliced = Array(self.routeCoordinates.prefix(index))
                self.animatedPolyline = MKPolyline(coordinates: sliced, count: sliced.count)
                index += 1
            }
        }
}

struct VendoredUberEatsAddressCartView:View {
    var addressDatas:[VendoredUberEatsAddressResponse] = addressData
    var body: some View {
        LazyVStack {
            ForEach(addressDatas) { address in
                VendoredUberEatsAddressCartRowView(address: address)
            }
        }
    }
}

struct VendoredUberEatsAddressCartRowView:View {
    var address:VendoredUberEatsAddressResponse
    var body: some View {
        VStack (spacing:12){
            HStack (spacing:12){
                Image(systemName: address.icon)
                    .font(.title3)
                VStack (alignment: .leading, spacing: 2){
                    Text(address.name)
                        .font(.headline)
                    Text(address.subName)
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.7))
                    
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.black.opacity(0.7))
                    .padding(.leading)
            }
            Divider()
        }
    }
}

struct VendoredUberEatsDeliveryOptionView:View {
    var deliveryOptionsDatas:[VendoredUberEatsDeliveryOptionResponse] = deliveryOptionsData
    @State var selectedId: UUID? = deliveryOptionsData.first?.id

    var body: some View {
        VStack (spacing:12){
            // title
            Text("Delivery Options")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            // list
            VStack (spacing:12){
                ForEach(deliveryOptionsDatas) { delivery in
                    VendoredUberEatsDeliveryOptionRowView(delivery: delivery, selectedId: $selectedId)
                }
            }
        }
    }
}

struct VendoredUberEatsDeliveryOptionRowView: View {
    var delivery: VendoredUberEatsDeliveryOptionResponse
    @Binding var selectedId: UUID?

    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                selectedId = delivery.id
            }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "moped")
                    .font(.title3)
                VStack(alignment: .leading) {
                    HStack {
                        Text(delivery.name)
                            .font(.headline)
                        Spacer()
                        Text(delivery.price)
                            .font(.subheadline)
                            .foregroundStyle(.black.opacity(0.8))
                    }
                    Text(delivery.subName)
                        .font(.subheadline)
                }
            }
            .foregroundStyle(.black)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(selectedId == delivery.id ? Color.black : Color.black.opacity(0.2),
                            lineWidth: selectedId == delivery.id ? 1.5 : 1)
            )
            .animation(.easeInOut, value: selectedId)
        }
    }
}

struct VendoredUberEatsOrderSummaryView:View {
    var cart:VendoredUberEatsCartResponse
    var body: some View {
        VStack (spacing:12){
            // title
            Text("Order summary")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            // content info
            HStack (spacing:12){
                KFImage(URL(string: cart.restaurant.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 0) {
                    Text(cart.restaurant.name)
                        .font(.headline)
                        .foregroundStyle(.black)
                    Text("\(cart.itemCount) items")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.8))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.black.opacity(0.7))
                    .padding(.leading)
            }
           
            // divider
            Divider()
        }
    }
}

struct VendoredUberEatsPromotionView:View {
    var body: some View {
        VStack {
            // content
            HStack(spacing: 12) {
                Image(systemName: "tag")
                    .font(.title3)
                VStack(alignment: .leading, spacing: 0) {
                    Text("One promotion applied")
                        .font(.headline)
                    Text("$5 off")
                        .font(.subheadline)
                        .foregroundStyle(Color.vendoredUberEatsVendoredUberEatsPrimary)
                    Text("May exclude alcohol or other restriction")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.8))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.black.opacity(0.7))
                    .padding(.leading)
            }
            .foregroundStyle(.black)
            
            // divider
            Divider()
        }
    }
}

struct VendoredUberEatsTotalSummaryView:View {
    var cart:VendoredUberEatsCartResponse
    var promotionPrice:Double = 5.00
    var body: some View {
        VStack (spacing:8){
            // sub total
            HStack {
                Text("Subtotal")
                Spacer()
                Text(cart.totalPrice)
                    .foregroundStyle(.black.opacity(0.6))
            }
            .font(.headline)
            // promotion
            HStack {
                Text("Promotion")
                Spacer()
                Text(String(format: "-$%.2f", promotionPrice))
                    .foregroundStyle(Color.vendoredUberEatsVendoredUberEatsPrimary.opacity(0.7))

            }
            .font(.headline)
            // delivery fee
            HStack {
                Text("Delivery fee")
                Spacer()
                Text("$0.00")
                    .foregroundStyle(.black.opacity(0.6))
            }
            .font(.headline)
            // total
            HStack {
                Text("Total")
                    .font(.headline)
                Spacer()
                Text(String(format: "$%.2f",
                    (Double(cart.totalPrice.replacingOccurrences(of: "$", with: "")) ?? 0.0) - promotionPrice
                ))
                .foregroundStyle(.black)
                .font(.title3)
                .fontWeight(.semibold)

            }
           
        }
    }
}

struct VendoredUberEatsMasterCardView:View {
    var body: some View {
        HStack (spacing:12){
            Image("mastercard-icon")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
            Text("Mastercard****4320")
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.black.opacity(0.7))
                .padding(.leading)
        }
    }
}
