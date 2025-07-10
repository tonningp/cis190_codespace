# 🛠️ Bash Shell Debug Card

**Use this checklist when your Bash command isn’t working as expected.**

---

## 🧠 General Reminders

- ✅ Bash is *literal*. Every space, slash, and character matters.  
- ✅ If in doubt, use `echo` before running a risky command.

---

## ⚠️ Common Pitfalls

### 🔹 SPACES

```bash
# Wrong
cd /home /student

# Correct
cd /home/student

# Quotes for folders with spaces
cd "My Documents"
````

* Spaces split arguments! Use quotes to group names with spaces.

---

### 🔹 SLASHES `/`

* `/` is the **root directory** — used for absolute paths.
* `./` refers to the **current directory**.
* `../` goes **up one directory**.

```bash
echo "I am here:" && pwd
```

---

### 🔹 WILDCARDS

* `*` = any number of characters
* `?` = exactly one character

```bash
ls *.txt       # All text files
ls file?.sh    # file1.sh, file2.sh, NOT file10.sh
```

> 🔸 Tip: If nothing matches, the pattern may be passed literally. Use `shopt -s nullglob` to suppress that.

---

## 🧪 File Not Found? Ask Yourself:

* ❓ Did I type the path correctly? Try `ls` to check.
* ❓ Does the file really exist? (Check case sensitivity.)
* ❓ Any extra spaces or quotes?
* ❓ Am I in the right directory? Use `pwd`.

---

## 🧩 Quote Check

```bash
echo "Hello world"       # ✅ One argument
echo Hello world         # ✅ Two arguments
cd My Documents          # ❌ Error: Too many arguments
cd "My Documents"        # ✅ Correct
```

---

## ✅ Quick Fix Checklist

| Issue                  | Quick Tip                                  |
| ---------------------- | ------------------------------------------ |
| File/command not found | `ls` the file, check spelling and casing   |
| Too many arguments     | Look for extra spaces or unquoted paths    |
| Permission denied      | Use `chmod +x script.sh` or `sudo`         |
| Wildcard didn’t work   | Use `echo *` to preview what it expands to |
| Nothing happens        | Check for `#!/bin/bash` and permissions    |

---

## 🧰 Helpful Commands

* `pwd` – Show current directory
* `ls` – List files
* `file` – Show file type
* `man <command>` – Read the manual
