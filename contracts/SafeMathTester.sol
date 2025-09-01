// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeMathTester {
    uint8 public bigInt = 255; // this is checked means not be converted to 0 if add +1.
    function add() public {
        unchecked{bigInt=bigInt+1;} //now it becomes unchecked it means if +1 then 255 -> 0.
    }
}