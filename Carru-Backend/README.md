# Carru-Backend

<div align="center">

![Java](https://img.shields.io/badge/Java-17+-007396?style=flat-square&logo=java&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3.5-6DB33F?style=flat-square&logo=spring-boot&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0+-4479A1?style=flat-square&logo=mysql&logoColor=white)
![JWT](https://img.shields.io/badge/JWT-000000?style=flat-square&logo=json-web-tokens&logoColor=white)
![Gradle](https://img.shields.io/badge/Gradle-7.0+-02303A?style=flat-square&logo=gradle&logoColor=white)

**AI 기반 화물 물류 매칭 플랫폼의 Spring Boot REST API 서버**

[아키텍처](#아키텍처) • [API 문서](#api-엔드포인트) • [데이터베이스](#데이터베이스-설계) • [보안](#보안-및-인증) • [배포](#배포)

</div>

---

## 📋 목차

- [프로젝트 개요](#-프로젝트-개요)
- [핵심 기능](#-핵심-기능)
- [기술 스택](#-기술-스택)
- [아키텍처](#-아키텍처)
- [프로젝트 구조](#-프로젝트-구조)
- [데이터베이스 설계](#-데이터베이스-설계)
- [API 엔드포인트](#-api-엔드포인트)
- [보안 및 인증](#-보안-및-인증)
- [설치 및 실행](#-설치-및-실행)
- [API 문서](#-api-문서-swagger)
- [배포](#-배포)

---

## 🎯 프로젝트 개요

Carru-Backend는 **화물 운송 산업의 디지털 혁신**을 위한 RESTful API 서버입니다. 화주(Owner), 기사(Driver), 관리자(Manager) 간의 효율적인 매칭을 통해 빈 차량 운행을 줄이고 물류 비용을 절감합니다.

### 핵심 가치

- **비용 절감**: 공차율 40% → 20% 이하로 감소 목표
- **시간 단축**: 수동 매칭 2-3일 → 즉시 자동 매칭
- **투명성**: 가격, 거리, 기사 정보 실시간 공개
- **확장성**: 마이크로서비스 전환 가능한 계층형 아키텍처

---

## ✨ 핵심 기능

### 1. 역할 기반 멀티 테넌트 시스템

#### 🚛 기사(Driver) 기능
- **물류 매칭 리스트 조회**: 필터링 (무게, 거리, 가격, 지역)
- **경로 기반 예약**: 출발-도착 간 최대 3개 경유지 설정
- **물류 기반 예약**: 특정 화물에 대한 직접 예약
- **상태 관리**: 운송 시작/일시정지/완료 처리
- **위치 관리**: 차고지 위치 등록 및 수정

#### 📦 화주(Owner) 기능
- **물류 등록**: 화물 정보, 창고, 목적지, 가격 설정
- **물류 관리**: 승인 대기/승인 완료 물류 조회
- **창고 검색**: 키워드 기반 창고 검색
- **매칭 모니터링**: 내 물류에 매칭된 기사 확인

#### 🛡️ 관리자(Manager) 기능
- **사용자 승인**: 신규 가입자 검증 및 승인
- **물류 승인**: 등록된 화물 검수 및 승인
- **전체 현황 조회**: 사용자/물류/매칭 통합 대시보드
- **매칭 상세 모니터링**: 기사-물류-경로 상세 추적

### 2. 지능형 매칭 시스템

- **거리 기반 필터링**: 창고로부터 30km 이내 기사 우선 매칭
- **무게 제한**: 기사의 차량 적재 용량 고려
- **가격 최적화**: 거리 + 무게 기반 자동 가격 산정
- **AI 통합**: Carru-AI 서버와 연동하여 최적 경로 제안

### 3. 실시간 상태 추적

```
물류 등록 → 관리자 승인 → 기사 매칭 → 운송 시작 → 운송 중 → 운송 완료
   ↓           ↓             ↓           ↓          ↓           ↓
WAITING → APPROVED → DRIVER_TODO → DRIVER_INPROGRESS → DRIVER_FINISHED
```

---

## 🛠 기술 스택

### Backend Framework
```
Spring Boot 3.3.5  |  Java 17+  |  Gradle 7.0+
```

### 핵심 라이브러리

| 카테고리 | 기술 | 버전 | 용도 |
|---------|------|------|------|
| **Framework** | Spring Boot | 3.3.5 | 애플리케이션 프레임워크 |
| **ORM** | Spring Data JPA | 3.3.5 | 데이터 접근 계층 |
| | Hibernate | 6.4+ | JPA 구현체 |
| | QueryDSL | 5.0.0 | 타입 세이프 쿼리 |
| **Database** | MySQL Connector-J | 8.0+ | MySQL 드라이버 |
| **Security** | Spring Security | 6.3+ | 인증/인가 |
| | JJWT | 0.11.5 | JWT 토큰 생성/검증 |
| **API Documentation** | SpringDoc OpenAPI | 2.2.0 | Swagger UI |
| **Utility** | Lombok | 1.18+ | 보일러플레이트 코드 제거 |
| **Validation** | Jakarta Validation | 3.0+ | 입력 데이터 검증 |
| **Testing** | JUnit 5 | 5.10+ | 단위 테스트 |

### 데이터베이스
- **MySQL 8.0+**: 관계형 데이터 저장
- **JPA/Hibernate**: ORM을 통한 객체-관계 매핑
- **QueryDSL**: 복잡한 쿼리 처리

---

## 🏗 아키텍처

### Layered Architecture (계층형 아키텍처)

```
┌─────────────────────────────────────────────────────────────┐
│                     Presentation Layer                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   User       │  │   Driver     │  │   Manager    │      │
│  │  Controller  │  │  Controller  │  │  Controller  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└───────────────────────────┬─────────────────────────────────┘
                            │
┌───────────────────────────┴─────────────────────────────────┐
│                      Business Layer                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   User       │  │   Driver     │  │   Manager    │      │
│  │   Service    │  │   Service    │  │   Service    │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│          │                  │                  │             │
│  ┌───────┴──────────────────┴──────────────────┴───────┐   │
│  │              JwtTokenProvider                        │   │
│  │              PriceService                            │   │
│  └──────────────────────────────────────────────────────┘   │
└───────────────────────────┬─────────────────────────────────┘
                            │
┌───────────────────────────┴─────────────────────────────────┐
│                    Persistence Layer                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   User       │  │   Product    │  │  Warehouse   │      │
│  │  Repository  │  │  Repository  │  │  Repository  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │          QueryDSL Custom Implementations           │    │
│  └────────────────────────────────────────────────────┘    │
└───────────────────────────┬─────────────────────────────────┘
                            │
┌───────────────────────────┴─────────────────────────────────┐
│                      Database Layer                          │
│                  ┌──────────────────┐                        │
│                  │   MySQL 8.0+     │                        │
│                  └──────────────────┘                        │
└──────────────────────────────────────────────────────────────┘
```

### Security Filter Chain

```
HTTP Request
     ↓
┌──────────────────────────────────┐
│ JwtAuthenticationFilter          │
│  - Token 추출 (X-AUTH-TOKEN)     │
│  - Token 검증                     │
│  - SecurityContext 설정           │
└────────────┬─────────────────────┘
             ↓
┌──────────────────────────────────┐
│ Spring Security Filter Chain     │
│  - Authentication 확인            │
│  - Authorization 검증             │
└────────────┬─────────────────────┘
             ↓
        Controller
```

### 의존성 흐름

```
Controller → Service → Repository → Entity → Database
     ↓          ↓          ↓           ↓
    DTO  →  Domain  →   JPA   →  QueryDSL
```

---

## 📂 프로젝트 구조

```
src/main/java/capstone/carru/
├── 🚀 CarruApplication.java                    # Spring Boot 진입점
│
├── 🔧 config/                                   # 설정 클래스
│   ├── SecurityConfig.java                      # Spring Security + JWT 설정
│   ├── SwaggerConfig.java                       # OpenAPI/Swagger 설정
│   └── JpaConfig.java                           # JPA Auditing 설정
│
├── 🌐 controller/                               # REST API 컨트롤러
│   ├── UserController.java                      # 사용자 인증 및 프로필
│   ├── DriverController.java                    # 기사 전용 API
│   ├── ShipperController.java                   # 화주 전용 API
│   └── ManagerController.java                   # 관리자 전용 API
│
├── 💼 service/                                  # 비즈니스 로직
│   ├── UserService.java                         # 사용자 관리
│   ├── DriverService.java                       # 기사 매칭/예약
│   ├── ShipperService.java                      # 화주 물류 관리
│   ├── ManagerService.java                      # 관리자 승인/모니터링
│   ├── PriceService.java                        # 가격 계산
│   └── JwtTokenProvider.java                    # JWT 토큰 생성/검증
│
├── 🗄️ entity/                                   # JPA 엔티티
│   ├── User.java                                # 사용자 (기사/화주/관리자)
│   ├── Product.java                             # 물류 화물
│   ├── ProductReservation.java                  # 물류 예약
│   ├── ProductRouteReservation.java             # 경로 예약
│   ├── Warehouse.java                           # 창고
│   ├── StopOver.java                            # 경유지
│   ├── Price.java                               # 가격 규칙
│   ├── BaseTimeEntity.java                      # Auditing 베이스
│   └── status/                                  # 열거형
│       ├── UserStatus.java                      # DRIVER, OWNER, MANAGER
│       └── ProductStatus.java                   # APPROVED, WAITING, etc.
│
├── 🗂️ repository/                               # 데이터 접근 계층
│   ├── user/
│   │   ├── UserRepository.java
│   │   ├── UserRepositoryCustom.java            # QueryDSL 인터페이스
│   │   └── UserRepositoryImpl.java              # QueryDSL 구현
│   ├── product/
│   │   ├── ProductRepository.java
│   │   ├── ProductRepositoryCustom.java
│   │   └── ProductRepositoryImpl.java
│   ├── productReservation/
│   │   ├── ProductReservationRepository.java
│   │   ├── ProductReservationRepositoryCustom.java
│   │   └── ProductReservationRepositoryImpl.java
│   ├── productRouteReservation/
│   │   ├── ProductRouteReservationRepository.java
│   │   ├── ProductRouteReservationRepositoryCustom.java
│   │   └── ProductRouteReservationRepositoryImpl.java
│   ├── stopOver/
│   │   ├── StopOverRepository.java
│   │   ├── StopOverRepositoryCustom.java
│   │   └── StopOverRepositoryImpl.java
│   ├── WarehouseRepository.java
│   └── PriceRepository.java
│
├── 📦 dto/                                      # 데이터 전송 객체
│   ├── ApiResponse.java                         # 공통 API 응답 래퍼
│   ├── ErrorCode.java                           # 에러 코드 정의
│   ├── User/
│   │   ├── SignUpRequestDTO.java
│   │   ├── LoginRequestDTO.java
│   │   ├── LoginResponseDTO.java
│   │   └── UserProfileResponseDTO.java
│   ├── driver/
│   │   ├── LogisticMatchingRequestDTO.java
│   │   ├── LogisticMatchingResponseDTO.java
│   │   ├── RouteMatchingRequestDTO.java
│   │   ├── RouteMatchingResponseDTO.java
│   │   └── ReservationListResponseDTO.java
│   ├── shipper/
│   │   ├── LogisticsRegisterRequestDTO.java
│   │   ├── LogisticsListResponseDTO.java
│   │   └── WarehouseSearchResponseDTO.java
│   └── manager/
│       ├── UserApprovalListResponseDTO.java
│       ├── LogisticsApprovalListResponseDTO.java
│       └── MatchingDetailResponseDTO.java
│
├── 🔐 filter/
│   └── JwtAuthenticationFilter.java             # JWT 필터
│
├── ⚠️ exception/                                # 예외 처리
│   ├── GeneralException.java                    # 기본 예외
│   ├── NotFoundException.java                   # 404 예외
│   ├── InvalidException.java                    # 400 예외
│   ├── InternalServerException.java             # 500 예외
│   ├── JwtAuthenticationEntryPoint.java         # JWT 인증 실패
│   └── advice/
│       └── ExceptionControllerAdvice.java       # 전역 예외 핸들러
│
└── src/main/resources/
    └── application.yml                          # 애플리케이션 설정
```

---

## 🗃 데이터베이스 설계

### ERD (Entity Relationship Diagram)

```
┌─────────────────┐
│     users       │
├─────────────────┤
│ user_id (PK)    │──┐
│ email           │  │
│ password        │  │
│ name            │  │
│ phone           │  │
│ user_status     │  │ (DRIVER, OWNER, MANAGER)
│ address         │  │
│ latitude        │  │
│ longitude       │  │
│ approved_date   │  │
│ created_date    │  │
│ modified_date   │  │
└─────────────────┘  │
         │           │
         │ 1:N       │ 1:N
         ↓           │
┌─────────────────┐  │
│   warehouses    │  │
├─────────────────┤  │
│ warehouse_id(PK)│  │
│ user_id (FK)    │←─┘
│ name            │
│ address         │
│ latitude        │
│ longitude       │
└─────────────────┘
         │
         │ 1:N
         ↓
┌──────────────────────┐
│      products        │
├──────────────────────┤
│ product_id (PK)      │──┐
│ warehouse_id (FK)    │  │
│ name                 │  │
│ destination_address  │  │
│ destination_latitude │  │
│ destination_longitud │  │
│ weight               │  │
│ price                │  │
│ deadline             │  │
│ status               │  │ (APPROVED, WAITING, etc.)
│ operation_distance   │  │
│ created_date         │  │
└──────────────────────┘  │
         │                │
         │ 1:N            │ N:1
         ↓                │
┌──────────────────────────┐
│  product_reservations    │
├──────────────────────────┤
│ product_reservation_id(PK)│
│ user_id (FK)             │←─┐
│ product_id (FK)          │←─┘
│ created_date             │
└──────────────────────────┘

┌─────────────────────────────────┐
│ product_route_reservations      │
├─────────────────────────────────┤
│ product_route_reservation_id(PK)│──┐
│ user_id (FK)                    │  │
│ departure_address               │  │
│ departure_latitude              │  │
│ departure_longitude             │  │
│ destination_address             │  │
│ destination_latitude            │  │
│ destination_longitude           │  │
│ estimated_time                  │  │
│ like_money_rate                 │  │ (수익 선호도)
│ like_short_distance_rate        │  │ (단거리 선호도)
│ max_weight                      │  │
│ min_weight                      │  │
│ created_date                    │  │
└─────────────────────────────────┘  │
                                     │
                                     │ 1:N
                                     ↓
┌────────────────────────────┐
│        stop_overs          │
├────────────────────────────┤
│ stop_over_id (PK)          │
│ product_id (FK)            │
│ route_reservation_id (FK)  │
│ created_date               │
└────────────────────────────┘

┌─────────────────┐
│     prices      │
├─────────────────┤
│ price_id (PK)   │
│ distance        │
│ weight          │
│ price           │
└─────────────────┘
```

### 주요 엔티티 설명

#### 1. User (사용자)
```java
@Entity
@Table(name = "users")
public class User extends BaseTimeEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;

    @Column(unique = true, nullable = false)
    private String email;

    @Enumerated(EnumType.STRING)
    private UserStatus userStatus;  // DRIVER, OWNER, MANAGER

    // 위치 정보 (차고지 또는 사무실)
    private Double latitude;
    private Double longitude;

    @OneToMany(mappedBy = "user")
    private List<Warehouse> warehouses;
}
```

#### 2. Product (물류 화물)
```java
@Entity
@Table(name = "products")
public class Product extends BaseTimeEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long productId;

    @ManyToOne
    @JoinColumn(name = "warehouse_id")
    private Warehouse warehouse;

    @Enumerated(EnumType.STRING)
    private ProductStatus status;  // WAITING, APPROVED, DRIVER_TODO, etc.

    // 목적지 정보
    private Double destinationLatitude;
    private Double destinationLongitude;

    private Integer weight;
    private Integer price;
    private LocalDateTime deadline;
}
```

#### 3. ProductRouteReservation (경로 예약)
```java
@Entity
public class ProductRouteReservation extends BaseTimeEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long productRouteReservationId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    // 기사의 주 경로
    private Double departureLatitude;
    private Double departureLongitude;
    private Double destinationLatitude;
    private Double destinationLongitude;

    // 기사 선호도
    private Integer likeMoneyRate;         // 수익 중심 (0-100)
    private Integer likeShortDistanceRate; // 단거리 중심 (0-100)

    @OneToMany(mappedBy = "productRouteReservation")
    private List<StopOver> stopOvers;  // 경유지 목록 (최대 3개)
}
```

### 인덱스 전략

```sql
-- 자주 검색되는 컬럼에 인덱스 추가
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_user_status ON users(user_status);
CREATE INDEX idx_product_status ON products(status);
CREATE INDEX idx_warehouse_location ON warehouses(latitude, longitude);
CREATE INDEX idx_product_location ON products(destination_latitude, destination_longitude);
```

---

## 🌐 API 엔드포인트

### 인증 & 사용자 관리

#### POST `/v1/user/sign-up`
회원가입
```json
Request:
{
  "email": "driver@example.com",
  "password": "password123",
  "name": "홍길동",
  "phone": "010-1234-5678",
  "userStatus": 0,  // 0: DRIVER, 1: OWNER, 2: MANAGER
  "address": "서울시 강남구",
  "latitude": 37.4979,
  "longitude": 127.0276
}

Response:
{
  "isSuccess": true,
  "code": "2000",
  "message": "성공",
  "result": {
    "userId": 1,
    "email": "driver@example.com",
    "name": "홍길동"
  }
}
```

#### POST `/v1/user/login`
로그인 (JWT 토큰 발급)
```json
Request:
{
  "email": "driver@example.com",
  "password": "password123"
}

Response:
{
  "isSuccess": true,
  "code": "2000",
  "message": "로그인 성공",
  "result": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "userStatus": "DRIVER"
  }
}
```

#### GET `/v1/user/profile`
프로필 조회 (인증 필요)
```
Headers:
  X-AUTH-TOKEN: {JWT_TOKEN}

Response:
{
  "isSuccess": true,
  "code": "2000",
  "message": "성공",
  "result": {
    "userId": 1,
    "email": "driver@example.com",
    "name": "홍길동",
    "phone": "010-1234-5678",
    "address": "서울시 강남구",
    "userStatus": "DRIVER"
  }
}
```

---

### 기사(Driver) API

#### POST `/v1/driver/logisticsMatchingList`
매칭 가능한 물류 리스트 조회
```json
Request:
{
  "warehouseKeyword": "서울",
  "maxWeight": 5000,
  "minWeight": 1000,
  "sortPrice": true,           // 가격순 정렬
  "sortOperationDistance": false,
  "userLat": 37.4979,
  "userLon": 127.0276
}

Response:
{
  "isSuccess": true,
  "code": "2000",
  "message": "성공",
  "result": [
    {
      "productId": 10,
      "productName": "전자제품",
      "warehouseName": "서울 물류센터",
      "warehouseAddress": "서울시 강남구 ...",
      "destinationAddress": "경기도 성남시 ...",
      "weight": 2500,
      "price": 150000,
      "distance": 25.5,
      "deadline": "2024-12-31T18:00:00"
    }
  ]
}
```

#### POST `/v1/driver/logisticsMatching/{logisticsMatchingId}`
특정 물류 예약
```
Headers:
  X-AUTH-TOKEN: {JWT_TOKEN}

Response:
{
  "isSuccess": true,
  "code": "2000",
  "message": "예약 성공",
  "result": {
    "reservationId": 5,
    "productId": 10,
    "status": "DRIVER_TODO"
  }
}
```

#### POST `/v1/driver/routeMatching`
경로 기반 예약 생성
```json
Request:
{
  "departureAddress": "서울시 강남구",
  "departureLat": 37.4979,
  "departureLon": 127.0276,
  "destinationAddress": "부산시 해운대구",
  "destinationLat": 35.1595,
  "destinationLon": 129.1600,
  "estimatedTime": "2024-12-25T09:00:00",
  "likeMoneyRate": 70,
  "likeShortDistanceRate": 30,
  "maxWeight": 5000,
  "minWeight": 500
}

Response:
{
  "isSuccess": true,
  "code": "2000",
  "message": "경로 예약 생성 완료",
  "result": {
    "routeReservationId": 3,
    "recommendedStopOvers": [
      {
        "stopOverId": 1,
        "productId": 15,
        "productName": "가전제품",
        "address": "대전시 유성구",
        "additionalProfit": 80000
      }
    ]
  }
}
```

#### GET `/v1/driver/routeMatching/reservingList?listType=0`
예약 리스트 조회
- `listType`: 0 (진행 중), 1 (완료)

#### PATCH `/v1/driver/routeMatching/{routeMatchingId}?progressType=0`
운송 상태 업데이트
- `progressType`: 0 (시작), 1 (일시정지), 2 (완료)

---

### 화주(Shipper/Owner) API

#### POST `/v1/shipper/logistics`
물류 등록
```json
Request:
{
  "warehouseId": 5,
  "productName": "전자제품",
  "destinationAddress": "부산시 해운대구",
  "destinationLat": 35.1595,
  "destinationLon": 129.1600,
  "weight": 3000,
  "price": 200000,
  "deadline": "2024-12-31T18:00:00"
}

Response:
{
  "isSuccess": true,
  "code": "2000",
  "message": "물류 등록 완료 (승인 대기)",
  "result": {
    "productId": 20,
    "status": "WAITING"
  }
}
```

#### GET `/v1/shipper/logistics/pending`
승인 대기 중인 내 물류 조회

#### GET `/v1/shipper/logistics/approved`
승인된 내 물류 조회

#### GET `/v1/shipper/search?keyword=서울`
창고 검색

---

### 관리자(Manager) API

#### GET `/v1/manager/approvingList/user`
승인 대기 중인 사용자 목록

#### PATCH `/v1/manager/approvingList/user/{userId}`
사용자 승인
```json
Request:
{
  "approved": true
}

Response:
{
  "isSuccess": true,
  "code": "2000",
  "message": "사용자 승인 완료"
}
```

#### GET `/v1/manager/approvingList/logistics`
승인 대기 중인 물류 목록

#### PATCH `/v1/manager/approvingList/logistics/{productId}`
물류 승인

#### GET `/v1/manager/approvedList/driver/logisticsMatching/{userId}`
특정 기사의 물류 매칭 현황

#### GET `/v1/manager/approvedList/driver/routeMatching/{userId}`
특정 기사의 경로 매칭 현황

---

## 🔐 보안 및 인증

### JWT (JSON Web Token) 인증

#### 토큰 구조
```
Header.Payload.Signature

Header:
{
  "alg": "HS256",
  "typ": "JWT"
}

Payload:
{
  "sub": "user@example.com",
  "userStatus": "DRIVER",
  "iat": 1700000000,
  "exp": 1700086400
}
```

#### 인증 흐름
```
1. 클라이언트 → POST /v1/user/login (email, password)
2. 서버 → 사용자 검증 후 JWT 토큰 생성
3. 클라이언트 → 토큰을 저장 (iOS Keychain, Android Keystore)
4. 이후 모든 요청에 Header 추가: X-AUTH-TOKEN: {JWT_TOKEN}
5. 서버 → JwtAuthenticationFilter에서 토큰 검증
6. 검증 성공 → SecurityContext에 인증 정보 저장 → Controller 진입
```

### Spring Security 설정

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) {
        http
            .csrf().disable()  // REST API이므로 CSRF 비활성화
            .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)  // JWT 사용
            .and()
            .authorizeHttpRequests()
                .requestMatchers("/v1/user/sign-up", "/v1/user/login").permitAll()
                .requestMatchers("/swagger-ui/**", "/v3/api-docs/**").permitAll()
                .anyRequest().authenticated()  // 나머지는 인증 필요
            .and()
            .addFilterBefore(
                jwtAuthenticationFilter,
                UsernamePasswordAuthenticationFilter.class
            );

        return http.build();
    }
}
```

### 비밀번호 암호화

```java
@Bean
public PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();  // BCrypt 해시 알고리즘
}

// 회원가입 시
String encodedPassword = passwordEncoder.encode(rawPassword);
user.setPassword(encodedPassword);

// 로그인 시
if (!passwordEncoder.matches(rawPassword, user.getPassword())) {
    throw new InvalidException("비밀번호가 일치하지 않습니다.");
}
```

---

## 🚀 설치 및 실행

### 1. 필수 요구사항
```
- Java 17 이상
- Gradle 7.0 이상
- MySQL 8.0 이상
```

### 2. 레포지토리 클론
```bash
git clone https://github.com/Yuhun-Lee/Carru.git
cd Carru/Carru-Backend
```

### 3. MySQL 데이터베이스 생성
```sql
CREATE DATABASE carru_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'carru_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON carru_db.* TO 'carru_user'@'localhost';
FLUSH PRIVILEGES;
```

### 4. 환경 변수 설정

`src/main/resources/application-local-secret.yml` 파일 생성:

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/carru_db?serverTimezone=Asia/Seoul
    username: carru_user
    password: your_password
    driver-class-name: com.mysql.cj.jdbc.Driver

  jpa:
    hibernate:
      ddl-auto: update  # 개발: update, 프로덕션: validate
    show-sql: true
    properties:
      hibernate:
        format_sql: true
        dialect: org.hibernate.dialect.MySQL8Dialect

jwt:
  secret: your-very-secure-secret-key-min-256-bits
  expiration: 86400000  # 24시간 (밀리초)
```

### 5. 빌드 및 실행

#### Gradle로 빌드
```bash
./gradlew clean build
```

#### 애플리케이션 실행
```bash
./gradlew bootRun
```

또는

```bash
java -jar build/libs/carru-0.0.1-SNAPSHOT.jar
```

### 6. 서버 확인
```
서버: http://localhost:8080
Swagger UI: http://localhost:8080/swagger-ui/index.html
```

---

## 📚 API 문서 (Swagger)

### Swagger UI 접속
```
http://localhost:8080/swagger-ui/index.html
```

### OpenAPI JSON
```
http://localhost:8080/v3/api-docs
```

### Swagger 설정
```java
@Configuration
public class SwaggerConfig {
    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
            .info(new Info()
                .title("Carru API")
                .description("화물 물류 매칭 플랫폼 REST API")
                .version("1.0.0"))
            .addSecurityItem(new SecurityRequirement().addList("JWT"))
            .components(new Components()
                .addSecuritySchemes("JWT", new SecurityScheme()
                    .name("X-AUTH-TOKEN")
                    .type(SecurityScheme.Type.APIKEY)
                    .in(SecurityScheme.In.HEADER)));
    }
}
```

---

## 🌍 배포

### AWS EC2 배포 스크립트 (`deploy.sh`)

```bash
#!/bin/bash

PROJECT_DIR="/home/ec2-user/app/project"
JAR_FILE="$PROJECT_DIR/build/libs/*.jar"

echo ">>> Git Pull"
cd $PROJECT_DIR
git pull origin main

echo ">>> Gradle Build"
./gradlew clean build

echo ">>> Kill Previous Application"
CURRENT_PID=$(pgrep -f carru)
if [ -z "$CURRENT_PID" ]; then
    echo ">>> No running application"
else
    echo ">>> Kill Process: $CURRENT_PID"
    kill -15 $CURRENT_PID
    sleep 5
fi

echo ">>> Start New Application"
nohup java -jar $JAR_FILE > /dev/null 2>&1 &

echo ">>> Deployment Complete"
```

### 실행
```bash
chmod +x deploy.sh
./deploy.sh
```

### 프로덕션 환경 변수

`application-prod.yml`:
```yaml
spring:
  datasource:
    url: jdbc:mysql://${RDS_HOSTNAME}:${RDS_PORT}/${RDS_DB_NAME}
    username: ${RDS_USERNAME}
    password: ${RDS_PASSWORD}

  jpa:
    hibernate:
      ddl-auto: validate  # 프로덕션에서는 validate 사용
    show-sql: false

server:
  port: 8080

logging:
  level:
    root: INFO
    capstone.carru: DEBUG
```

---

## 🧪 테스트

### 단위 테스트 실행
```bash
./gradlew test
```

### 테스트 커버리지
```bash
./gradlew jacocoTestReport
```

---

## 📈 성능 최적화

### 1. QueryDSL을 활용한 효율적 쿼리
```java
@Override
public List<Product> findAvailableProducts(
    String warehouseKeyword,
    Integer maxWeight,
    Double userLat,
    Double userLon
) {
    return queryFactory
        .selectFrom(product)
        .join(product.warehouse, warehouse).fetchJoin()
        .where(
            warehouse.name.contains(warehouseKeyword),
            product.weight.loe(maxWeight),
            product.status.eq(ProductStatus.APPROVED),
            withinDistance(warehouse, userLat, userLon, 30.0)  // 30km 이내
        )
        .orderBy(product.price.desc())
        .limit(50)
        .fetch();
}
```

### 2. 인덱스 활용
- 자주 조회되는 컬럼에 인덱스 추가
- 복합 인덱스로 쿼리 성능 향상

### 3. N+1 문제 해결
- `@EntityGraph` 또는 `fetch join` 사용
- 지연 로딩 전략 적절히 활용

---

## 🔄 버전 관리

### Git Flow
```
main (프로덕션)
  └── develop (개발)
        ├── feature/user-authentication
        ├── feature/driver-matching
        └── feature/manager-approval
```

### 커밋 컨벤션
```
feat: 새로운 기능 추가
fix: 버그 수정
docs: 문서 수정
refactor: 코드 리팩토링
test: 테스트 코드 추가
chore: 빌드 설정 변경
```

---

## 📄 라이선스

This project is licensed under the MIT License.

---

## 👥 개발팀

- **Backend Developer**: Capstone Team
- **iOS Developer**: [이주훈](https://github.com/Yuhun-Lee)
- **AI/ML Engineer**: Capstone Team

---

## 🔗 관련 프로젝트

- [Carru-iOS](../Carru-iOS/README.md) - SwiftUI 기반 iOS 네이티브 앱
- [Carru-AI](../Carru-AI-develop/README.md) - XGBoost 기반 경로 최적화 AI

---

<div align="center">

**Made with ❤️ by Carru Team**

[⬆ Back to Top](#carru-backend)

</div>
