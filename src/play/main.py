import pandas as pd


def run():
    a = pd.DataFrame([1])
    b = 123
    return b


if __name__ == "__main__":
    a = run()
    print(a)
