import yaml
from models import Question

def load_questions(file_path: str):
    with open(file_path, 'r') as f:
        data = yaml.safe_load(f)
    questions = []
    for q in data["questions"]:
        questions.append(Question(**q))
    return data["title"], questions
