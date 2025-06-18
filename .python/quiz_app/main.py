import os
import sys
from textual.app import App, ComposeResult
from textual.widgets import Static, Button
from parser import load_questions
from models import Question

# Ensure app runs only from the specified hidden directory
expected_path = "/workspaces/codespaces-blank/cis190_codespace/.python"
current_path = os.getcwd()

if not os.path.abspath(current_path).startswith(expected_path):
    print(f"Error: This application must be run from within '{expected_path}'")
    sys.exit(1)

class QuizApp(App):
    CSS_PATH = "styles.css"

    def __init__(self, quiz_file):
        super().__init__()
        self.quiz_title, self.questions = load_questions(quiz_file)
        self.current = 0
        self.user_answers = []

    def compose(self) -> ComposeResult:
        yield Static(self.quiz_title, id="title")
        self.update_question_ui()

    def update_question_ui(self):
        self.clear()
        q: Question = self.questions[self.current]
        yield Static(f"Q{self.current + 1}: {q.prompt}")
        if q.type == "multiple_choice":
            for i, option in enumerate(q.options):
                yield Button(option, id=f"option-{i}")
        elif q.type == "true_false":
            yield Button("True", id="option-true")
            yield Button("False", id="option-false")

    async def on_button_pressed(self, event):
        self.user_answers.append(event.button.id)
        self.current += 1
        if self.current < len(self.questions):
            self.update_question_ui()
        else:
            await self.show_results()

    async def show_results(self):
        self.clear()
        yield Static("Quiz complete!")
        yield Static(f"You answered {len(self.user_answers)} questions.")

if __name__ == "__main__":
    quiz_file = sys.argv[1] if len(sys.argv) > 1 else "questions/sample_quiz.yaml"
    app = QuizApp(quiz_file)
    app.run()
