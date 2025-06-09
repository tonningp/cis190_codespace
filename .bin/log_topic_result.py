#!/usr/bin/env python3
import sqlite3
import os
import argparse
from datetime import datetime

def log_grade(db_path, topic_id, score):
    timestamp = datetime.now().isoformat(timespec='seconds')
    db_path = os.path.abspath(os.path.expanduser(db_path))

    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Create grades table if it doesn't exist
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS grades (
        topic_id TEXT PRIMARY KEY,
        score INTEGER NOT NULL,
        timestamp TEXT NOT NULL
    )
    """)

    # Insert or update topic grade
    cursor.execute("""
    INSERT INTO grades (topic_id, score,  timestamp)
    VALUES (?, ?, ?)
    ON CONFLICT(topic_id) DO UPDATE SET
        score=excluded.score,
        timestamp=excluded.timestamp
    """, (topic_id, score, timestamp))

    conn.commit()
    conn.close()
    print(f"✅ Logged: {topic_id} | Score: {score}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Log autograde result for a topic.")
    parser.add_argument("--db", default="~/profile.sqlite3", help="Path to SQLite database")
    parser.add_argument("--topic", required=True, help="Topic ID (e.g., week1.module1.topicA)")
    parser.add_argument("--score", type=int, required=True, help="Score (0–100)")
    #parser.add_argument("--pass", dest="passed", action="store_true", help="Flag: topic passed")
    #parser.add_argument("--fail", dest="passed", action="store_false", help="Flag: topic failed")
    #parser.set_defaults(passed=True)

    args = parser.parse_args()
    log_grade(args.db, args.topic, args.score)
