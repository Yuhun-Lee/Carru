//
//  MapFlexibleModalView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import SwiftUI
import CoreLocation

struct MapFlexibleModalView<Contents: View>: View {
    @Binding var currentLocation: Location
    @Binding var logistics: [Logistic]?
    @Binding var showPoiType: KakaoMapView.ShowPoiType
    @Binding var updateMyLocationEvent: Bool
    @State var currentHeight: CGFloat = 330
    @State var prevHeight: CGFloat = 330
    @State var dragedPoint: CGPoint = .zero
    @State var dragIsPossible: Bool = true
    let heightCandidates: [CGFloat] = [60, 330, 660]
    @ViewBuilder var contents: () -> Contents
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                Button {
                    currentLocation = LocationManager.shared.myLocation
                    showPoiType = .showMyLocation
                    updateMyLocationEvent.toggle()
                } label: {
                    Image(systemName: "location.circle")
                        .resizable()
                        .foregroundStyle(.black)
                        .frame(width: 35, height: 35)
                }
                .padding(.bottom, 5)
                .padding(.trailing, 5)
            }
            
            ZStack(alignment: .top){
                Rectangle()
                    .frame(height: 30)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 130, height: 5)
                    .foregroundStyle(.gray.opacity(0.5))
                    .padding(.top, 8)

            }
            .gesture(drag)
            
            contents() // 내부 뷰를 동적으로 할당해보자.
            
            Spacer()
        }
        .frame(height: currentHeight)
        .animation(.default, value: currentHeight)
        .background(.blue)
    }
}

/// Drag 분리
extension MapFlexibleModalView {
    // drag에 따른 Modal의 크기 제어
    private var drag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                guard dragIsPossible else { return }
                
                // 강제로 특정 위치로 가면, 초기화됨으로 이후 계산을 위해 한번 Skip
                if dragedPoint == .zero {
                    dragedPoint = gesture.location
                    return
                }
                
                // 속도가 너무 빠르면, 크기 조정
                if gesture.velocity.height < -1500 {
                    switch prevHeight {
                    case heightCandidates[0]:
                        currentHeight = heightCandidates[1]
                        prevHeight = heightCandidates[1]
                    case heightCandidates[1]:
                        currentHeight = heightCandidates[2]
                        prevHeight = heightCandidates[2]
                    default:
                        currentHeight = heightCandidates[2]
                        prevHeight = heightCandidates[2]
                    }
                    dragIsPossible = false
                    return
                } else if gesture.velocity.height > 1500 {
                    switch prevHeight {
                    case heightCandidates[2]:
                        currentHeight = heightCandidates[1]
                        prevHeight = heightCandidates[1]
                    case heightCandidates[1]:
                        currentHeight = heightCandidates[0]
                        prevHeight = heightCandidates[0]
                    default:
                        currentHeight = heightCandidates[0]
                        prevHeight = heightCandidates[0]
                    }
                    dragIsPossible = false
                    return
                }
                
                // 이전 위치와 비교해 높이 계산
                let changeHeightValue = dragedPoint.y - gesture.location.y
                dragedPoint = gesture.location
                currentHeight = currentHeight + changeHeightValue
                
                // 최소 및 최대 높이 제한
                if currentHeight < heightCandidates[0] {
                    currentHeight = heightCandidates[0]
                    prevHeight = heightCandidates[0]
                    dragedPoint = .zero
                    dragIsPossible = false
                }
                if currentHeight > heightCandidates[2] {
                    currentHeight = heightCandidates[2]
                    prevHeight = heightCandidates[2]
                    dragedPoint = .zero
                    dragIsPossible = false
                }
            }
            .onEnded { gesture in
                var selectedIndex = 0 // 후보중에서 선택할 index
                var minDistance: CGFloat = .infinity
                // 가장 가까운 높이 선택
                heightCandidates.enumerated()
                    .forEach { index, element in
                        if abs(element - currentHeight) < minDistance {
                            selectedIndex = index
                            minDistance = abs(element - currentHeight)
                        }
                    }
                currentHeight = heightCandidates[selectedIndex]
                prevHeight = heightCandidates[selectedIndex]
                dragedPoint = .zero
                dragIsPossible = true
            }
    }
}

//#Preview {
//    @Previewable @State var currentLocation: Location = .init(latitude: 0, longitude: 0)
//    @Previewable @State var logistics: [Logistic]? = []
//    @Previewable @State var showPoiType: KakaoMapView.ShowPoiType = .showMyLocation
//    @Previewable @State var updateMyLocationEvent: Bool = true
//    
//    MapFlexibleModalView(
//        currentLocation: $currentLocation,
//        logistics: $logistics,
//        showPoiType: $showPoiType,
//        updateMyLocationEvent: $updateMyLocationEvent) {
//            Text("test")
//        }
//}
