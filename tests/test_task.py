import brownie
import pytest 
from brownie.test import given, strategy
from hypothesis import settings

@pytest.fixture(scope="module")
def sc(TestTask, accounts):
    owner = accounts[0]
    sc = TestTask.deploy({'from': owner})
    return sc

#def test_convert_int_to_string(accounts, sc):
#    txn = sc.convert(99999)
#    print("number: ", txn)
#    assert txn == '99999'

#def test_convert_address_to_string(accounts, sc):
#    txn = sc.convert_address(accounts[0])
#    print("address: ", accounts[0])
#    assert txn == accounts[0]

@given(
    index=strategy('uint8', min_value=1, max_value=10),
    n=strategy('uint', min_value=0, max_value=2**256-1),
)
@settings(max_examples=1)
def test_template1(accounts, sc, index, n):
    addr = accounts[index]
    template = "Result: {account}, {number}"
    txn = sc.buildStringByTemplate(addr, n, template)
    print("result: ", txn)
    assert template.format(account=str(addr).lower(), number=n) == txn

@given(
    index=strategy('uint8', min_value=1, max_value=10),
    n=strategy('uint', min_value=0, max_value=2**256-1),
)
@settings(max_examples=1)
def test_template2(accounts, sc, index, n):
    addr = accounts[index]
    template = "number: {number}, account: {account}"
    txn = sc.buildStringByTemplate(addr, n, template)
    print("result: ", txn)
    assert template.format(account=str(addr).lower(), number=n) == txn

@given(
    index=strategy('uint8', min_value=1, max_value=10),
)
@settings(max_examples=1)
def test_template3(accounts, sc, index):
    addr = accounts[index]
    template = "account: {account}, account: {account}"
    txn = sc.buildStringByTemplate(addr, 0, template)
    print("result: ", txn)
    assert template.format(account=str(addr).lower()) == txn

@given(
    n=strategy('uint', min_value=0, max_value=2**256-1),
)
@settings(max_examples=1)
def test_template4(accounts, sc, n):
    addr = accounts[1]
    template = "number: {number}, number: {number}"
    txn = sc.buildStringByTemplate(addr, n, template)
    print("result: ", txn)
    assert template.format(number=n) == txn


def test_mirror1(accounts, sc):
    txn = sc.trimMirroringChars(["apple", "electricity", "year"])
    print("result: ", txn.return_value)
    assert "appectricitear" == txn.return_value

def test_mirror2(accounts, sc):
    txn = sc.trimMirroringChars(["ethereum", "museum", "must", "street"])
    print("result: ", txn.return_value)
    assert "ethereseststreet" == txn.return_value