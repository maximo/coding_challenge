// Copyright SECURRENCY INC.
// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

/**
 * @title Solidity test task 4
 */

/**
 * This contract should compile
 * A stack overflow issue
 */
contract StackOverflow {
    struct AssetDetails {
        address currency;
        address settlementCurrency;
        bytes32 marketObjectCodeRateReset;
        uint contractDealDate;
        uint statusDate;
        uint initialExchangeDate;
        uint maturityDate;
        uint purchaseDate;
        uint capitalizationEndDate;
        uint cycleAnchorDateOfInterestPayment;
        uint cycleAnchorDateOfRateReset;
        uint cycleAnchorDateOfScalingIndex;
        uint cycleAnchorDateOfFee;
        int notionalPrincipal;
        int nominalInterestRate;
        int accruedInterest;
        int rateMultiplier;
    }
    
    function createAsset(
        AssetDetails memory data
    )
        external
    {
        require(data.currency != address(0x00), "Invalid currency address");
        require(data.settlementCurrency != address(0x00), "Invalid settlement currency address");
        require(data.marketObjectCodeRateReset != bytes32(0x00), "Code rate request is required");
        require(data.notionalPrincipal != 0, "notionalPrincipalnotionalPrincipal can't be empty");
        require(data.nominalInterestRate != 0, "nominalInterestRate can't be empty");
        require(data.accruedInterest != 0, "accruedInterest can't be empty");
        require(data.rateMultiplier != 0, "rateMultiplier can't be empty");
        require(data.contractDealDate != 0, "Contract deal date can't be empty");
        require(data.statusDate != 0, "statusDate can't be empty");
        require(data.initialExchangeDate != 0, "initialExchangeDate can't be empty");
        require(data.maturityDate != 0, "maturityDate can't be empty");
        require(data.purchaseDate != 0, "purchaseDate can't be empty");
        require(data.capitalizationEndDate != 0, "capitalizationEndDate can't be empty");
        require(data.cycleAnchorDateOfInterestPayment != 0, "cycleAnchorDateOfInterestPayment can't be empty");
        require(data.cycleAnchorDateOfScalingIndex != 0, "cycleAnchorDateOfScalingIndex can't be empty");
        require(data.cycleAnchorDateOfFee != 0, "cycleAnchorDateOfFee can't be empty");

        saveDetailsToStorage(
            data.currency,
            data.settlementCurrency,
            data.marketObjectCodeRateReset,
            data.notionalPrincipal,
            data.nominalInterestRate,
            data.accruedInterest,
            data.rateMultiplier
        );
        
        saveDatesToStorage(
            data.contractDealDate,
            data.statusDate,
            data.initialExchangeDate,
            data.maturityDate,
            data.purchaseDate,
            data.capitalizationEndDate,
            data.cycleAnchorDateOfInterestPayment,
            data.cycleAnchorDateOfRateReset,
            data.cycleAnchorDateOfScalingIndex,
            data.cycleAnchorDateOfFee
        );
    }
    
    function saveDetailsToStorage(
        address currency,
        address settlementCurrency,
        bytes32 marketObjectCodeRateReset,
        int notionalPrincipal,
        int nominalInterestRate,
        int accruedInterest,
        int rateMultiplier
    )
        internal
    {
        require(currency != address(0x00), "Invalid currency address");
        require(settlementCurrency != address(0x00), "Invalid settlement currency address");
        require(marketObjectCodeRateReset != bytes32(0x00), "Code rate request is required");
        require(notionalPrincipal != 0, "notionalPrincipalnotionalPrincipal can't be empty");
        require(nominalInterestRate != 0, "nominalInterestRate can't be empty");
        require(accruedInterest != 0, "accruedInterest can't be empty");
        require(rateMultiplier != 0, "rateMultiplier can't be empty");
        
        // implementation details
    }
    
    function saveDatesToStorage(
        uint contractDealDate,
        uint statusDate,
        uint initialExchangeDate,
        uint maturityDate,
        uint purchaseDate,
        uint capitalizationEndDate,
        uint cycleAnchorDateOfInterestPayment,
        uint cycleAnchorDateOfRateReset,
        uint cycleAnchorDateOfScalingIndex,
        uint cycleAnchorDateOfFee
    )
        internal
    {
        require(contractDealDate != 0, "Contract deal date can't be empty");
        require(statusDate != 0, "statusDate can't be empty");
        require(initialExchangeDate != 0, "initialExchangeDate can't be empty");
        require(maturityDate != 0, "maturityDate can't be empty");
        require(purchaseDate != 0, "purchaseDate can't be empty");
        require(capitalizationEndDate != 0, "capitalizationEndDate can't be empty");
        require(cycleAnchorDateOfInterestPayment != 0, "cycleAnchorDateOfInterestPayment can't be empty");
        require(cycleAnchorDateOfScalingIndex != 0, "cycleAnchorDateOfScalingIndex can't be empty");
        require(cycleAnchorDateOfFee != 0, "cycleAnchorDateOfFee can't be empty");

        // implementation details
    }
}