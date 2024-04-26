def run() -> int:
    a: int = 123
    return a


if __name__ == "__main__":
    import os

    print(os.environ)
    print("1  ")
    a = run()
    print(a)
