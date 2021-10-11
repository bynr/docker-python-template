from play.main import run


def test_run():
    ret = run()
    assert ret is not None
    assert ret == 123
