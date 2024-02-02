CREATE SCHEMA airplaneEx;
GO

CREATE TABLE airplaneEx.Airport
(
    Airport_Code [NVARCHAR](50) NOT NULL , 
    City [NVARCHAR](50) NOT NULL,
    City_State [NVARCHAR](50) NOT NULL,
    Airport_Name [NVARCHAR](50) NOT NULL,
    PRIMARY KEY (Airport_Code)
);
GO


CREATE TABLE airplaneEx.Airplane_Type
(
    Type_Name [NVARCHAR](50) NOT NULL,
    Max_seats INT NOT NULL,
    Company [NVARCHAR](50) NOT NULL,
    PRIMARY KEY (Type_Name)
);
GO


CREATE TABLE airplaneEx.Can_Land
(
    FK_Type_Name [NVARCHAR](50) NOT NULL,
    FK_Airport_Code [NVARCHAR](50) NOT NULL,
    PRIMARY KEY (FK_Type_Name, FK_Airport_Code),
    FOREIGN KEY (FK_Type_Name) REFERENCES airplaneEx.Airplane_Type(Type_Name),
    FOREIGN KEY (FK_Airport_Code) REFERENCES airplaneEx.Airport(Airport_Code)
);
GO


CREATE TABLE airplaneEx.Airplane
(
    Airplane_Id [NVARCHAR](50) NOT NULL,
    Total_no_of_Seats INT NOT NULL,
    FK_Type_Name [NVARCHAR](50) NOT NULL,
    PRIMARY KEY (Airplane_Id),
    FOREIGN KEY (FK_Type_Name) REFERENCES airplaneEx.Airplane_Type(Type_Name)
);
GO

CREATE TABLE airplaneEx.Flight
(
    Flight_Number INT NOT NULL,
    Airline [NVARCHAR](50) NOT NULL,
    WeekDays [NVARCHAR](50) NOT NULL,
    PRIMARY KEY (Flight_Number)
);
GO


CREATE TABLE airplaneEx.Fare
(
    FK_Flight_Number INT NOT NULL,
    Dependent_Code INT NOT NULL,
    Amount INT NOT NULL,
    Restrictions [NVARCHAR](50) NOT NULL,
    PRIMARY KEY (FK_Flight_Number, Dependent_Code),
    FOREIGN KEY (FK_Flight_Number) REFERENCES airplaneEx.Flight(Flight_Number)
);
GO


CREATE TABLE airplaneEx.Flight_leg
(
    FK_Number INT NOT NULL,
    Dependent_Leg_no INT NOT NULL,
    FK_Arr_Airport_Code [NVARCHAR](50) NOT NULL,
    FK_Dep_Airport_Code [NVARCHAR](50) NOT NULL,
    Scheduled_Dep_Time datetime NOT NULL,
    Scheduled_Arr_Time datetime NOT NULL,

    PRIMARY KEY (FK_Number, Dependent_Leg_no),
    FOREIGN KEY (FK_Number) REFERENCES airplaneEx.Flight(Flight_Number),
    FOREIGN KEY (FK_Arr_Airport_Code) REFERENCES airplaneEx.Airport(Airport_Code),
    FOREIGN KEY (FK_Dep_Airport_Code) REFERENCES airplaneEx.Airport(Airport_Code)
);
GO


CREATE TABLE airplaneEx.Leg_Instance
(
    FK_Number INT NOT NULL,
    FK_Dependent_Leg_no INT NOT NULL,
    Dependent_Date date NOT NULL,
    No_of_avail_seats INT NOT NULL,
    FK_Airplane_Id [NVARCHAR](50) NOT NULL,
    FK_Arr_Airport_Code [NVARCHAR](50) NOT NULL,
    FK_Dep_Airport_Code [NVARCHAR](50) NOT NULL,
    Dep_Time datetime NOT NULL,
    Arr_Time datetime NOT NULL,
    
    PRIMARY KEY (FK_Number, FK_Dependent_Leg_no, Dependent_Date),
    FOREIGN KEY (FK_Number, FK_Dependent_Leg_no) REFERENCES airplaneEx.Flight_leg(FK_Number, Dependent_Leg_no),
    FOREIGN KEY (FK_Airplane_Id) REFERENCES airplaneEx.Airplane(Airplane_Id),
    FOREIGN KEY (FK_Arr_Airport_Code) REFERENCES airplaneEx.Airport(Airport_Code),
    FOREIGN KEY (FK_Dep_Airport_Code) REFERENCES airplaneEx.Airport(Airport_Code)
);
GO



CREATE TABLE airplaneEx.Seat
(
    FK_Number INT NOT NULL,
    FK_Dependent_Leg_no INT NOT NULL,
    FK_Dependent_Date date NOT NULL,
    Dependent_Seat_no INT NOT NULL,
    Customer_Phone int NOT NULL,
    Customer_Name [NVARCHAR](50) NOT NULL,

    PRIMARY KEY (FK_Number, FK_Dependent_Leg_no, FK_Dependent_Date, Dependent_Seat_no),
    FOREIGN KEY (FK_Number, FK_Dependent_Leg_no, FK_Dependent_Date) REFERENCES airplaneEx.Leg_Instance(FK_Number, FK_Dependent_Leg_no, Dependent_Date),   
    UNIQUE (Customer_Phone)
);
GO