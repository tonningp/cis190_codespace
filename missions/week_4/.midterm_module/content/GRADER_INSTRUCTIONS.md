# Midterm Grader Instructions

## Evaluation Criteria:
1. **Commands Execution (Chapters 2–5)**:
   - Directory/file creation and navigation (Ch 2–3)
   - Permission changes and inspection (Ch 4)
   - Redirection and command chaining (Ch 5)

2. **Quiz Accuracy**:
   - Verify answers in `quiz.yaml`
   - Accept answers matching provided patterns (including regex)

3. **File Validation**:
   - Ensure correct files were created in `home/`
   - Review `history/` for command sequences

## Grading Notes:
- Accept equivalent valid commands (e.g., symbolic vs numeric chmod)
- Use `diff` or manual inspection to compare expected and submitted files
- Check for logical command order in `history`