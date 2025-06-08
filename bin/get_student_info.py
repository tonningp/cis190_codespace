#!/usr/bin/env python3
import os
import argparse
import sys
import sqlite3
import re
from datetime import datetime

# ----------------------------
# Utilities
# ----------------------------

def valid_email(email):
    """Basic regex to validate email format."""
    pattern = r'^[\w\.-]+@[\w\.-]+\.\w+$'
    return re.match(pattern, email) is not None


def get_student_input():
    """Prompt for student info with validation."""
    student_id = input("🆔 Student ID: ").strip()

    firstname = input("👤 First Name: ").strip()
    while not firstname:
        print("⚠️  First name cannot be empty.")
        firstname = input("👤 First Name: ").strip()

    lastname = input("👤 Last Name: ").strip()
    while not lastname:
        print("⚠️  Last name cannot be empty.")
        lastname = input("👤 Last Name: ").strip()

    email = input("📧 Email Address: ").strip()
    while not valid_email(email):
        print("⚠️  Please enter a valid email address.")
        email = input("📧 Email Address: ").strip()

    return student_id, firstname, lastname, email


# ----------------------------
# Main Logic
# ----------------------------

def main():
    parser = argparse.ArgumentParser(description="Gather student profile info.")
    parser.add_argument(
        "--db",
        type=str,
        default=os.path.expanduser("/workspaces/codespaces-blank/.db/profile.sqlite3"),
        help="Path to SQLite database file"
    )
    args = parser.parse_args()
    db_path = os.path.abspath(os.path.expanduser(args.db))
    # Connect to DB
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Create table if it doesn't exist
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS students (
        id TEXT PRIMARY KEY,
        firstname TEXT NOT NULL,
        lastname TEXT NOT NULL,
        email TEXT NOT NULL,
        updated_at TEXT NOT NULL
    )
    """)

    print("\n📝 Please enter your student profile information:\n")
    student_id, firstname, lastname,email = get_student_input()

    # Check if student ID already exists
    cursor.execute("SELECT * FROM students WHERE id = ?", (student_id,))
    existing = cursor.fetchone()

    if existing:
        print(f"\n⚠️  A record already exists for Student ID: {student_id}")
        confirm = input("🔁 Do you want to overwrite it? [y/N]: ").strip().lower()
        if confirm != 'y':
            print("🚫 Operation canceled. No changes made.")
            conn.close()
            return

    # Insert or update
    now = datetime.now().isoformat(timespec='seconds')
    cursor.execute("""
    INSERT INTO students (id, firstname, lastname,email, updated_at)
    VALUES (?, ?, ?, ?, ?)
    ON CONFLICT(id) DO UPDATE SET
        firstname=excluded.firstname,
        lastname=excluded.lastname,
        email=excluded.email,
        updated_at=excluded.updated_at
    """, (student_id, firstname, lastname, email, now))

    conn.commit()
    conn.close()

    print(f"\n✅ Profile saved to: {db_path}")


if __name__ == "__main__":
    main()
