// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24; //stating version of solidity

contract SimpleStorage{
    // bool hasFavouriteNumber = true;
    uint myFavouriteNumber;
    // uint256[] listOfFavNums;
    // string FavouriteNumberInText = "Eight";
    // int256 FavouriteNumberNeg = -8;
    // address myAddress=0x2f58bb8780191e71B538834FfA2329b8Cbb533Af;
    // bytes32 animal = "cat";

    struct Person {
        uint favNum;
        string name;
    }

    Person[] public listOfPeople;

    mapping(string => uint) public nameToFavNum;

    Person public mybrother = Person(21,"Tushar");
    // Person public mybrother = Person({favNum:21,name:"Tushar"});

    function store(uint _favouriteNumber) public {
        myFavouriteNumber = _favouriteNumber;
    }

    function retreive() public view returns (uint) {
        return myFavouriteNumber;
    }

    function addPerson(string memory _name, uint _favNum) public {
        listOfPeople.push(Person(_favNum,_name));
        nameToFavNum[_name] = _favNum;
    }
}