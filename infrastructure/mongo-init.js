db = db.getSiblingDB('fintech_devcon');

db.users.insertMany([
    {
        _id: "308201f9-9560-4bd4-8f7b-f8703456662d",
        userName: "Carl",
        emailAddress: "carl@dungeon",
        password: "DammitDonut",
        accounts: ["CL-1024582-A", "CL-1024582-B"]
    },
    {
        _id: "1b051285-6897-4239-9e1b-24d86cdc9f99",
        userName: "Katia",
        emailAddress: "katia@daughters",
        password: "EvaSucks",
        accounts: ["KT-1058789-A"]
    },
    {
        _id: "942f7722-17d9-4a6e-8e86-6ec280d47b87",
        userName: "Mordecai",
        emailAddress: "mordecai@managers",
        password: "Alchemy4Ever",
        accounts: ["MD-1089865-A"]
    },
    {
        _id: "dced7bc5-1334-4129-b181-8fd8ee89eee8",
        userName: "Donut",
        emailAddress: "donut@princessposse",
        password: "Ferdinand",
        accounts: ["DN-1096587-A", "DN-1096587-B"]
    }
]);
