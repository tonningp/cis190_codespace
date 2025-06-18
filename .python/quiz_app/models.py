from dataclasses import dataclass
from typing import List, Union

@dataclass
class Question:
    type: str
    prompt: str
    options: List[str] = None
    correct_answers: Union[List[int], bool] = None
