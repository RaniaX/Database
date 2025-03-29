-- 创建机场表
CREATE TABLE AIRPORT (
    Airport_code INT PRIMARY KEY,
    Aname VARCHAR(100),
    City VARCHAR(100),
    Astate VARCHAR(100)
);

-- 创建航班表
CREATE TABLE FLIGHT (
    Flight_number VARCHAR(10) PRIMARY KEY,
    Airline VARCHAR(100),
    Weekdays INT
);

-- 创建飞机类型表
CREATE TABLE AIRPLANE_TYPE (
    Airplane_type_name VARCHAR(100) PRIMARY KEY,
    Max_sets INT NOT NULL,
    Company VARCHAR(100)
);

-- 创建飞机表
CREATE TABLE AIRPLANE (
    Airplane_id INT PRIMARY KEY,
    Total_number_of_seats INT NOT NULL,
    Airplane_type_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (Airplane_type_name) REFERENCES AIRPLANE_TYPE(Airplane_type_name)
);



-- 创建航班航段表
CREATE TABLE FLIGHT_LEG (
    Flight_number VARCHAR(10) NOT NULL,
    Leg_number INT NOT NULL,
    Departure_airport_code INT NOT NULL,
    Scheduled_departure_time TIMESTAMP,
    Arrival_airport_code INT NOT NULL,
    Scheduled_arrival_time TIMESTAMP,
    PRIMARY KEY (Flight_number, Leg_number),
    UNIQUE(Leg_number),
    FOREIGN KEY (Departure_airport_code) REFERENCES AIRPORT(Airport_code),
    FOREIGN KEY (Arrival_airport_code) REFERENCES AIRPORT(Airport_code),
    FOREIGN KEY (Flight_number) REFERENCES FLIGHT(Flight_number)
);

-- 创建航段实例表
CREATE TABLE LEG_INSTANCE (
    Flight_number VARCHAR(10) NOT NULL,
    Leg_number INT NOT NULL,
    LDate DATE,
    Number_of_available_seats INT,
    Airplane_id INT NOT NULL,
    Departure_airport_code INT NOT NULL,
    Departure_time TIMESTAMP,
    Arrival_airport_code INT NOT NULL,
    Arrival_time TIMESTAMP,
    PRIMARY KEY (Flight_number, Leg_number, LDate),
    UNIQUE(LDate),
    FOREIGN KEY (Flight_number) REFERENCES FLIGHT(Flight_number),
    FOREIGN KEY (Leg_number) REFERENCES FLIGHT_LEG(Leg_number),
    FOREIGN KEY (Airplane_id) REFERENCES AIRPLANE(Airplane_id),
    FOREIGN KEY (Departure_airport_code) REFERENCES AIRPORT(Airport_code),
    FOREIGN KEY (Arrival_airport_code) REFERENCES AIRPORT(Airport_code)
);

-- 创建票价表
CREATE TABLE FARE (
    Flight_number VARCHAR(10) NOT NULL,
    Fare_code INT NOT NULL,
    Amount FLOAT,
    Restrictions VARCHAR(100),
    PRIMARY KEY (Flight_number, Fare_code),
    FOREIGN KEY (Flight_number) REFERENCES FLIGHT(Flight_number)
);


-- 创建可降落关系表
CREATE TABLE CAN_LAND (
    Airplane_type_name VARCHAR(100) NOT NULL,
    Airport_code INT NOT NULL,
    PRIMARY KEY (Airplane_type_name, Airport_code),
    FOREIGN KEY (Airplane_type_name) REFERENCES AIRPLANE_TYPE(Airplane_type_name),
    FOREIGN KEY (Airport_code) REFERENCES AIRPORT(Airport_code)
);


-- 创建座位预订表
CREATE TABLE SEAT_RESERVATION (
    Flight_number VARCHAR(10) NOT NULL,
    Leg_number INT NOT NULL,
    SDate DATE,
    Seat_number INT NOT NULL,
    Customer_name VARCHAR(100),
    Customer_phone VARCHAR(100),
    PRIMARY KEY (Flight_number, Leg_number, SDate, Seat_number),
    FOREIGN KEY (Flight_number) REFERENCES FLIGHT(Flight_number),
    FOREIGN KEY (Leg_number) REFERENCES FLIGHT_LEG(Leg_number),
    FOREIGN KEY (SDate) REFERENCES LEG_INSTANCE(LDate)
);    
