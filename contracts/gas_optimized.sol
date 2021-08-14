// Copyright SECURRENCY INC.
// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

/**
 * @title Solidity test task 3
 */

/**
 * Test task "Investor registration"
 * A gas usage optimization
 * 
 * function "setLeadInvestorForARound" need to be optimized by a gas usage.
 * current transaction cost > 140 000
 * expected transaction cost < 55 000
 * 
 * Required to save the interface. 
 * All other modifications are allowed.
 **/
contract GasUsageOptimized {
    uint public investmentRound = 1;

    // ordering matters to optimize memory alignment
    struct Investor {
        address investor;
        uint8 age;
        uint64 investment;
        uint8 info; // using bits to store boolean information
    }
    mapping(uint => Investor) leadInvestors;

    function setInvestorByInvestmentRound(
        address investor,
        uint64 depositAmount,
        uint8 age,
        bool kycStatus,
        bool isVerifiedInvestor,
        bool isUSResident
    )
        external
    {
        require(investor != address(0), "Invalid investor address");
        require(depositAmount > 0, "A deposint amount should be more than zero");
        require(age > 18, "The investor should be adult");
        
        uint8 info = 0;
        if (kycStatus) info = 1 << 2;
        if (isVerifiedInvestor) info += 1 << 1;
        if (isUSResident) info += 1;

        leadInvestors[investmentRound] = Investor(
            investor,
            age,
            depositAmount,
            info
        );

        investmentRound++;
    }

    function getInvestorDetailsByInvestmentRound(
        uint round
    )
        external
        view
        returns (
            address investor,
            uint64 depositAmount,
            uint8 age,
            bool kycStatus,
            bool isVerifiedInverstor,
            bool isUSResident
        )
    {
        Investor memory v = leadInvestors[round];
        bool resident = false;
        uint8 info = v.info;
        if ((info & 1) == 1) resident = true;
        info = info >> 1;
        bool verified = false;
        if ((info & 1) == 1) verified = true;
        info = info >> 1;
        bool kyc = false;
        if ((info & 1) == 1) kyc = true;

        return (
            v.investor,
            v.investment,
            v.age,
            kyc,
            verified,
            resident
        );
    }
}