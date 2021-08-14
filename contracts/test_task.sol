// Copyright SECURRENCY INC.
// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

/// - TestTask for tasks solutions (2 task to be solved)

/// To check your's results, please deploy a smart contract with tests related to
/// to the task and run a functions. Each call will emit an event with test details.
/// To be sure that your solution work's properly, pay your attention to the
/// "passed" field in the log output, it must be equal to "true".
/// "passed": true - expected result for all tests.


/**
 * @title Solidity test task 1
 */
contract TestTask {
    
    ///             ///
    ///    Task 1   ///
    ///             ///
    // Found the following 2 functions on stackexchange.com for how to convert address to string
    function convertAddress(address addr) internal pure returns (bytes memory) {
        bytes memory s = new bytes(40);
        for (uint i = 0; i < 20; i++) {
            bytes1 b = bytes1(uint8(uint(uint160(addr)) / (2**(8*(19 - i)))));
            bytes1 hi = bytes1(uint8(b) / 16);
            bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
            s[2*i] = char(hi);
            s[2*i+1] = char(lo);            
        }
        return abi.encodePacked('0x', s);
    }

    function char(bytes1 b) internal pure returns (bytes1 c) {
        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }

    /*
    function convertAddress(address a) internal pure returns (bytes memory b) {
        b = abi.encodePacked(a);
    }
    */

    // function to convert number into string/bytes
    function convert(uint a) internal pure returns (bytes memory) {
        if (a == 0) return '0';
        uint i = a;
        uint j = 0;
        while (i != 0) {
            j++;
            i /= 10;
        }
        bytes memory str = new bytes(j);
        for (j; j > 0; j--) {
            str[j-1] = bytes1(uint8(48 + a % 10));
            a /= 10;
        }
        return str;
    }

    /**
     * @dev Test task condition:
     * @dev by a condition, a function getString accepts some template
     * @dev and we agreed that {account} in the template must be 
     * @dev replaced by an "account" variable from the function,
     * @dev "{number}" must be replaced by a "number" variable
     * @dev Example
     * @dev template = "Example: {account}, {number}"
     * @dev result = "Example: 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c, 1250"
     * 
     * @notice You can see more examples in a tests.
     * 
     * @return result Updated template by a task condition
     */
    function buildStringByTemplate(address account, uint number, string calldata template) external pure returns (string memory) {
        /**
         * Write your code here
         * Try to do with the lowest gas consumption.
         * If you will use some libraries or ready solutions,
         * please add links in the "notice" comments section before the function.
         */
        bytes memory t = bytes(template);

         // convert address to bytes
        // address is the last 20 bytes of the Keccak-256 hash of the public key
        // an address with lower case letters is not checksummed
        // an address with upper case letters is checksummed

        //bytes memory acct = abi.encodePacked(account);
        bytes memory acct = '0';
        if (account != address(0)) acct = convertAddress(account);
        // convert number to bytes
        bytes memory n = convert(number);

        // compute length needed:
        uint k = 0;
        bytes1 tag;
        bool tagFound = false;
        for (uint i = 0; i < t.length; i++) {
            if (t[i] == '{') {
                tag = t[i+1];
                tagFound = true;
                continue;
            } 
            if (t[i] == '}') {
                // short-circuit to identify 'account' or 'number' tags
                if (tag == bytes1('a')) k += acct.length;
                if (tag == bytes1('n')) k += n.length;
                tagFound = false;
                continue;
            }
            if (tagFound == true) continue;
            k += 1;
        }
        // allocate byte array 
        bytes memory result = new bytes(k);

        // build string
        tagFound = false;
        k = 0;
        for (uint i = 0; i < t.length; i++) {
            if (t[i] == '{') {
                tag = t[i+1];
                tagFound = true;
                continue;
            } 
            if (t[i] == '}') {
                // short-circuit to identify 'account' or 'number' tags
                if (tag == bytes1('a')) {
                    for (uint j = 0; j < acct.length; j++) result[k++] = acct[j];
                } 
                if (tag == bytes1('n')) { 
                    for (uint j = 0; j < n.length; j++) result[k++] = n[j];
                }
                tagFound = false;
                continue;
            } 
            if (tagFound == true) continue;
            result[k++] = t[i];
        }
        
        return string(result);
    }
    
    ///             ///
    ///    Task 2   ///
    ///             ///
    
    /**
     * @dev Test task condition 2:
     * 
     * @dev Write a function which takes an array of strings as input and outputs 
     * @dev with one concatenated string. Function also should trim mirroring characters
     * @dev of each two consecutive array string elements. In two consecutive string elements
     * @dev "apple" and "electricity", mirroring characters are considered to be "le" and "el"
     * @dev and as a result these characters should be trimmed from both string elements,
     * @dev and concatenated string should be returned by the function. You may assume that
     * @dev array will consist of at least of one element, each element won't be an empty string.
     * @dev You may also assume that each element will contain only ascii characters.
     * 
     * @dev Example 1
     * @dev input:  "apple", "electricity", "year"
     * @dev output: "appectricitear"
     * 
     * @notice You can see more examples in a Task2Test smart contract.
     * 
     * @return result Minimized string by a task condition
     */
    function trimMirroringChars(string[] memory data) external returns (string memory) {
         /**
         * Write your code here
         * Try to do with the lowest gas consumption.
         * If you will use some libraries or ready solutions,
         * please add links in the "notice" comments section before the function.
         */
        uint[] memory trimmedword = new uint[](data.length);
        trimmedword[0] = 0;
        for (uint i = 1; i < data.length; i++) {
            bytes memory word1 = bytes(data[i-1]);
            uint length1 = word1.length - 1;
            bytes memory word2 = bytes(data[i]);
            // search for mirrors between words
            uint j = 0;
            while (word1[length1-j] == word2[j]) j += 1;
            trimmedword[i] = j;
        } 
        // compute total new length
        uint l = 0;
        for (uint i = 0; i < trimmedword.length; i++) {
            l += bytes(data[i]).length - (2 * trimmedword[i]);
        }
        bytes memory result = new bytes(l);

        l = 0;
        for (uint i = 0; i < data.length; i++) {
            bytes memory word = bytes(data[i]);
            uint end = word.length;
            if (i+1 < data.length) end -= trimmedword[i+1];
            for (uint k = trimmedword[i]; k < end; k++) {
                result[l++] = word[k];
            }
        }
        return string(result);
     }
}