def test_hello():
    """Dummy test to make pytest happy"""
    assert True


def test_basic_math():
    """Another basic test"""
    assert 1 + 1 == 2


def test_string_operations():
    """Test string stuff"""
    name = "Python"
    assert name.lower() == "python"
    assert len(name) == 6
