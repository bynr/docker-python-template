import pandas as pd


def do_a():
    a = pd.DataFrame([1])
    b = 123
    return a


if __name__ == "__main__":
    a = do_a()
    print(a)
