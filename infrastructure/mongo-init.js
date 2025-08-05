db = db.getSiblingDB('fintech_devcon');

db.users.insertMany([
    {
        _id: "308201f9-9560-4bd4-8f7b-f8703456662d",
        userName: "Carl",
        emailAddress: "carl@dungeon",
        password: "DammitDonut",
        loanAccounts: ["CL-ZYCWTIQJ-A", "CL-ZYCWTIQJ-B", "CL-ZYCWTIQJ-C"],
        paymentAccounts: ['1ec9b64a-8714-4acc-9bc6-975ce42e78d3', '30f9119e-11ce-4555-8fdf-3da8b3380a87'],
        roles: ["Auditor"]
    },
    {
        _id: "1b051285-6897-4239-9e1b-24d86cdc9f99",
        userName: "Katia",
        emailAddress: "katia@daughters",
        password: "EvaSucks",
        loanAccounts: ["KA-HR5XFF0T-A", "KA-HR5XFF0T-B"],
        paymentAccounts: ['173c8cc6-c562-48e1-9307-d78fa170ba77', 'b91a11c2-f760-4837-ad44-486073e010ce'],
        roles: ["Readonly"]
    },
    {
        _id: "942f7722-17d9-4a6e-8e86-6ec280d47b87",
        userName: "Mordecai",
        emailAddress: "mordecai@managers",
        password: "Alchemy4Ever",
        loanAccounts: ["MI-DBDW2PCN-A", "MI-DBDW2PCN-B"],
        paymentAccounts: ['e49c4f34-65dd-420d-b6ef-b5972a2c896a','7db3d36e-6723-442d-8360-0f8f9d821eb1'],
        roles: ["Admin"]
    },
    {
        _id: "dced7bc5-1334-4129-b181-8fd8ee89eee8",
        userName: "Donut",
        emailAddress: "donut@princessposse",
        password: "Ferdinand",
        loanAccounts: ["DT-1MKFAZZ8-A", "DN-1MKFAZZ8-B"],
        paymentAccounts: ['1a4bdae1-add3-427a-adbe-d7a57d44450b', '930adb11-1683-4c5e-9b8d-7c9363d6e21f','0c51c4d3-aa4f-465b-8cea-df20b381f749'],
        roles: ["Customer"]
    }
]);

db.roles.insertMany([
    {
        _id: "Admin",
        name: "Admin",
        description: "Full access to all functions."
    },
    {
        _id: "Auditor",
        name: "Auditor",
        description: "Elevated query permissions for auditing."
    },
    {
        _id: "Customer",
        name: "Customer",
        description: "Read & write permissions to own data."
    },
    {
        _id: "Readonly",
        name: "Readonly",
        description: "Readonly access to own data."
    }
]);