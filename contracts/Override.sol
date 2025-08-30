// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {SimpleStorage} from "contracts/SimpleStorage.sol";

contract Override is SimpleStorage{

    function store(uint _favouriteNumber) public override {
        myFavouriteNumber = _favouriteNumber+5;
    }

}