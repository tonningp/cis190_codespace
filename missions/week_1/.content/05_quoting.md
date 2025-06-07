# Quoting in the Shell

## Single vs. Double Quotes

- `'single quotes'` prevent expansion
- `"double quotes"` allow expansion of variables

Example:

```bash
echo "$HOME"
echo '$HOME'
```

▶️ Demo: `asciinema play demos/quoting.cast`
