//
//  UserRespository.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Combine
import Moya
import CombineMoya
import Foundation

enum UserStatus: Int {
    case driver = 0
    case owner = 1
    case admin = 2
}

class UserRepository: BaseRepository {
    private let provider = MoyaProvider<UserAPI>()
    
    /// 1, 2. 회원가입
    func signUp(userStatus: UserStatus, signUpDTO: SignUpRequestDTO) -> AnyPublisher<Void, Error> {
        provider.requestPublisher(
            .signUp(
                userStatus: userStatus.rawValue,
                signUpRequest: signUpDTO
            )
        )
        .tryMap {
            try self.decodeResponse(CommonResponse.self, from: $0)
        }
        .map {
            logger.printOnDebug("회원가입 \($0.message)")
            return ()
        }
        .eraseToAnyPublisher()
    }
    
    /// 4,5,6. 로그인 받기(성공시 키체인 저장)
    func signIn(userStatus: UserStatus, signInDTO: SignInRequestDTO) -> AnyPublisher<Void, Error> {
        provider.requestPublisher(
            .signIn(
                userStatus: userStatus.rawValue,
                signInRequest: signInDTO
            )
        )
        .tryMap {
            try self.decodeResponse(SignInResponseDTO.self, from: $0)
        }
        .tryMap { response in
            do {
                logger.printOnDebug("토큰 저장 시도")
                try Keychain.addOrUpdateToken(kind: .accessToken, token: response.data.token)
            } catch {
                print(error.localizedDescription)
                throw error
            }
            return ()
        }
        .eraseToAnyPublisher()
    }
    
    /// 3. 프로필 받아오기
    func profile() -> AnyPublisher<Profile, Error> {
        provider.requestPublisher(.profile)
            .tryMap {
                try self.decodeResponse(ProfileResponseDTO.self, from: $0)
            }
            .map { responseDTO in
                responseDTO.toProfile() // ProfileResponseDTO를 Profile로 변환
            }
            .eraseToAnyPublisher()
    }
    
    /// 이름 변경
    func changeName(newName: String) -> AnyPublisher<CommonResponse, Error> {
        provider.requestPublisher(.changeName(newName: newName))
            .tryMap {
                try self.decodeResponse(CommonResponse.self, from: $0)
            }
            .eraseToAnyPublisher()
    }
    
    /// 29. 사용자 - 차고지/물류 창고 조회
    func userWarehouseList() -> AnyPublisher<WarehouseLocation, Error> {
        provider.requestPublisher(.userWarehouseList)
            .tryMap {
                try self.decodeResponse(UserWarehouseResponseDTO.self, from: $0)
            }
            .map { $0.toWarehouseLocation() }
            .eraseToAnyPublisher()
    }

    
    /// 30. 화물기사 - 차고지 변경
    func changeWareshouse(request: ChangeWarehouseRequestDTO) -> AnyPublisher<CommonResponse, Error> {
        provider.requestPublisher(.changeWareshouse(request: request))
            .tryMap {
                try self.decodeResponse(CommonResponse.self, from: $0)
            }
            .eraseToAnyPublisher()
    }
}

