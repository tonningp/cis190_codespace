#!/usr/bin/env python

import sys
import yaml
import argparse
from rich.console import Console
from rich.panel import Panel
from rich.markdown import Markdown
from datetime import datetime

def get_timestamp():
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S")

def get_hostname():
    try:
        import socket
        return socket.gethostname()
    except ImportError:
        return "unknown-host"

def get_current_working_directory():
    try:
        import os
        return os.getcwd()
    except ImportError:
        return "unknown-directory"

def get_directory_tree():
    try:
        import os
        from rich.tree import Tree
        from rich import print as prt

        def build_tree(path):
            tree = Tree(os.path.basename(path))
            for item in os.listdir(path):
                item_path = os.path.join(path, item)
                if os.path.isdir(item_path):
                    tree.add(build_tree(item_path))
                else:
                    tree.add(item)
            return tree

        return str(prt(build_tree(os.getcwd())))
    except ImportError:
        return "unknown-tree"
console = Console()

MACRO_MAP = {
    ":info:": "ℹ️",
    ":warn:": "⚠️",
    ":filetree:": "📦",
    ":try:": "🧪",
    ":check:": "✅",
    ":drone:": "🛩️",
    ":note:": "📝",
    ":tip:": "💡",
    ":question:": "❓",
    ":warning:": "🚨",
    ":error:": "❗",
    ":bug:": "🐛",
    ":idea:": "💡",
    ":star:": "⭐",
    ":heart:": "❤️",
    ":fire:": "🔥",
    ":rocket:": "🚀",
    ":link:": "🔗",
    ":video:": "🎥",
    ":audio:": "🎧",
    ":image:": "🖼️",
    ":code:": "💻",
    ":objective:": "🎯",
    ":tools:": "🛠️",
    ":context:": "🌐",
    ":pushpin:": "📌",
    ":satellite:": "🛰️",
    ":remember:": "🔔",
    ":current_date:": get_timestamp(),
    ":hostname:": get_hostname(),
    ":cwd:": get_current_working_directory(),
    ":current_time:": datetime.now().strftime("%H:%M:%S"),
    ":current_date_time:": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
    ":current_year:": datetime.now().strftime("%Y"),
    ":current_month:": datetime.now().strftime("%m"),
    ":current_day:": datetime.now().strftime("%d"),
}

def expand_macros(text):
    for tag, emoji in MACRO_MAP.items():
        text = text.replace(tag, emoji)
    return text


def load_yaml(path):
    with open(path, 'r') as f:
        return yaml.safe_load(f)

def main():
    parser = argparse.ArgumentParser(description="Lesson Viewer")
    parser.add_argument("file", help="Path to topic YAML file")
    parser.add_argument("--print-title", action="store_true", help="Print only the lesson title")

    args = parser.parse_args()
    data = load_yaml(args.file)

    title = data.get("title", "Untitled")

    if args.print_title:
        print(title)
        return

    content = data.get("content", "")
    console.print(Panel.fit(f"[bold cyan]{title}[/bold cyan]", border_style="cyan"))
    console.print(Markdown(expand_macros(content)))

if __name__ == "__main__":
    main()

