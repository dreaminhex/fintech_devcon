CREATE TABLE loans (
    loanid SERIAL PRIMARY KEY,
    loannumber VARCHAR NOT NULL UNIQUE,
    loanname VARCHAR NOT NULL,
    balance NUMERIC(12, 2) NOT NULL,
    term NUMERIC(4, 0) NOT NULL,
    rate NUMERIC(8, 4) NOT NULL,
    originationdate TIMESTAMP NOT NULL,
    lastpaymentdate TIMESTAMP NOT NULL,
    nextpaymentdate TIMESTAMP NOT NULL,
    lastpaymentamount NUMERIC(12, 2) NOT NULL
);

CREATE TABLE accounts (
    accountid SERIAL PRIMARY KEY,
    accounttoken VARCHAR NOT NULL,
    accountname VARCHAR NOT NULL,
    accountlast4 NUMERIC(4, 0),
    accountexpmonth NUMERIC(4, 0) NOT NULL,
    accountexpyear NUMERIC(4, 0) NOT NULL,
    accounttype NUMERIC(4, 0) NOT NULL,
    balance NUMERIC(12, 2) NOT NULL
);

CREATE TABLE payments (
    paymentid SERIAL PRIMARY KEY,
    userid VARCHAR NOT NULL,
    loannumber VARCHAR NOT NULL,
    accounttoken VARCHAR NOT NULL,
    principal NUMERIC(12, 2) NOT NULL,
    interest NUMERIC(12, 2) NOT NULL,
    total NUMERIC(12, 2) NOT NULL,
    paymentdate TIMESTAMP NOT NULL
);

INSERT INTO
    accounts (
        accountid,
        accounttoken,
        accountname,
        accountlast4,
        accountexpmonth,
        accountexpyear,
        accounttype,
        balance
    )
VALUES (
        1,
        '1ec9b64a-8714-4acc-9bc6-975ce42e78d3',
        'Carl''s Bunker Savings',
        5012,
        4,
        2027,
        1,
        6928.65
    );

INSERT INTO
    accounts (
        accountid,
        accounttoken,
        accountname,
        accountlast4,
        accountexpmonth,
        accountexpyear,
        accounttype,
        balance
    )
VALUES (
        2,
        '30f9119e-11ce-4555-8fdf-3da8b3380a87',
        'Carl''s Munitions Checking',
        9935,
        2,
        2030,
        4,
        801.94
    );

INSERT INTO
    accounts (
        accountid,
        accounttoken,
        accountname,
        accountlast4,
        accountexpmonth,
        accountexpyear,
        accounttype,
        balance
    )
VALUES (
        3,
        '173c8cc6-c562-48e1-9307-d78fa170ba77',
        'Katia''s Stalker Rewards Credit Card',
        9279,
        10,
        2026,
        2,
        7302.19
    );

INSERT INTO
    accounts (
        accountid,
        accounttoken,
        accountname,
        accountlast4,
        accountexpmonth,
        accountexpyear,
        accounttype,
        balance
    )
VALUES (
        4,
        'b91a11c2-f760-4837-ad44-486073e010ce',
        'Katia''s Metal Supplies Savings',
        9928,
        7,
        2027,
        4,
        6098.02
    );

INSERT INTO
    accounts (
        accountid,
        accounttoken,
        accountname,
        accountlast4,
        accountexpmonth,
        accountexpyear,
        accounttype,
        balance
    )
VALUES (
        5,
        'e49c4f34-65dd-420d-b6ef-b5972a2c896a',
        'Mordecai''s Corporate Trainer Checking',
        6574,
        5,
        2027,
        2,
        9593.52
    );

INSERT INTO
    accounts (
        accountid,
        accounttoken,
        accountname,
        accountlast4,
        accountexpmonth,
        accountexpyear,
        accounttype,
        balance
    )
VALUES (
        6,
        '7db3d36e-6723-442d-8360-0f8f9d821eb1',
        'Mordecai''s Potion Gold Card',
        6514,
        2,
        2026,
        4,
        1418.81
    );

INSERT INTO
    accounts (
        accountid,
        accounttoken,
        accountname,
        accountlast4,
        accountexpmonth,
        accountexpyear,
        accounttype,
        balance
    )
VALUES (
        7,
        '1a4bdae1-add3-427a-adbe-d7a57d44450b',
        'Donut''s Royal Treats Card',
        8527,
        9,
        2026,
        4,
        1248.6
    );

INSERT INTO
    accounts (
        accountid,
        accounttoken,
        accountname,
        accountlast4,
        accountexpmonth,
        accountexpyear,
        accounttype,
        balance
    )
VALUES (
        8,
        '930adb11-1683-4c5e-9b8d-7c9363d6e21f',
        'Donut''s Princess Posse Checking',
        5803,
        11,
        2030,
        3,
        5984.85
    );

INSERT INTO
    accounts (
        accountid,
        accounttoken,
        accountname,
        accountlast4,
        accountexpmonth,
        accountexpyear,
        accounttype,
        balance
    )
VALUES (
        9,
        '0c51c4d3-aa4f-465b-8cea-df20b381f749',
        'Donut''s Blood Sultanate Platinum Card',
        2139,
        1,
        2027,
        3,
        9859.6
    );

INSERT INTO
    loans (
        loanid,
        loannumber,
        loanname,
        balance,
        term,
        rate,
        originationdate,
        lastpaymentdate,
        nextpaymentdate,
        lastpaymentamount
    )
VALUES (
        1,
        'CL-ZYCWTIQJ-A',
        'Carl''s Munitions Loan',
        232353.6,
        60,
        11.3285,
        '2022-05-08',
        '2025-06-21',
        '2025-07-21',
        12249.41
    );

INSERT INTO
    loans (
        loanid,
        loannumber,
        loanname,
        balance,
        term,
        rate,
        originationdate,
        lastpaymentdate,
        nextpaymentdate,
        lastpaymentamount
    )
VALUES (
        2,
        'CL-ZYCWTIQJ-B',
        'Carl''s Trainer Licensing Loan',
        78041.15,
        36,
        9.1615,
        '2023-07-20',
        '2025-07-09',
        '2025-08-08',
        7423.77
    );

INSERT INTO
    loans (
        loanid,
        loannumber,
        loanname,
        balance,
        term,
        rate,
        originationdate,
        lastpaymentdate,
        nextpaymentdate,
        lastpaymentamount
    )
VALUES (
        3,
        'CL-ZYCWTIQJ-C',
        'Carl''s Armor Installment Loan',
        291712.5,
        48,
        3.2889,
        '2024-06-20',
        '2025-07-15',
        '2025-08-14',
        8997.48
    );

INSERT INTO
    loans (
        loanid,
        loannumber,
        loanname,
        balance,
        term,
        rate,
        originationdate,
        lastpaymentdate,
        nextpaymentdate,
        lastpaymentamount
    )
VALUES (
        4,
        'KA-HR5XFF0T-A',
        'Katia''s Sniper Scope Microloan',
        688297.43,
        48,
        9.7231,
        '2024-07-17',
        '2025-07-12',
        '2025-08-11',
        22664.79
    );

INSERT INTO
    loans (
        loanid,
        loannumber,
        loanname,
        balance,
        term,
        rate,
        originationdate,
        lastpaymentdate,
        nextpaymentdate,
        lastpaymentamount
    )
VALUES (
        5,
        'KA-HR5XFF0T-B',
        'Katia''s Trap Gear Line of Credit',
        686501.17,
        36,
        6.5946,
        '2024-08-17',
        '2025-07-13',
        '2025-08-12',
        30610.41
    );

INSERT INTO
    loans (
        loanid,
        loannumber,
        loanname,
        balance,
        term,
        rate,
        originationdate,
        lastpaymentdate,
        nextpaymentdate,
        lastpaymentamount
    )
VALUES (
        6,
        'MI-DBDW2PCN-A',
        'Mordecai''s Revival Debt',
        201200.6,
        60,
        11.9651,
        '2024-04-01',
        '2025-06-25',
        '2025-07-25',
        5671.33
    );

INSERT INTO
    loans (
        loanid,
        loannumber,
        loanname,
        balance,
        term,
        rate,
        originationdate,
        lastpaymentdate,
        nextpaymentdate,
        lastpaymentamount
    )
VALUES (
        7,
        'MI-DBDW2PCN-B',
        'Mordecai''s Beast Equipment Loan',
        490505.15,
        36,
        7.979,
        '2024-09-13',
        '2025-07-10',
        '2025-08-09',
        21361.1
    );

INSERT INTO
    loans (
        loanid,
        loannumber,
        loanname,
        balance,
        term,
        rate,
        originationdate,
        lastpaymentdate,
        nextpaymentdate,
        lastpaymentamount
    )
VALUES (
        8,
        'DT-1MKFAZZ8-A',
        'Donut''s Sultanate Backpay Advance',
        738223.34,
        60,
        9.8577,
        '2024-06-18',
        '2025-07-13',
        '2025-08-12',
        19336.06
    );

INSERT INTO
    loans (
        loanid,
        loannumber,
        loanname,
        balance,
        term,
        rate,
        originationdate,
        lastpaymentdate,
        nextpaymentdate,
        lastpaymentamount
    )
VALUES (
        9,
        'DT-1MKFAZZ8-B',
        'Donut''s Royal Costume Loan',
        664603.5,
        48,
        10.8347,
        '2024-08-14',
        '2025-07-10',
        '2025-08-09',
        21706.28
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        1,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '0e3de43f-06e0-4ad7-8d4a-efbac833a760',
        6970.66,
        5278.75,
        12249.41,
        '2022-05-08'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        2,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '63a901bf-4bd2-4669-9122-a002fa615d40',
        7036.47,
        5212.94,
        12249.41,
        '2022-06-07'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        3,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        'f4cf7839-0e2d-42f6-ac0f-da74d0b4fff9',
        7102.89,
        5146.52,
        12249.41,
        '2022-07-07'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        4,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '1851df13-1709-4c93-8993-a5b7f9eacfb0',
        7169.95,
        5079.46,
        12249.41,
        '2022-08-06'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        5,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '4a9b2ad5-4be5-477f-a0d1-75be7e91db7e',
        7237.63,
        5011.78,
        12249.41,
        '2022-09-05'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        6,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        'f014b47b-608f-4085-9111-f1da7b9a441f',
        7305.96,
        4943.45,
        12249.41,
        '2022-10-05'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        7,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '85e1e358-d678-48a4-ae90-9916627e183c',
        7374.93,
        4874.48,
        12249.41,
        '2022-11-04'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        8,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '30787147-c91b-48bf-813d-f34e7a88e36f',
        7444.55,
        4804.86,
        12249.41,
        '2022-12-04'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        9,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        'e57733b4-6873-4e54-bf85-5438e6c96d8b',
        7514.83,
        4734.58,
        12249.41,
        '2023-01-03'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        10,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '52d2c316-0c39-426b-bab4-1612e6bad082',
        7585.78,
        4663.63,
        12249.41,
        '2023-02-02'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        11,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '3ca621dd-6943-4280-95fe-b3b934df490f',
        7657.39,
        4592.02,
        12249.41,
        '2023-03-04'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        12,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '8bb3a89b-5568-4b17-9a66-0bb8fb20c143',
        7729.68,
        4519.73,
        12249.41,
        '2023-04-03'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        13,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '0e042c53-7c98-4c83-9a25-4f9ed2946956',
        7802.65,
        4446.76,
        12249.41,
        '2023-05-03'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        14,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '267d1eac-f4c4-49f7-a501-9848150cbc6b',
        7876.31,
        4373.1,
        12249.41,
        '2023-06-02'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        15,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '8a3a20e3-b3fc-4f8f-8895-6a6b454ad3d2',
        7950.67,
        4298.74,
        12249.41,
        '2023-07-02'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        16,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        'f7b8f19c-4f29-46da-9a4c-4efb2b051ace',
        8025.72,
        4223.69,
        12249.41,
        '2023-08-01'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        17,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        'd9075c22-1a28-4cfa-aa3f-9df2fdc5f882',
        8101.49,
        4147.92,
        12249.41,
        '2023-08-31'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        18,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '62a0319d-b818-4a80-bd97-50b4ce5c838b',
        8177.97,
        4071.44,
        12249.41,
        '2023-09-30'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        19,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '1120e57e-9cfc-4b75-8623-6b061f6ed35a',
        8255.17,
        3994.24,
        12249.41,
        '2023-10-30'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        20,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        'a759cfff-e90c-4763-a0fe-56cf752fe211',
        8333.11,
        3916.3,
        12249.41,
        '2023-11-29'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        21,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '9a10d622-643d-42a7-8d35-b8eda76880bf',
        8411.77,
        3837.64,
        12249.41,
        '2023-12-29'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        22,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        'ee61f324-6f2a-4ee2-8a8b-47c3e71320fc',
        8491.19,
        3758.22,
        12249.41,
        '2024-01-28'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        23,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '86a60c75-0b48-4cab-9376-8094f1dd3512',
        8571.35,
        3678.06,
        12249.41,
        '2024-02-27'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        24,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        'ce62997a-792b-4689-8ea1-5367838a4802',
        8652.26,
        3597.15,
        12249.41,
        '2024-03-28'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        25,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '16fbc3fa-ff88-4d8f-a4e2-1c52266f0118',
        8733.94,
        3515.47,
        12249.41,
        '2024-04-27'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        26,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '337c6c2d-dfac-48a7-832e-f0f98bf280cb',
        8816.4,
        3433.01,
        12249.41,
        '2024-05-27'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        27,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '63ff796a-1b6f-4315-ac0c-c2a074d1efbf',
        8899.63,
        3349.78,
        12249.41,
        '2024-06-26'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        28,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '5568198b-7f85-423f-8146-fcf0c845c272',
        8983.64,
        3265.77,
        12249.41,
        '2024-07-26'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        29,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        'b519e476-6683-4b0b-ac43-f91e8916e4f1',
        9068.45,
        3180.96,
        12249.41,
        '2024-08-25'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        30,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '15811567-79f3-43c9-b60b-04616f836fed',
        9154.06,
        3095.35,
        12249.41,
        '2024-09-24'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        31,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '51fb2ece-8a6f-4a89-a680-616c586b39a1',
        9240.48,
        3008.93,
        12249.41,
        '2024-10-24'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        32,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '0d251597-0a77-4485-b81e-6cc10b54efd2',
        9327.71,
        2921.7,
        12249.41,
        '2024-11-23'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        33,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        'e22c479a-3444-401f-b71c-9addf9fb55ca',
        9415.77,
        2833.64,
        12249.41,
        '2024-12-23'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        34,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        'd50ea8ab-baa1-462e-a060-cd4f9f88d4f7',
        9504.66,
        2744.75,
        12249.41,
        '2025-01-22'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        35,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '7df8ebde-b07b-40fd-bc44-9006129a1279',
        9594.39,
        2655.02,
        12249.41,
        '2025-02-21'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        36,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '2db6f91a-e527-434f-b781-aa85e2945aef',
        9684.96,
        2564.45,
        12249.41,
        '2025-03-23'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        37,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        'cd94e049-949f-4993-9c17-915d6a556249',
        9776.39,
        2473.02,
        12249.41,
        '2025-04-22'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        38,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        '6dc7aa5a-47a8-4365-a9be-371eaba8f906',
        9868.69,
        2380.72,
        12249.41,
        '2025-05-22'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        39,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-A',
        'c8eceb9b-188f-4e04-b2a9-9e000710147c',
        9961.85,
        2287.56,
        12249.41,
        '2025-06-21'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        40,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        'c070c7a0-fd09-4be9-8e49-1d972b4325e2',
        5645.65,
        1778.12,
        7423.77,
        '2023-07-20'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        41,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '66f4d91c-ea99-4788-a245-a5b4d9fef090',
        5688.76,
        1735.01,
        7423.77,
        '2023-08-19'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        42,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '40d049e1-d734-4c5d-bf7a-d6d84da3237c',
        5732.19,
        1691.58,
        7423.77,
        '2023-09-18'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        43,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '355290b1-7aca-40a3-8527-9081342753f4',
        5775.95,
        1647.82,
        7423.77,
        '2023-10-18'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        44,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        'e202c9ca-0bfd-4d90-81a9-37776bb1eab4',
        5820.05,
        1603.72,
        7423.77,
        '2023-11-17'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        45,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '128b6b8f-49dc-415f-b66a-961668784b5d',
        5864.48,
        1559.29,
        7423.77,
        '2023-12-17'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        46,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '7c61fee2-9711-49f4-ae9d-25a79d6ed44d',
        5909.25,
        1514.52,
        7423.77,
        '2024-01-16'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        47,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        'cb406ac5-d0a0-4211-9ed9-97fe08987ded',
        5954.37,
        1469.4,
        7423.77,
        '2024-02-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        48,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '1d832202-5613-4ee2-8fb5-4b7654b0d325',
        5999.83,
        1423.94,
        7423.77,
        '2024-03-16'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        49,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '2dc21731-1a83-4f61-94b8-71828ddd36b2',
        6045.63,
        1378.14,
        7423.77,
        '2024-04-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        50,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '3698a1ba-76a7-4dcc-8c78-75d8945306b6',
        6091.79,
        1331.98,
        7423.77,
        '2024-05-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        51,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '69368525-73e2-4c02-9a75-54e4d20638dc',
        6138.3,
        1285.47,
        7423.77,
        '2024-06-14'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        52,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        'bb0d63c1-2930-4602-81ee-fd792c4a8c8e',
        6185.16,
        1238.61,
        7423.77,
        '2024-07-14'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        53,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '91a2e73c-c221-400b-b21a-ff7a23961dac',
        6232.38,
        1191.39,
        7423.77,
        '2024-08-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        54,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        'a6860c2a-acb4-46a5-acb8-581df67ae030',
        6279.96,
        1143.81,
        7423.77,
        '2024-09-12'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        55,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        'af273bed-2742-4857-8d7b-f9be32b10f27',
        6327.91,
        1095.86,
        7423.77,
        '2024-10-12'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        56,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        'a6fa3c44-e2c9-4a94-a2b9-bc137bd467f6',
        6376.22,
        1047.55,
        7423.77,
        '2024-11-11'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        57,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        'b6e194ef-03e4-4180-8ccf-dc065d35dcfa',
        6424.9,
        998.87,
        7423.77,
        '2024-12-11'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        58,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '66a39c45-52f1-4780-80fa-74ea7a7ef00f',
        6473.95,
        949.82,
        7423.77,
        '2025-01-10'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        59,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        'bf245e66-7822-4631-95c6-99c2f31494ef',
        6523.38,
        900.39,
        7423.77,
        '2025-02-09'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        60,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '6f2fa3e9-6ee7-49b2-a38d-a64b363dd3c5',
        6573.18,
        850.59,
        7423.77,
        '2025-03-11'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        61,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '2cfaf48d-c050-4169-ac3a-7395dedfb092',
        6623.36,
        800.41,
        7423.77,
        '2025-04-10'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        62,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '836b0f40-3a1a-49e4-9171-50b1e448f5d8',
        6673.93,
        749.84,
        7423.77,
        '2025-05-10'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        63,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        'fda7f893-60d9-4153-9273-f57683748e23',
        6724.88,
        698.89,
        7423.77,
        '2025-06-09'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        64,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-B',
        '20726ed4-7ee8-4062-81d9-324fe4827491',
        6776.22,
        647.55,
        7423.77,
        '2025-07-09'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        65,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        '85e5b745-17e4-4e6a-ab61-b388c9dd9681',
        7889.78,
        1107.7,
        8997.48,
        '2024-06-20'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        66,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        'b2f2ec05-4395-4095-a242-c67ec3b13e21',
        7911.41,
        1086.07,
        8997.48,
        '2024-07-20'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        67,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        'e9b01f1e-3d60-4527-a7e7-38f280977d28',
        7933.09,
        1064.39,
        8997.48,
        '2024-08-19'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        68,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        '9f4efea9-c641-40a1-9695-08c9710b41fa',
        7954.83,
        1042.65,
        8997.48,
        '2024-09-18'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        69,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        '670865f1-9f6b-4657-b505-3a2bfc53b196',
        7976.63,
        1020.85,
        8997.48,
        '2024-10-18'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        70,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        'e636fd8a-2026-4d14-bd80-0c015cbb1017',
        7998.5,
        998.98,
        8997.48,
        '2024-11-17'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        71,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        '840282ac-67ef-48db-91af-013c0e65c7e4',
        8020.42,
        977.06,
        8997.48,
        '2024-12-17'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        72,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        '6787c85c-9e14-4013-a77d-4f079ddfe004',
        8042.4,
        955.08,
        8997.48,
        '2025-01-16'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        73,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        'd5d26213-ef72-4c78-9135-fd86985e0d42',
        8064.44,
        933.04,
        8997.48,
        '2025-02-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        74,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        '9835d312-3d03-4e9f-a966-dca8600db010',
        8086.54,
        910.94,
        8997.48,
        '2025-03-17'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        75,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        '9d2fefc3-f341-4800-8126-b56cacffde9e',
        8108.71,
        888.77,
        8997.48,
        '2025-04-16'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        76,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        '990fb301-c439-4887-a219-a89e0352d164',
        8130.93,
        866.55,
        8997.48,
        '2025-05-16'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        77,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        'd48a907c-2d37-4e82-962c-d3a7a5ddea41',
        8153.22,
        844.26,
        8997.48,
        '2025-06-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        78,
        '308201f9-9560-4bd4-8f7b-f8703456662d',
        'CL-ZYCWTIQJ-C',
        'a652e2b1-17f9-413f-bd0d-af2e8e3a8345',
        8175.56,
        821.92,
        8997.48,
        '2025-07-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        79,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-A',
        '7b9bee97-38a1-4cd8-a4be-0c662e1b5373',
        15385.97,
        7278.82,
        22664.79,
        '2024-07-17'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        80,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-A',
        'caaa232e-bd71-495e-ba7b-17aa79b87f23',
        15510.63,
        7154.16,
        22664.79,
        '2024-08-16'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        81,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-A',
        'd151cf31-7251-4e7e-9b6d-fa2c0e1e1c2f',
        15636.31,
        7028.48,
        22664.79,
        '2024-09-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        82,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-A',
        '64e61840-623c-448d-acba-9e4875716f23',
        15763.0,
        6901.79,
        22664.79,
        '2024-10-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        83,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-A',
        'e1d24fae-e9a6-469f-9c77-c34b61a03ab9',
        15890.72,
        6774.07,
        22664.79,
        '2024-11-14'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        84,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-A',
        '85964395-7588-46df-a1aa-d08b6cc37d01',
        16019.48,
        6645.31,
        22664.79,
        '2024-12-14'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        85,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-A',
        '367cab13-d549-4fc3-a0e3-9894a636e7f6',
        16149.28,
        6515.51,
        22664.79,
        '2025-01-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        86,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-A',
        '64e038a5-2769-4d3d-a381-926be3a8cf50',
        16280.13,
        6384.66,
        22664.79,
        '2025-02-12'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        87,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-A',
        '192be7b8-e8f7-490f-87c5-1414e287249d',
        16412.04,
        6252.75,
        22664.79,
        '2025-03-14'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        88,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-A',
        '38fba71b-1bd2-4dae-b707-0e6675505437',
        16545.02,
        6119.77,
        22664.79,
        '2025-04-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        89,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-A',
        '90a1ffb6-c149-4740-9477-be14e8f4761f',
        16679.08,
        5985.71,
        22664.79,
        '2025-05-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        90,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-A',
        'ba672ca0-9940-448b-9791-5544d46b9147',
        16814.22,
        5850.57,
        22664.79,
        '2025-06-12'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        91,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-A',
        '64332049-374b-404c-b266-bb36a3ae8b53',
        16950.46,
        5714.33,
        22664.79,
        '2025-07-12'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        92,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-B',
        'e865da23-be15-4a9b-93fc-7e2797035e03',
        25129.53,
        5480.88,
        30610.41,
        '2024-08-17'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        93,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-B',
        '6fb909c1-f6ee-423b-970f-04187ad33ad3',
        25267.63,
        5342.78,
        30610.41,
        '2024-09-16'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        94,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-B',
        '690a5db9-322d-4d6b-a793-ff247b5f16ed',
        25406.49,
        5203.92,
        30610.41,
        '2024-10-16'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        95,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-B',
        '1cb42a46-4851-4728-b82d-5b3b4d7ec1b7',
        25546.11,
        5064.3,
        30610.41,
        '2024-11-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        96,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-B',
        '05550e04-7031-4d7a-a000-02579431f5e8',
        25686.5,
        4923.91,
        30610.41,
        '2024-12-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        97,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-B',
        '8819233d-de60-490e-a768-38fc83ad1a48',
        25827.66,
        4782.75,
        30610.41,
        '2025-01-14'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        98,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-B',
        'fd4b0065-1489-444b-ac66-fd1764a085cb',
        25969.6,
        4640.81,
        30610.41,
        '2025-02-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        99,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-B',
        '0bd2abcd-bf2d-4c75-a58f-2a1e9375cc18',
        26112.31,
        4498.1,
        30610.41,
        '2025-03-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        100,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-B',
        '7d0769e9-f852-4993-af16-c62549f65079',
        26255.81,
        4354.6,
        30610.41,
        '2025-04-14'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        101,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-B',
        '8a5ef762-ba1a-458c-a3e2-62f2da9bde8f',
        26400.1,
        4210.31,
        30610.41,
        '2025-05-14'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        102,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-B',
        'f94946be-3c55-4baf-b96e-3868ab1dca52',
        26545.18,
        4065.23,
        30610.41,
        '2025-06-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        103,
        '1b051285-6897-4239-9e1b-24d86cdc9f99',
        'KA-HR5XFF0T-B',
        '262f4143-9569-4acd-92fd-a93184be665a',
        26691.06,
        3919.35,
        30610.41,
        '2025-07-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        104,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        '72fb7d0c-a121-4644-abe2-e2cbd8e700d3',
        3127.18,
        2544.15,
        5671.33,
        '2024-04-01'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        105,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        '0e943e9b-d61a-45ca-a97c-89ed74bc36cb',
        3158.36,
        2512.97,
        5671.33,
        '2024-05-01'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        106,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        '141ea098-608d-4fee-9074-bac6fad2ef5b',
        3189.85,
        2481.48,
        5671.33,
        '2024-05-31'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        107,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        '90052dd6-df68-4679-a62e-4e4eca708bf0',
        3221.66,
        2449.67,
        5671.33,
        '2024-06-30'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        108,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        'b30ee867-6ed9-4677-972c-a2912b9d1528',
        3253.78,
        2417.55,
        5671.33,
        '2024-07-30'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        109,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        '98ab6ddc-4c7f-49a4-a46c-8526c5986ee2',
        3286.22,
        2385.11,
        5671.33,
        '2024-08-29'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        110,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        'b4a0df84-9245-48cb-a45a-fbdbcc31de2f',
        3318.99,
        2352.34,
        5671.33,
        '2024-09-28'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        111,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        '1ac93a5d-601f-4272-945e-8e87617bf0ef',
        3352.08,
        2319.25,
        5671.33,
        '2024-10-28'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        112,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        '33d4185e-4760-465c-8519-4ceaab3fc6b3',
        3385.51,
        2285.82,
        5671.33,
        '2024-11-27'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        113,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        '539b48bf-597a-421e-95e7-6d6f5c490852',
        3419.26,
        2252.07,
        5671.33,
        '2024-12-27'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        114,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        'f7ad4745-1e8a-4b3e-9259-ea4f557cd7a4',
        3453.36,
        2217.97,
        5671.33,
        '2025-01-26'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        115,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        '06180eb6-5bc2-4620-a4ff-ceeb3fdcf4eb',
        3487.79,
        2183.54,
        5671.33,
        '2025-02-25'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        116,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        '072a2464-acbc-45e3-b01e-a043670edfad',
        3522.57,
        2148.76,
        5671.33,
        '2025-03-27'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        117,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        '624674fd-f273-4fce-bc70-6fff5909be6c',
        3557.69,
        2113.64,
        5671.33,
        '2025-04-26'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        118,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        'e7acf6e7-5571-428f-803d-fa807150ce78',
        3593.16,
        2078.17,
        5671.33,
        '2025-05-26'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        119,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-A',
        '1f9986c7-3307-4c8f-aec4-a697e1578ce9',
        3628.99,
        2042.34,
        5671.33,
        '2025-06-25'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        120,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-B',
        '43167846-8454-45a2-8105-b21c95bcf428',
        16827.15,
        4533.95,
        21361.1,
        '2024-09-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        121,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-B',
        '6b5f9e93-f763-4b9f-9198-e6e48d61421e',
        16939.04,
        4422.06,
        21361.1,
        '2024-10-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        122,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-B',
        '984d83f5-d3a7-481e-804b-a6dfdb173395',
        17051.67,
        4309.43,
        21361.1,
        '2024-11-12'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        123,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-B',
        'bca372b3-2579-48bf-a921-39a53e6e3145',
        17165.05,
        4196.05,
        21361.1,
        '2024-12-12'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        124,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-B',
        '9450e789-6685-4b9e-9199-7d5d5b4ec389',
        17279.18,
        4081.92,
        21361.1,
        '2025-01-11'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        125,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-B',
        'e7b58a89-3e74-44df-acec-dcdda9fe76a8',
        17394.07,
        3967.03,
        21361.1,
        '2025-02-10'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        126,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-B',
        'bca441cf-b37f-4940-8175-5a91b13edc09',
        17509.73,
        3851.37,
        21361.1,
        '2025-03-12'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        127,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-B',
        '8e3c181a-9dbf-4653-a665-3830f4c49c4e',
        17626.16,
        3734.94,
        21361.1,
        '2025-04-11'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        128,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-B',
        '60e3ca5c-cf34-402f-b42a-7d821a27b3a0',
        17743.36,
        3617.74,
        21361.1,
        '2025-05-11'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        129,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-B',
        '6a409a41-33ec-4405-a03c-1232f54fea2f',
        17861.33,
        3499.77,
        21361.1,
        '2025-06-10'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        130,
        '942f7722-17d9-4a6e-8e86-6ec280d47b87',
        'MI-DBDW2PCN-B',
        '8a1adc19-4dc3-465c-a51c-34090ae21eff',
        17980.1,
        3381.0,
        21361.1,
        '2025-07-10'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        131,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        '88edcd07-0553-4753-951c-cb8140f3b6f2',
        11835.46,
        7500.6,
        19336.06,
        '2024-06-18'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        132,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        '44049644-473d-4881-8f62-3deed584ecf1',
        11932.69,
        7403.37,
        19336.06,
        '2024-07-18'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        133,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        'b82916f8-b08d-4090-9038-db97eadf9045',
        12030.71,
        7305.35,
        19336.06,
        '2024-08-17'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        134,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        '591ac8b8-069e-455d-a5f0-e683439dde9f',
        12129.54,
        7206.52,
        19336.06,
        '2024-09-16'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        135,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        '2291935c-2e73-4f6a-8f17-8a61eb41a6cd',
        12229.18,
        7106.88,
        19336.06,
        '2024-10-16'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        136,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        'c6ad2c16-6515-4eaa-94d5-fa840a416d70',
        12329.64,
        7006.42,
        19336.06,
        '2024-11-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        137,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        'dca4a5c4-da00-4dba-bf63-0ace02c2e8d3',
        12430.93,
        6905.13,
        19336.06,
        '2024-12-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        138,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        '686a7759-cae0-4d3e-84f8-79b3ce6318cd',
        12533.04,
        6803.02,
        19336.06,
        '2025-01-14'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        139,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        '1ed43ac2-f843-4ad5-bad8-4878c91ea5cd',
        12636.0,
        6700.06,
        19336.06,
        '2025-02-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        140,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        '112aeca8-b669-4b8f-b5e3-2a5d204cb695',
        12739.8,
        6596.26,
        19336.06,
        '2025-03-15'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        141,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        '67330a80-6e54-49c8-bbd9-b3b26de0229d',
        12844.45,
        6491.61,
        19336.06,
        '2025-04-14'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        142,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        '50b3b272-9824-4860-93b7-fd83840d43ff',
        12949.97,
        6386.09,
        19336.06,
        '2025-05-14'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        143,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        'bc67835c-9a87-40f8-a63c-57e5852852f6',
        13056.35,
        6279.71,
        19336.06,
        '2025-06-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        144,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-A',
        'c35c3f96-a56d-4fec-b8fb-15c1ec624f09',
        13163.6,
        6172.46,
        19336.06,
        '2025-07-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        145,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-B',
        '50c069af-3d53-4ba2-bde9-db262ccbb2ab',
        14099.77,
        7606.51,
        21706.28,
        '2024-08-14'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        146,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-B',
        'd741b4b2-7283-40eb-b3bf-98d9300f13e1',
        14227.08,
        7479.2,
        21706.28,
        '2024-09-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        147,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-B',
        'f9c39b92-56aa-4b2f-bb50-60c8591c3518',
        14355.53,
        7350.75,
        21706.28,
        '2024-10-13'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        148,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-B',
        'e765eee0-1ef8-418e-b239-43971cb5fd34',
        14485.15,
        7221.13,
        21706.28,
        '2024-11-12'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        149,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-B',
        '437ae807-77dd-41f6-b40e-314322eff9bc',
        14615.93,
        7090.35,
        21706.28,
        '2024-12-12'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        150,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-B',
        '2da960e4-3bad-427a-ad99-4d9ef5d3fd67',
        14747.9,
        6958.38,
        21706.28,
        '2025-01-11'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        151,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-B',
        '401a6326-ae8f-4a69-9a5c-1b70a82347eb',
        14881.05,
        6825.23,
        21706.28,
        '2025-02-10'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        152,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-B',
        '84925a92-dd25-4902-b7ac-c2ad2e23b054',
        15015.41,
        6690.87,
        21706.28,
        '2025-03-12'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        153,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-B',
        '16c2ff44-effb-4174-ac88-aa46408aafec',
        15150.99,
        6555.29,
        21706.28,
        '2025-04-11'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        154,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-B',
        'c96a185e-329d-4caf-ae2d-4b45b574b7cb',
        15287.78,
        6418.5,
        21706.28,
        '2025-05-11'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        155,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-B',
        '1e762b90-3246-4efa-b993-a915c6628aa2',
        15425.82,
        6280.46,
        21706.28,
        '2025-06-10'
    );

INSERT INTO
    payments (
        paymentid,
        userid,
        loannumber,
        accounttoken,
        principal,
        interest,
        total,
        paymentdate
    )
VALUES (
        156,
        'dced7bc5-1334-4129-b181-8fd8ee89eee8',
        'DT-1MKFAZZ8-B',
        '7d2b828d-7847-45f1-b921-9da852704ef2',
        15565.09,
        6141.19,
        21706.28,
        '2025-07-10'
    );