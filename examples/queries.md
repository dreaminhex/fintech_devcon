# GraphQL Gateway Queries

This document contains example queries for the federated GraphQL gateway that combines data from both the Payments API (.NET/HotChocolate) and Processor API (Python/Ariadne).

## Composite Queries (Federation)

These queries demonstrate Apollo Federation by fetching data across multiple services.

### Get User with Accounts and Payments

This query fetches a user from the Payments API, then resolves their accounts and payment history from the Processor API.

```gql
query GetUserWithAccountsAndPayments {
  users(where: { userName: { eq: "carl@dungeon" } }) {
    items {
      id
      userName
      emailAddress
      accounts {
        accountname
        balance
        payments(take: 5, order: { paymentdate: DESC }) {
          items {
            principal
            interest
            total
            paymentdate
          }
          totalCount
          pageInfo {
            hasNextPage
          }
        }
      }
    }
  }
}
```

### Get User with Accounts Summary

Fetch user details and just the account balances without payments.

```gql
query GetUserWithAccountsSummary {
  users(where: { emailAddress: { eq: "carl@dungeon" } }) {
    items {
      userName
      emailAddress
      accounts {
        accountname
        accountlast4
        balance
        accounttype
      }
    }
  }
}
```

### Get User with Filtered Account Payments

Fetch user and filter their payment history by date range.

```gql
query GetUserWithFilteredPayments($startDate: DateTime!, $endDate: DateTime!) {
  users(where: { userName: { eq: "carlton" } }) {
    items {
      userName
      emailAddress
      accounts {
        accountname
        balance
        payments(
          where: { startDate: $startDate, endDate: $endDate }
          order: { total: DESC }
        ) {
          items {
            principal
            interest
            total
            paymentdate
          }
          totalCount
        }
      }
    }
  }
}
```

#### Variables

```json
{
  "startDate": "2024-01-01T00:00:00",
  "endDate": "2024-12-31T23:59:59"
}
```

# Payments API

The following queries can be used against the Payments API, which is build on .NET and uses ChilliCream's HotChocolate implementation of GraphQL.

The Payments API implements filtering, sorting, offset paging, and projecions.

## Get Users

```gql
query GetUsers {
  users {
    id
    userName
    emailAddress
  }
}
```

### With Ordering

```gql
query GetUsers {
  users(order: { userName: ASC }) {
    id
    userName
    emailAddress
  }
}
```

### With Limiting

```gql
query GetUsers {
  users(order: { userName: ASC }, skip: 1, take: 2) {
    items {
      id
      userName
      emailAddress
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

## Get User by Email

```gql
query GetUserByEmail {
  users(where: { emailAddress: { eq: "carl@dungeon" } }) {
    id
    userName
    emailAddress
    loanAccounts
    paymentAccounts
    roles
  }
}
```

### With Variables

```gql
query GetUserByEmail($emailAddress: String!) {
  users(where: { emailAddress: { eq: $emailAddress } }) {
    id
    userName
    emailAddress
    loanAccounts
    paymentAccounts
    roles
  }
}
```

### Variables

```gql
{
  "emailAddress": "carl@dungeon"
}
```

# Processor API

The Processor API is a Python application that implements filtering, sorting, offset paging, and projections.

## Get Accounts

```gql
query GetAccounts {
  accounts {
    items {
      accountid
      accounttoken
      accountname
      accountlast4
      balance
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### With Ordering

```gql
query GetAccounts {
  accounts(order: { accountname: ASC }) {
    items {
      accountid
      accounttoken
      accountname
      accountlast4
      balance
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### With Pagination

```gql
query GetAccounts {
  accounts(skip: 0, take: 5, order: { balance: DESC }) {
    items {
      accountid
      accounttoken
      accountname
      accountlast4
      balance
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### With Filtering

```gql
query GetAccounts {
  accounts(where: { accountname: "Visa", minBalance: 100.00 }) {
    items {
      accountid
      accounttoken
      accountname
      accountlast4
      balance
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### With Variables

```gql
query GetAccounts($accountName: String, $minBalance: Float) {
  accounts(where: { accountname: $accountName, minBalance: $minBalance }) {
    items {
      accountid
      accounttoken
      accountname
      accountlast4
      balance
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### Variables

```json
{
  "accountName": "Visa",
  "minBalance": 100.00
}
```

## Get Loans

```gql
query GetLoans {
  loans {
    items {
      loanid
      loannumber
      loanname
      balance
      lastpaymentdate
      nextpaymentdate
      lastpaymentamount
      rate
      term
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### With Ordering

```gql
query GetLoans {
  loans(order: { balance: DESC }) {
    items {
      loanid
      loannumber
      loanname
      balance
      lastpaymentdate
      nextpaymentdate
      lastpaymentamount
      rate
      term
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### With Pagination

```gql
query GetLoans {
  loans(skip: 0, take: 5, order: { nextpaymentdate: ASC }) {
    items {
      loanid
      loannumber
      loanname
      balance
      lastpaymentdate
      nextpaymentdate
      lastpaymentamount
      rate
      term
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### With Filtering

```gql
query GetLoans {
  loans(where: { minBalance: 10000.00, maxRate: 5.5 }) {
    items {
      loanid
      loannumber
      loanname
      balance
      lastpaymentdate
      nextpaymentdate
      lastpaymentamount
      rate
      term
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### With Variables

```gql
query GetLoans($minBalance: Float, $maxRate: Float) {
  loans(where: { minBalance: $minBalance, maxRate: $maxRate }) {
    items {
      loanid
      loannumber
      loanname
      balance
      lastpaymentdate
      nextpaymentdate
      lastpaymentamount
      rate
      term
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### Variables

```json
{
  "minBalance": 10000.00,
  "maxRate": 5.5
}
```

## Get Payments

```gql
query GetPayments {
  payments {
    items {
      paymentid
      userid
      principal
      interest
      total
      loannumber
      accounttoken
      paymentdate
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### With Ordering

```gql
query GetPayments {
  payments(order: { paymentdate: DESC }) {
    items {
      paymentid
      userid
      principal
      interest
      total
      loannumber
      accounttoken
      paymentdate
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### With Pagination

```gql
query GetPayments {
  payments(skip: 0, take: 10, order: { total: DESC }) {
    items {
      paymentid
      userid
      principal
      interest
      total
      loannumber
      accounttoken
      paymentdate
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### With Filtering

```gql
query GetPayments {
  payments(where: { userid: "user-123", minTotal: 500.00 }) {
    items {
      paymentid
      userid
      principal
      interest
      total
      loannumber
      accounttoken
      paymentdate
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### With Date Range Filtering

```gql
query GetPayments {
  payments(
    where: {
      startDate: "2024-01-01T00:00:00",
      endDate: "2024-12-31T23:59:59"
    },
    order: { paymentdate: DESC }
  ) {
    items {
      paymentid
      userid
      principal
      interest
      total
      loannumber
      accounttoken
      paymentdate
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### With Variables

```gql
query GetPayments($userId: String, $minTotal: Float) {
  payments(where: { userid: $userId, minTotal: $minTotal }) {
    items {
      paymentid
      userid
      principal
      interest
      total
      loannumber
      accounttoken
      paymentdate
    }
    totalCount
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}
```

### Variables

```json
{
  "userId": "user-123",
  "minTotal": 500.00
}
```