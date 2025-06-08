Perfect — here's the updated **Week 1 `README.md`** (mission-briefing style) incorporating the **official objectives from Chapter 2** of the 4th edition of *A Practical Guide to Linux Commands, Editors, and Shell Programming* by Sobell.

---

````markdown
# 🛰️ Week 1 Mission Briefing: Getting Started with Linux (Chapter 2)

**Mission Start Date:** June 23, 2025  
**Mission Window:** June 23 – June 28  
**Deliverables:**  
- ✅ Project 1: Terminal Navigation Log  
- ✅ Quiz 1: Chapter 2 Fundamentals  
- ✅ Forum Check-in: Introductions & Use Cases  

---

## 🎯 Mission Objective

This week, your mission is to **establish control of your Linux terminal** environment, understand the interface, and begin operating with confidence and caution. You are learning to work **as a technician**, not just a user — and that begins by mastering how to log in, navigate, repeat commands, and seek help in the system.

You'll read **Chapter 2: Getting Started with Linux** and complete your first operational logs in the terminal.

---

## 🧭 Learning Objectives (Chapter 2)

After completing this week's mission, you should be able to:

- ✅ Log in to a Linux system using the textual interface
- ✅ Describe advantages of the textual interface
- ✅ Correct typing mistakes on the command line
- ✅ Use `kill` to abort a running program using a termination signal
- ✅ Repeat and edit previous commands
- ✅ Understand risks when using **root privileges**
- ✅ Use `man` and `info` to read command documentation
- ✅ Use the `--help` option for quick command reference
- ✅ Change your password from the command line

---

## 🛠️ Commands You’ll Use

| Command     | Purpose                                       |
|-------------|-----------------------------------------------|
| `login`     | Access the system (Codespaces: automatic)     |
| `passwd`    | Change your password                          |
| `history`   | Show previous commands                        |
| `!!`, `!n`  | Repeat previous commands                      |
| `kill`      | Terminate a process                           |
| `man`, `info` | Access utility manuals                     |
| `--help`    | Show usage help for a command                 |
| `echo`, `pwd`, `ls`, `cd`, `mkdir`, `touch` | General file navigation |

---

## 📁 Project Setup

In your GitHub Codespace terminal, create your weekly folders:

```bash
mkdir week{1..8}
cd week1
````

---

## 📝 Project 1: Terminal Navigation Log

Create a file named `navigation_log.txt` in your `week1/` directory. Your log should include:

1. A summary of:

   * How you navigated the terminal
   * How you accessed help (`man`, `--help`)
   * How you repeated or corrected commands
   * How you changed your password (if applicable)

2. A transcript or screenshot of:

   * A few key commands you ran
   * One example of using `kill` (e.g., `kill -9 PID` on a dummy job like `sleep 60 &`)
   * One mistake you made and how you fixed it

---

## 📘 Reading Assignment

Read Chapter 2 of Sobell’s *A Practical Guide to Linux Commands, Editors, and Shell Programming*.
Focus on the login process, command-line editing, and self-help methods (`man`, `info`, `--help`).

---

## 🧠 Quiz 1: Command Fundamentals

This quiz covers:

* Login and shell behavior
* Repeating/editing commands
* Command documentation
* `kill` and its use
* `passwd` and system access security

---

## 💬 Forum Check-in

Introduce yourself and answer:

> What's one reason a drone technician should be comfortable using a terminal interface instead of relying on a graphical UI?

---

## 📍 Debrief Goals

By the end of this mission, you should:

* Understand the login process and textual interface
* Know how to issue and edit basic commands
* Use built-in help systems
* Safely change your password and end a process
* Begin thinking like a system-level technician

---

🛰️ **Next Mission:** Chapter 3 – The Utilities (Week 2)

> This is where your toolkit starts to grow. Come ready.

```

---

Let me know if you'd like:
- This written into a `week1/README.md` auto-gen script
- A set of 8 templates scaffolded ahead of time for all weeks
- A sample `navigation_log.txt` for students to model their submission after
```
