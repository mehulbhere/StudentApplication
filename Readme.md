# Student Dashboard

A Flutter project to manage students, academic years, and classes.

## Technologies Used
1. Flutter
2. SQLite

## Overview

### User Functionality:

- Select or add academic years.
- Select or add classes corresponding to the selected academic year.
- Add student details along with fee information.

### Home Screen

- Displays a list of all students added to the system.
- Ability to filter the student list based on the selected academic year and class

### Data Handling

- Prevents the insertion of duplicate academic years and classes
- Does not implement a duplicate check for unique student (will be added in future updates)
- If a user adds a new academic year or class but does not utilize it (i.e., does not assign any students to it), it will not be stored permanently. This is because there is no separate database for academic years and classes; they are only stored when linked with student information.
- A single database is used to store student information only, including details about the academic year and class they belong to.

## Getting Started

### Prerequisites

- [Flutter Windows 3.22.2-stable](https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.22.2-stable.zip)

### Installation

1. Clone the repo

```sh
git clone https://github.com/your-username/your-repo-name.git
```

2. Navigate to the project directory

```sh
cd your-repo-name
```

3. Install Dependencies

```sh
flutter pub get
```

4. Run the application

```sh
flutter run
```

## Direct Installation

Download the [final.apk](https://github.com/mehulbhere/StudentApplication/blob/main/final.apk) from the repository and install it on your Android device.
