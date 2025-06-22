import os
import sys
import json
import re
from textual.app import App, ComposeResult
from textual.widgets import Static, Button, Input, Footer
from textual.containers import Vertical, Horizontal, VerticalScroll, Grid
from parser import load_questions
import requests
import io
import yaml
from models import Question
from modals.helpscreen import HelpScreen

MODULE_PATH = os.getenv('BASE_DIR')
if MODULE_PATH is None:
    print("Error: BASE_DIR environment variable is not set.")
    sys.exit(1)
expected_path = "/workspaces/codespaces-blank/cis190_codespace/.python"
if not os.path.abspath(os.getcwd()).startswith(expected_path):
    print(f"Error: This application must be run from within '{expected_path}'")
    sys.exit(1)

def log_debug(message: str):
    with open("debug.log", "a") as f:
        f.write(message + "\n")

class QuizApp(App):
    CSS_PATH = "styles.css"
    BINDINGS = [("q", "quit", "Quit the quiz"),
                 ("j", "scroll_down", "Scroll down"),
                ("k", "scroll_up", "Scroll up"),
                ("shift+f1", "show_help", "Show Help"),
                ]

    def __init__(self, quiz_file):
        super().__init__()
        self.quiz_file = quiz_file
        self.quiz_title = ""
        self.questions = []
        self.current = 0
        self.user_answers = []
        self.selected_options = set()

    def compose(self) -> ComposeResult:
        yield Static("Press Shift+F1 for Help, Expand terminal to full screen.  Use tab key to move between choices, press Enter to select the choice, you can also click on the choice with the mouse.", classes="center")
        yield Static("Loading quiz...", id="title")
        yield Vertical(id="quiz-container")

    def on_mount(self) -> None:
        self.quiz_title, self.questions = self.load_quiz(self.quiz_file)
        self.user_answers = [None] * len(self.questions)

        title_widget = self.query_one("#title", Static)
        title_widget.update(self.quiz_title)

        self.update_question_ui()

    def update_question_ui(self):
        container = self.query_one("#quiz-container",Vertical)
        container.remove_children()
        self.selected_options = set()

        q: Question = self.questions[self.current]
        container.mount(Static(q.prompt))

        if q.type == "multiple_choice":
            previous = self.user_answers[self.current] or []
            self.selected_options = {f"option-{i}" for i in previous}
             # Create grid container
            grid = Grid(classes="choice-grid")
            container.mount(grid)
            for i, option in enumerate(q.options):
                btn = Button(option, id=f"option-{i}")
                if f"option-{i}" in self.selected_options:
                    btn.add_class("selected")
                grid.mount(btn)

        elif q.type == "true_false":
            grid = Grid(classes="choice-grid")
            container.mount(grid)
            current_val = self.user_answers[self.current]
            btn_true = Button("True")
            btn_false = Button("False")
            if current_val is True:
                btn_true.add_class("selected")
            elif current_val is False:
                btn_false.add_class("selected")
            grid.mount(btn_true)
            grid.mount(btn_false)

        elif q.type == "short_answer":
            previous = self.user_answers[self.current] or ""
            input_box = Input(value=previous, placeholder="Type your answer here...", id="short-input")
            container.mount(input_box)

        nav_row = Grid(classes="nav-row")
        container.mount(nav_row)
        nav_row.mount(Button("Previous", classes="nav-btn"))
        nav_row.mount(Button("Next", classes="nav-btn"))

        progress_bar =  Static("", classes="progress-bar")
        progress_fraction = (self.current + 1) / len(self.questions)
        progress_bar_len = 20
        filled_len = int(progress_bar_len * progress_fraction)
        bar = "█" * filled_len + "-" * (progress_bar_len - filled_len)
        percent = int(progress_fraction * 100)
        answered = self.user_answers[self.current] is not None
        check = " ✔" if answered else ""
        progress_bar.update(f"[{bar}] {percent}% — Q{self.current + 1} of {len(self.questions)}{check}")
        container.mount(progress_bar)
    
    def action_scroll_down(self):
        scroll = self.query_one("#quiz-summary", expect_type=VerticalScroll)
        scroll.scroll_to(y=scroll.scroll_offset.y + 5)
        #log_debug("Scrolled down")

    def action_scroll_up(self):
        scroll = self.query_one("#quiz-summary", expect_type=VerticalScroll)
        scroll.scroll_to(y=scroll.scroll_offset.y - 5)
        #log_debug("Scrolled up")

    def action_show_help(self):
        self.push_screen(HelpScreen())



    async def on_button_pressed(self, event):
        label = str(event.button.label).lower()

        if str(event.button.label).lower() == "exit quiz":
            await self.action_quit()
            return

        if self.current >= len(self.questions):
            return

        q: Question = self.questions[self.current]

        if q.type == "multiple_choice" and event.button.id and event.button.id.startswith("option-"):
            if event.button.id in self.selected_options:
                self.selected_options.remove(event.button.id)
                event.button.remove_class("selected")
            else:
                self.selected_options.add(event.button.id)
                event.button.add_class("selected")
            return

        if q.type == "true_false":
            if label == "true":
                self.user_answers[self.current] = True
                self.update_question_ui()
                return
            elif label == "false":
                self.user_answers[self.current] = False
                self.update_question_ui()
                return

        if q.type == "short_answer":
            input_widget = self.query_one("#short-input", Input)
            self.user_answers[self.current] = input_widget.value.strip()

        if label == "next":
            if q.type == "multiple_choice":
                selected = sorted([int(opt.split("-")[1]) for opt in self.selected_options])
                self.user_answers[self.current] = selected
            self.current += 1
            if self.current < len(self.questions):
                self.update_question_ui()
            else:
                await self.show_results()
            return

        if label == "previous":
            if self.current > 0:
                self.current -= 1
                self.update_question_ui()

    async def show_results(self):
        container = self.query_one("#quiz-container", Vertical)
        container.remove_children()

        score = 0
        #scroll_view = self.query_one("#scroll-container",ScrollView)
        scroll_view = VerticalScroll(id="quiz-summary")
        await container.mount(scroll_view)
        #v = Vertical()
        #container.mount(v)
        #v.mount(scroll_view)
        await scroll_view.mount(Static("Quiz complete, scroll down to review and see final score! Scroll by using arrow keys or with the mouse scroll.", id="result"))

        for i, (q, ans) in enumerate(zip(self.questions, self.user_answers)):
            correct = q.correct_answer
            try:
                if q.type == "short_answer":
                    pattern = re.compile(correct, re.IGNORECASE)
                    is_correct = bool(pattern.fullmatch(ans))
                    if is_correct:
                        score += 1
                    result_symbol = "✔ Correct" if is_correct else "✘ Incorrect"
                    feedback = (
                        f"Q{i+1}: {q.prompt}\n"
                        f"Your answer: {ans}\n"
                        f"Expected: {correct}\n"
                        f"Result: {result_symbol}"
                    )
                elif q.type == "multiple_choice":
                    selected_text = [q.options[i] for i in ans]
                    correct_text = [q.options[i] for i in correct]
                    is_correct = ans == correct
                    if is_correct:
                        score += 1
                    result_symbol = "✔ Correct" if is_correct else "✘ Incorrect"
                    feedback = (
                        f"Q{i+1}: {q.prompt}\n"
                        f"Your answer: {selected_text}\n"
                        f"Expected: {correct_text}\n"
                        f"Result: {result_symbol}"
                    )
                else:
                    is_correct = ans == correct
                    if is_correct:
                        score += 1
                    result_symbol = "✔ Correct" if is_correct else "✘ Incorrect"
                    feedback = (
                        f"Q{i+1}: {q.prompt}\n"
                        f"Your answer: {ans}\n"
                        f"Expected: {correct}\n"
                        f"Result: {result_symbol}"
                    )
            except Exception as e:
                feedback = f"Q{i+1}: Error computing result: {e}"

            await scroll_view.mount(Static(feedback))

        await scroll_view.mount(Static(f"Score: {score}/{len(self.questions)}"))
        container.mount(Button("Exit Quiz"))

        with open(f"{MODULE_PATH}/history/quiz_results.json", "w") as f:
            json.dump({
                "score": score,
                "total": len(self.questions),
                "answers": self.user_answers,
            }, f, indent=2)

    def load_quiz(self, path_or_url):
        if path_or_url.startswith("http://") or path_or_url.startswith("https://"):
            try:
                response = requests.get(path_or_url)
                response.raise_for_status()
                data = yaml.safe_load(io.StringIO(response.text))
            except Exception as e:
                print(f"Error loading quiz from URL: {e}")
                sys.exit(1)
        else:
            data = load_questions(path_or_url)
        return data

if __name__ == "__main__":
    quiz_file = sys.argv[1] if len(sys.argv) > 1 else "questions/sample_quiz.yaml"
    app = QuizApp(quiz_file)
    app.run()
