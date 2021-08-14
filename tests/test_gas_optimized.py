import brownie
import pytest 
from brownie.test import given, strategy
from hypothesis import settings

@pytest.fixture(scope="module")
def sc(GasUsageOptimized, accounts):
    owner = accounts[0]
    sc = GasUsageOptimized.deploy({'from': owner})
    return sc

# This test is to make sure my implementation is 
# complete and accurate
@given(
    amount=strategy('uint64', min_value=1, max_value=18446744073709551615),
    age=strategy('uint8', min_value=19, max_value=255),
    kyc_status=strategy('bool'),
    accredited_investor=strategy('bool'),
    us_resident=strategy('bool'),
)
@settings(max_examples=5)
def test_validation(accounts, sc, amount, age, kyc_status, accredited_investor, us_resident):
    investor = accounts[1]

    txn = sc.setInvestorByInvestmentRound(
        investor,
        amount,
        age,
        kyc_status,
        accredited_investor,
        us_resident
    )

    txn = sc.getInvestorDetailsByInvestmentRound(1)
    assert txn[0] == investor
    assert txn[1] == amount
    assert txn[2] == age
    assert txn[3] == kyc_status
    assert txn[4] == accredited_investor
    assert txn[5] == us_resident

@given(
    amount=strategy('uint64', min_value=1, max_value=18446744073709551615),
    age=strategy('uint8', min_value=19, max_value=255),
    kyc_status=strategy('bool'),
    accredited_investor=strategy('bool'),
    us_resident=strategy('bool'),
)
@settings(max_examples=5)
def test_gas_usage(accounts, sc, amount, age, kyc_status, accredited_investor, us_resident):
    investor = accounts[1]
    txn = sc.setInvestorByInvestmentRound(
        investor,
        amount,
        age,
        kyc_status,
        accredited_investor,
        us_resident
    )
    print('gas used: ', txn.gas_used)
    # validate that gas consumption is below 55,000
    assert txn.gas_used < 55000
