from prompt_toolkit import prompt
from prompt_toolkit.history import FileHistory
from prompt_toolkit.validation import Validator, ValidationError
from rich.console import Console
from typing import Optional, Callable

console = Console()

def rich_read(
    message: str,
    *,
    default: Optional[str] = None,
    password: bool = False,
    history_file: Optional[str] = None,
    validate: Optional[Callable[[str], None]] = None,
    retries: int = 3
) -> str:
    """Bash-style input with optional validation and history."""

    class SafeValidator(Validator):
        def validate(self, document):
            if validate:
                try:
                    validate(document.text)
                except Exception as e:
                    raise ValidationError(message=str(e))

    prompt_prefix = "$ " + message
    if default:
        prompt_prefix += f" [default: {default}]"
    prompt_prefix += " "

    attempt = 0
    while attempt < retries:
        try:
            user_input = prompt(
                prompt_prefix,
                is_password=password,
                history=FileHistory(history_file) if history_file else None,
                validator=SafeValidator() if validate else None,
                validate_while_typing=False,
            )
            return user_input if user_input.strip() else default
        except ValidationError as e:
            console.print(f"[red]Error:[/] {e}")
            attempt += 1

    raise RuntimeError("Maximum input attempts exceeded.")

def rich_select(
    message: str,
    options: list[str],
    *,
    default: Optional[int] = None
) -> str:
    console.print(f"$ {message}")
    for i, option in enumerate(options, start=1):
        console.print(f"  [{i}] {option}")

    def validate_choice(choice: str):
        if not choice.strip().isdigit():
            raise ValueError("Enter a number.")
        num = int(choice)
        if not (1 <= num <= len(options)):
            raise ValueError("Choice out of range.")

    selection = rich_read(
        f"Selection [1-{len(options)}]",
        default=str(default) if default else None,
        validate=validate_choice
    )
    return options[int(selection) - 1]

if __name__ == "__main__":
    console.print("[bold magenta]Bash-style REPL. Type 'exit' or press Ctrl+D to quit.[/]")
    try:
        while True:
            cmd = rich_read("", history_file=".repl_history")
            if cmd.strip().lower() == "exit":
                break
            elif cmd == "color":
                color = rich_select("Choose your favorite color", ["Red", "Green", "Blue"], default=1)
                console.print(f"$ Selected color: [cyan]{color}[/]")
            else:
                console.print(f"$ You entered: [green]{cmd}[/]")
    except (EOFError, KeyboardInterrupt):
        console.print("\n[bold red]REPL terminated.[/]")
