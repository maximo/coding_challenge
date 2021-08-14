import brownie
import pytest 
from brownie.test import given, strategy
from hypothesis import settings

@pytest.fixture(scope="module")
def sc(GasUsageOptimisation, accounts):
    owner = accounts[0]
    sc = GasUsageOptimisation.deploy({'from': owner})
    return sc

@given(
    amount=strategy('uint64', min_value=1, max_value=18446744073709551615),
    age=strategy('uint8', min_value=19, max_value=255),
    kyc_status=strategy('bool'),
    accredited_investor=strategy('bool'),
    us_resident=strategy('bool'),
)
@settings(max_examples=2)
def test_gas_usage(accounts, sc, amount, age, kyc_status, accredited_investor, us_resident):
    investor = accounts[1]
    txn = sc.setLeadInvestorForARound(
        investor,
        amount,
        age,
        kyc_status,
        accredited_investor,
        us_resident
    )
    print('gas used: ', txn.gas_used)
    # verify gas consumption is within the range of 150,000
    assert txn.gas_used > 100000
