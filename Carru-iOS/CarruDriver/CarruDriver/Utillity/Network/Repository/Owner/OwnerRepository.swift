//
//  OwnerRespository.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import Combine
import Moya
import CombineMoya
import Foundation

class OwnerRepository: BaseRepository {
    private let provider = MoyaProvider<OwnerAPI>()
    
    /// 20. 물류 등록
    func registerLogistics(request: RegisterLogisticsRequestDTO) -> AnyPublisher<CommonResponse, Error> {
        provider.requestPublisher(.registerLogistics(request: request))
            .tryMap {
                try self.decodeResponse(CommonResponse.self, from: $0)
            }
            .eraseToAnyPublisher()
    }
    
    /// 창고 검색
    func searchWarehouseList(keyword: String) -> AnyPublisher<[Warehouse], Error> {
        provider.requestPublisher(.searchWarehouseList(keyword: keyword))
            .tryMap {
                try self.decodeResponse(SearchWarehouseListResponseDTO.self, from: $0)
            }
            .map { $0.toWarehouseList() }
            .eraseToAnyPublisher()
    }
    
    /// 21. 미승인 물류 리스트 조회
    func unapprovedLogisticsList() -> AnyPublisher<[UnapprovedLogistics], Error> {
        provider.requestPublisher(.unapprovedLogisticsList)
            .tryMap {
                try self.decodeResponse(UnapprovedLogisticsListResponseDTO.self, from: $0)
            }
            .map { $0.toUnapprovedLogisticsList() }
            .eraseToAnyPublisher()
    }

    
    /// 22. 미승인 물류 상세조회
    func unapprovedLogisticDetail(logisticId: Int) -> AnyPublisher<UnapprovedLogisticDetail, Error> {
        provider.requestPublisher(.unapprovedLogisticDetail(logisticId: logisticId))
            .tryMap {
                try self.decodeResponse(UnapprovedLogisticDetailResponseDTO.self, from: $0)
            }
            .map { $0.toUnapprovedLogisticDetail() }
            .eraseToAnyPublisher()
    }

    
    /// 21(중복 번호). 미승인 물류 수정
    func fixUnapprovedLogistic(
        logisticId: Int,
        request: FixDeleteUnapprovedLogisticRequestDTO
    ) -> AnyPublisher<CommonResponse, Error> {
        provider.requestPublisher(.fixUnapprovedLogistic(logisticId: logisticId, request: request))
            .tryMap {
                try self.decodeResponse(CommonResponse.self, from: $0)
            }
            .eraseToAnyPublisher()
    }
    
    /// 21. 미승인 물류 삭제
    func deleteUnapprovedLogistic(
        logisticId: Int,
        request: FixDeleteUnapprovedLogisticRequestDTO
    ) -> AnyPublisher<CommonResponse, Error> {
        provider.requestPublisher(.deleteUnapprovedLogistic(logisticId: logisticId, request: request))
            .tryMap {
                try self.decodeResponse(CommonResponse.self, from: $0)
            }
            .eraseToAnyPublisher()
    }
    
    /// 31. 화주 - 승인된 물류 리스트 조회
    func approvedLogisticsList(type: ProgressType) -> AnyPublisher<[OwnerApprovedLogistic], Error> {
        provider.requestPublisher(.approvedLogisticsList(type: type))
            .tryMap {
                try self.decodeResponse(OwnerApprovedLogisticsListResponseDTO.self, from: $0)
            }
            .map { $0.toOwnerApprovedLogisticsList() }
            .eraseToAnyPublisher()
    }

    /// 32. 화주 - 승인된 물류 상세 조회
    func approvedLogisticDetail(
        logisticId: Int,
        type: ProgressType
    ) -> AnyPublisher<OwnerApprovedLogisticDetail, Error> {
        provider.requestPublisher(.approvedLogisticDetail(logisticId: logisticId, type: type))
            .tryMap {
                try self.decodeResponse(OwnerApprovedLogisticDetailResponseDTO.self, from: $0)
            }
            .map { $0.toOwnerApprovedLogisticDetail() }
            .eraseToAnyPublisher()
    }

}

