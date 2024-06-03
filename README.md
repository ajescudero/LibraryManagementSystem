# Library Management System

## Overview

The Library Management System is a Ruby on Rails application designed to manage a library's book inventory and borrowing process. The system supports two types of users: Librarians and Members. Librarians can manage books and oversee the borrowing process, while Members can borrow and return books.

## Features

- **User Authentication and Authorization:**

- Users can register, log in, and log out.

- Two roles: Librarian and Member.

- Only Librarians can add, edit, or delete books.

- **Book Management:**

- Add, edit, and delete book details.

- Search for books by title, author, or genre.

- **Borrowing and Returning:**

- Members can borrow available books.

- Tracks borrowing date and due date (2 weeks from borrowing date).

- Librarians can mark books as returned.

- **Dashboard:**

- Librarian Dashboard:

- Total books.

- Total borrowed books.

- Books due today.

- List of members with overdue books.

- Member Dashboard:

- Books borrowed by the member.

- Due dates.

- Overdue books.

- **API Endpoints:**

- RESTful API for CRUD operations on books and borrowings.

- Proper status codes and responses for each endpoint.

- Tested with RSpec.

## Installation

To get a local copy up and running, follow these steps:

### Prerequisites

- Ruby 3.3.0

- Rails 7.1.3.3

- SQLite3 (for development)

### Setup

1.  **Clone the repository:**

```sh

git  clone <repository_url>

cd  LibraryManagementSystem

```

2.  **Install dependencies**

```sh

bundle  install

```

3.  **Setup the database**

```sh

rails  db:create

rails  db:migrate

rails  db:seed

```

**Running the Application**

To run the application locally, use the following command:

```sh

rails  server

```

Visit http://localhost:3000 in your browser to see the application.

**Running Tests**

```sh

bundle  exec  rspec

```

**Seeded Accounts**

The seeds file creates default accounts for testing purposes:

Librarian Account:

librarian@example.com/password

Member Account:

member@example.com/password

**Future Improvements**

**_Enhanced Search Functionality:_**
Implement fuzzy search to improve search accuracy and user experience.

**_Notifications:_**
Implement email notifications for overdue books and upcoming due dates.

**_User Profile:_**
Allow users to update their profile information and change passwords.

**_Reporting:_**
Add reports for library usage statistics, such as most borrowed books and active members.

**_Advanced Permissions:_**
Implement more granular permissions and roles to allow finer control over user actions.
