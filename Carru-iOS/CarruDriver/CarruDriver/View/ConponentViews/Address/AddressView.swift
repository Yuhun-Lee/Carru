//
//  AddressView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import SwiftUI

struct AddressView: View {
    var title: String
    @Bindable var viewModel: AddressViewModel
    var confirmAction: ((String)->())?
    var confirmAction2: ((Warehouse)->())?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.pretendardTitle)
                .padding(.leading, 20)
            
            CarruTextField(
                text: $viewModel.searchKey,
                placeholder: "주소 검색",
                icon: "magnifyingglass"
            ) {
                if viewModel.listType == .addressSearch {
                    viewModel.searchAddress()
                } else if viewModel.listType == .warehouseSearch {
                    viewModel.searchWarehouse()
                }
                UIApplication.shared.hideKeyboard()
            }
            
            if viewModel.listType == .addressSearch {
                List(viewModel.addresses, id: \.self, selection: $viewModel.selectedAddress) { addressInfo in
                    AddressCellView(
                        isSelected: addressInfo == viewModel.selectedAddress,
                        address: addressInfo,
                        iconColor: .appTypeColor
                    )
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .padding(.horizontal, 12)
                .padding(.top, 12)
            } else if viewModel.listType == .warehouseSearch{
                List(viewModel.wareshouses, id: \.self, selection: $viewModel.selectedWarehouse) { warehouse in
                    AddressWarehouseCell(
                        isSelected: warehouse == viewModel.selectedWarehouse,
                        warehouse: warehouse,
                        iconColor: .appTypeColor
                    )
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .padding(.horizontal, 12)
                .padding(.top, 12)
            }
            
            Spacer()
            
            CarruButton {
                if viewModel.listType == .addressSearch {
                    guard
                        let newAddress = viewModel.selectedAddress,
                        let confirmAction
                    else { return }
                    confirmAction(newAddress)
                } else if viewModel.listType == .warehouseSearch {
                    guard
                        let selectedWarehouse = viewModel.selectedWarehouse,
                        let confirmAction2
                    else { return }
                    confirmAction2(selectedWarehouse)
                }
            } label: {
                Text(title)
            }
        }
        .padding(.top, 24)
    }
}
