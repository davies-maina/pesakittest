# PesaKit Transactions App

This is a simple Flutter app that displays a list of transactions fetched from an API. The app is designed to fetch transactions and display details such as amount, date, description, and type (e.g., Income, Expense). The app also includes unit and integration tests with mocked API responses using [Mockito](https://pub.dev/packages/mockito).

## Table of Contents
- [Features](#features)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [API](#api)
- [Testing](#testing)
- [Dependencies](#dependencies)

## Features
- Displays a list of transactions with details.
- Fetches data from a REST API.
- Formats amount in Kenyan Shillings (KES).
- Handles both success and error cases for API responses.
- Mocked API responses in unit tests using Mockito.

## Getting Started

### Prerequisites
- Flutter SDK installed. ([Installation Guide](https://flutter.dev/docs/get-started/install))
- Basic knowledge of Dart and Flutter.

### Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/transactions_app.git
   cd transactions_app
