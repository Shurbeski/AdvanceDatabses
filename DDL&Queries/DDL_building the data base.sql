CREATE TABLE EMPLOYEE(
   ESSN INTEGER  NOT NULL PRIMARY KEY,
   NAME VARCHAR (50)  NOT NULL,
   SURNAME VARCHAR (50)  NOT NULL,
   E_MAIL VARCHAR (50) UNIQUE NOT NULL,
   ADDRESS VARCHAR (50) NOT NULL,
   TELEPHONE INTEGER  NOT NULL,
   STARTED_WORKING TIMESTAMP NOT NULL,
   LAST_CHECK_IN TIMESTAMP
);

CREATE TABLE SELLER (
    ESSN INTEGER NOT NULL PRIMARY KEY,
    WORKING_EXPERIENCE INTEGER DEFAULT 0 NOT NULL,
    ESSN_RESPONSIBLE INTEGER NOT NULL,
    STORE_ID INTEGER NOT NULL,

    CONSTRAINT fk_responsible FOREIGN KEY (ESSN_RESPONSIBLE) REFERENCES AGENT_MENAGER(ESSN)
                    ON DELETE SET NULL
                    ON UPDATE CASCADE,

    CONSTRAINT fk_Emp FOREIGN KEY (ESSN) REFERENCES EMPLOYEE (ESSN)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE,

    CONSTRAINT fk_store FOREIGN KEY (STORE_ID) REFERENCES STORE(ID)
                    ON DELETE SET NULL
                    ON UPDATE CASCADE
);

CREATE TABLE AGENT_MENAGER (
    ESSN INTEGER NOT NULL PRIMARY KEY,

   CONSTRAINT fk_Emp1 FOREIGN KEY (ESSN) REFERENCES EMPLOYEE(ESSN)
                           ON DELETE CASCADE
                           ON UPDATE CASCADE
);

CREATE TABLE AGENT_SELLER(
  ESSN INTEGER NOT NULL PRIMARY KEY ,
  ESSN_RESPONSIBLE INTEGER NOT NULL ,

  CONSTRAINT fk_emp2 FOREIGN KEY (ESSN) REFERENCES EMPLOYEE(ESSN)
                         ON DELETE CASCADE
                         ON UPDATE CASCADE ,

  CONSTRAINT fk_responsible2 FOREIGN KEY (ESSN) REFERENCES AGENT_SELLER (ESSN)
                         ON DELETE SET NULL
                         ON UPDATE CASCADE

);

CREATE TABLE STORE(
  ID INTEGER NOT NULL PRIMARY KEY ,
  NAME varchar(255) NOT NULL ,
  ADDRESS varchar(255) NOT NULL
);

CREATE TABLE PRODUCT(
    CODE INTEGER NOT NULL PRIMARY KEY ,
    NAME varchar(255) NOT NULL ,
    PRICE REAL NOT NULL ,
    C_OF_PRODUCTION varchar(50) NOT NULL ,
    CATEGORY_ID INTEGER NOT NULL,

    CONSTRAINT fk_cat FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(ID)
                    ON UPDATE CASCADE
                    ON DELETE SET NULL
);

CREATE TABLE STOCK(
    STORE_ID INTEGER NOT NULL ,
    PRODUCT_CODE INTEGER NOT NULL ,
    COUNT INTEGER,

    CONSTRAINT pk_stock PRIMARY KEY (STORE_ID, PRODUCT_CODE),
    CONSTRAINT fk_stock FOREIGN KEY (STORE_ID) REFERENCES STORE(ID)
                  ON UPDATE CASCADE
                  ON DELETE SET NULL ,
    CONSTRAINT fk_stock1 FOREIGN KEY (PRODUCT_CODE) REFERENCES PRODUCT(CODE)
                  ON DELETE SET NULL
                  ON UPDATE CASCADE
);

CREATE TABLE CATEGORY(
    ID INTEGER NOT NULL PRIMARY KEY,
    NAME varchar(50) NOT NULL ,
    SUB_CATEGORY INTEGER,

    CONSTRAINT fk_cat FOREIGN KEY (SUB_CATEGORY) REFERENCES CATEGORY(ID)
                     ON UPDATE CASCADE
                     ON DELETE SET NULL
);

CREATE TABLE COSTUMER(
    CSSN INTEGER PRIMARY KEY ,
    EMAIL VARCHAR (50) UNIQUE NOT NULL,
    TEL_NUM INTEGER UNIQUE NOT NULL,
    PAYMENT_TYPE INTEGER NOT NULL,
    NAME VARCHAR NOT NULL ,
    SURNAME VARCHAR NOT NULL ,
    DELIVERY_ADDRESS varchar NOT NULL,
    AGENT_SELLER_CSSN INTEGER,

    CONSTRAINT AGENT_SELLER_FK FOREIGN KEY (AGENT_SELLER_CSSN) REFERENCES AGENT_SELLER(ESSN)
                     ON UPDATE CASCADE
                     ON DELETE CASCADE
);

CREATE TABLE STORE_REVIEW(
    STORE_ID INTEGER NOT NULL ,
    CSSN INTEGER NOT NULL ,
    GRADE INTEGER,
    COMMENT varchar,


    CONSTRAINT SR_PK PRIMARY KEY (STORE_ID, CSSN),
    CONSTRAINT SR_FK FOREIGN KEY (STORE_ID) REFERENCES STORE(ID)
                         ON UPDATE CASCADE
                         ON DELETE CASCADE,
    CONSTRAINT SR_FK1 FOREIGN KEY (CSSN) REFERENCES COSTUMER(CSSN)
                         ON UPDATE CASCADE
                         ON DELETE CASCADE
);

ALTER TABLE STORE_REVIEW
ADD CONSTRAINT ST_GRADE CHECK ( GRADE >=0 AND GRADE<=5 ) ;

CREATE TABLE PRODUCT_REVIEW(
    CSSN INTEGER NOT NULL,
    CODE INTEGER NOT NULL,
    GRADE INTEGER,
    COMMENT varchar,

    CONSTRAINT PK_PR PRIMARY KEY (CSSN, CODE),
    CONSTRAINT FR_PR FOREIGN KEY (CODE) REFERENCES PRODUCT(CODE)
                           ON DELETE CASCADE
                           ON UPDATE CASCADE ,
    CONSTRAINT FR_PR1 FOREIGN KEY (CSSN) REFERENCES COSTUMER(CSSN)
                           ON DELETE CASCADE
                           ON UPDATE CASCADE
);

CREATE TABLE PURCHASE(
  ESSN INTEGER NOT NULL ,
  CODE INTEGER NOT NULL ,
  CSSN INTEGER NOT NULL ,
  COUNT INTEGER DEFAULT 1,

  CONSTRAINT PK_P PRIMARY KEY (ESSN, CODE, CSSN),
  CONSTRAINT FK_P1 FOREIGN KEY (ESSN) REFERENCES EMPLOYEE(ESSN)
                     ON UPDATE CASCADE
                     ON DELETE CASCADE ,
  CONSTRAINT FK_P2 FOREIGN KEY (CODE) REFERENCES PRODUCT(CODE)
                     ON UPDATE CASCADE
                     ON DELETE CASCADE ,
  CONSTRAINT FK_P3 FOREIGN KEY (CSSN) REFERENCES COSTUMER(CSSN)
                     ON UPDATE CASCADE
                     ON DELETE CASCADE
);

CREATE TABLE TALK(
    ID INTEGER NOT NULL PRIMARY KEY ,
    AS_ESSN INTEGER NOT NULL,
    C_CSSN INTEGER NOT NULL ,
    GOAL varchar(100) NOT NULL ,
    DATE date NOT NULL ,
    DURATION timestamp NOT NULL ,
    CONSTRAINT FK_T FOREIGN KEY (AS_ESSN) REFERENCES AGENT_SELLER(ESSN)
                 ON UPDATE CASCADE
                 ON DELETE CASCADE ,
    CONSTRAINT FK_T1 FOREIGN KEY (C_CSSN) REFERENCES COSTUMER(CSSN)
                 ON UPDATE CASCADE
                 ON DELETE CASCADE

);

CREATE TABLE PRICE(
    ID INTEGER PRIMARY KEY ,
    CODE INTEGER NOT NULL UNIQUE ,
    PRICE REAL NOT NULL,
    DATE_VALID_FROM timestamp NOT NULL ,
    DATE_VALID_TO timestamp NOT NULL,

    CONSTRAINT FK_P FOREIGN KEY (CODE) REFERENCES PRODUCT(CODE)
                  ON DELETE CASCADE
                  ON UPDATE CASCADE


);

CREATE TABLE TELEVIZIJA(
    ID_TV INTEGER UNIQUE NOT NULL PRIMARY KEY ,
    NAME varchar NOT NULL
);

CREATE TABLE REKLAMA(
    TV_ID INTEGER NOT NULL,
    CODE INTEGER NOT NULL ,
    DURATION timestamp NOT NULL,
    CONSTRAINT PK_R PRIMARY KEY (TV_ID),
    CONSTRAINT FK_R1 FOREIGN KEY (TV_ID) REFERENCES TELEVIZIJA(ID_TV)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE ,
    CONSTRAINT FK_R2 FOREIGN KEY (CODE) REFERENCES PRODUCT(CODE)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE
);

