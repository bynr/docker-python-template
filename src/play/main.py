def run():
    a = 123
    return a


if __name__ == "__main__":
    import os

    print(os.environ)
    a = run()
    print(a)
