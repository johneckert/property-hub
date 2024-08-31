# PropertyHub

PropertyHub is a Rails API designed to help clients manage properties efficiently. This API provides endpoints for Stackholder to edit, and create listings for buildings, manage custom fields, and view their listings. In addition, PropertyHub provides an endpoint for external users to access property listings.

## Table of Contents

- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Database Setup](#database-setup)
- [Running the API](#running-the-api)
- [Endpoints](#endpoints)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

These instructions will help you set up and run the PropertyHub API on your local machine for development and testing purposes.

### Prerequisites

- Ruby version: `3.2.2`
- Rails version: `7.0.8`
- PostgreSQL version: `14.12`

### Installation

1. Clone the repository:

```bash
  git clone https://github.com/johneckert/property-hub.git
  cd property-hub
```

2. Install dependencies:
```bash
  bundle install
```

### Configuration
- Update configuration files in config/database.yml with your PostgreSQL credentials if required.

### Database Setup

1. Create and migrate the database:

```bash
  rails db:create
  rails db:migrate
```

2. Seed the database with sample data:

```bash
  rails db:seed
```

### Running the API

Start the Rails server:

```bash
  rails server
```

The API will be available at http://localhost:3000.

### Endpoints

The API provides the following endpoints:
- Root:
  - Maps to GET buildings#index
- Buildings:
  - GET /buildings - List of all buildings for external clients

- Clients:
  - GET /clients/:id/read_buildings - List of all buildings for a specific client
  - POST /clients/:id/create_building - Create a new building for a specific client
  - PATCH /clients/:id/update_building/:building_id - Update a building for a specific client

* Index pages support pagination with the following query parameters: page and per_page. 
eg: http://localhost:3000/buildings?page=1&per_page=10

### Testing

- To run the test suite:
```bash
  rails test
```
- To run automated tests with Guard:
```bash
  guard
```

### Contributing

Fork the repository.
Create your feature branch `git checkout -b feature-name`.
Commit your changes `git commit -m 'Add feature'`.
Push to the branch `git push origin feature-name`.
Open a pull request.


### License

This project is licensed under the MIT License.