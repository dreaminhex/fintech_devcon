db = db.getSiblingDB('fintech_devcon');

db.users.insertMany([
    {
        _id: "308201f9-9560-4bd4-8f7b-f8703456662d",
        userName: "Carl",
        emailAddress: "carl@dungeon",
        password: "DammitDonut",
        loanAccounts: ["CL-1024582-A", "CL-1024582-B"],
        paymentAccounts: ['a202143cf223f44b3c9449f810e4789a900376af269464037d6d7f0724b71cc1', '20589548633df4b041d7bb115487abeb390c5445559234c29b25fa8e82ac1bb2'],
        roles: ["Auditor"]
    },
    {
        _id: "1b051285-6897-4239-9e1b-24d86cdc9f99",
        userName: "Katia",
        emailAddress: "katia@daughters",
        password: "EvaSucks",
        loanAccounts: ["KT-1058789-A"],
        paymentAccounts: ['6199d15034c77723a36215601cbb2d8ccef56517b936d1fa7f0bbc9d7b53da06'],
        roles: ["Readonly"]
    },
    {
        _id: "942f7722-17d9-4a6e-8e86-6ec280d47b87",
        userName: "Mordecai",
        emailAddress: "mordecai@managers",
        password: "Alchemy4Ever",
        loanAccounts: ["MD-1089865-A"],
        paymentAccounts: ['8de5dae600b5b868dfb4c7e16b3eb2e36825287a2cce075a9cffa70dab00aed2'],
        roles: ["Admin"]
    },
    {
        _id: "dced7bc5-1334-4129-b181-8fd8ee89eee8",
        userName: "Donut",
        emailAddress: "donut@princessposse",
        password: "Ferdinand",
        loanAccounts: ["DN-1096587-A", "DN-1096587-B"],
        paymentAccounts: ['394886d5430248d56875ebdf019ab4e8b1e5469a6251b0b9b6bd91c93dff114e'],
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