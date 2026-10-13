# Swift Networking — Top Rated TV Shows

An iOS application built with **Swift and UIKit** that retrieves top-rated TV shows from [The Movie Database (TMDB)](https://www.themoviedb.org/) and displays them in a scrollable list.

This project demonstrates how to perform HTTP requests using `URLSession`, decode JSON responses with `JSONDecoder`, handle networking errors, and build a custom list interface using `UITableView` and Storyboard.

## Features

- Fetches top-rated TV shows from the TMDB API.
- Parses JSON responses using `Decodable` models.
- Displays TV show posters, titles, ratings, and descriptions.
- Downloads poster images asynchronously.
- Handles HTTP errors, invalid responses, and decoding failures using a custom error type.
- Presents an alert when a networking request fails.
- Uses reusable table view cells to display results efficiently.

## Technologies

- **Language:** Swift
- **Framework:** UIKit
- **Networking:** URLSession
- **JSON Parsing:** JSONDecoder
- **UI:** Storyboard, Auto Layout, UITableView, and custom UITableViewCell
- **API:** TMDB (The Movie Database)

## API Endpoint

The application retrieves data from the following endpoint:

`GET https://api.themoviedb.org/3/tv/top_rated`

Supported query parameters:

| Parameter | Description |
|---|---|
| `api_key` | TMDB API key |
| `language` | Response language, such as `en-US` |
| `page` | Page number of the results |

Poster images are loaded from:

`https://image.tmdb.org/t/p/w500/`

## Project Structure

```text
SwiftNetworking/
├── Models/
│   ├── TVResponse.swift
│   └── TVSeries.swift
├── Networking/
│   ├── NetworkError.swift
│   └── TVService.swift
├── ViewControllers/
│   └── TVSeriesViewController.swift
├── Views/
│   └── TVSeriesCell.swift
└── Main.storyboard
```

### Main Components

**TVSeries.swift**

Defines the `TVSeries` model and maps JSON keys such as `poster_path` and `vote_average` to Swift properties.

**TVResponse.swift**

Represents the API response, including pagination metadata and the array of TV shows.

**NetworkError.swift**

Defines custom errors for invalid URLs, invalid HTTP responses, HTTP status failures, missing data, decoding failures, and request errors.

**TVService.swift**

Builds the API request, executes it using `URLSession`, validates the HTTP response, and decodes the returned JSON.

**TVSeriesViewController.swift**

Requests the top-rated TV shows, manages the table view data source, reloads the interface when data arrives, and displays error alerts.

**TVSeriesCell.swift**

Configures reusable table view cells and loads poster images asynchronously.

## Setup and Installation

### 1. Clone the repository

```bash
git clone https://github.com/EEEEERIKO/swift-networking.git
cd swift-networking
```

### 2. Open the project

Open the `.xcodeproj` file in Xcode.

### 3. Configure your TMDB API key

Obtain an API key from [TMDB](https://www.themoviedb.org/settings/api).

Configure the key in `TVService.swift` using your local development credentials. Do not commit real API credentials to a public repository.

For a learning project, a local configuration file excluded through `.gitignore` is preferable to hardcoding credentials in a tracked source file.

### 4. Run the application

Select an iOS simulator or connected device and run the project using `Command + R`.

An active internet connection and valid TMDB credentials are required to retrieve the data.

## Learning Objectives

This exercise focuses on:

- Building HTTP requests with `URLComponents` and `URLQueryItem`.
- Understanding asynchronous networking with `URLSession`.
- Decoding API responses into strongly typed Swift models.
- Using `Result` to represent success and failure.
- Implementing custom error handling.
- Updating UIKit interfaces on the main thread.
- Reusing custom table view cells.
- Downloading and displaying remote images.
- Configuring Auto Layout constraints in Storyboard.

## Acknowledgements

TV show metadata and poster images are provided by [TMDB](https://www.themoviedb.org/).

This project is an educational exercise and is not endorsed or certified by TMDB.

## Author

Erik Valencia Cardona
