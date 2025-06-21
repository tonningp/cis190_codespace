from textual.app import App, ComposeResult
from textual.containers import Container, VerticalScroll
from textual.widgets import Static
from textual import events
from textual.screen import ModalScreen

HELP_TEXT = """
# Help - Keyboard Shortcuts

- Ctrl+F1: Open this help screen
- Up/Down Arrows: Scroll through content
- Enter: Select item
- q: Quit the app

## Navigation
Use arrow keys or Vim-style navigation (j/k) to move between items.

## About
This is a sample help screen.
"""

class HelpScreen(ModalScreen):
    """A modal screen that shows scrollable help text."""

    def compose(self) -> ComposeResult:
        yield VerticalScroll(Static(HELP_TEXT, markup=True), id="help-content")

    def on_key(self, event: events.Key) -> None:
        if event.key == "escape" or event.key == "q":
            self.app.pop_screen()


class MyApp(App):
    CSS = """
    #help-content {
        padding: 1;
        height: 100%;
        width: 100%;
    }
    """
    BINDINGS = [("shift+f1", "show_help", "Show Help")]

    def action_show_help(self):
        self.push_screen(HelpScreen())

    def compose(self) -> ComposeResult:
        yield Static("Press Shift+F1 for Help", classes="center")


if __name__ == "__main__":
    app = MyApp()
    app.run()
