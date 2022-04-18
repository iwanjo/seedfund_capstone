// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// We will initialize the smart contract seedfundInvestments to have 4 variables.
contract SeedfundInvestment {
    int256 balance;
    int256 userDeposit;
    int256 minDeposit;
    int256 userReturnInvestment;

    // Initializing smart contract variables
    constructor() public {
        balance = 0;
        userDeposit = 0;
        minDeposit = 2;
        userReturnInvestment = 0;
    }


    // This function will read the balance and return it to the screen
    function getBalance() public view returns (int256) {
        return balance;
    }

    //This function will return the deposit amount entered by the user
    function getUserDeposit() public view returns (int256) {
        return userDeposit;
    }
    //This operation will add the deposit amount to the amount
    function addDeposit(int256 amount) public {
        userDeposit = userDeposit + amount;
        if (userDeposit >= minDeposit) {
            balance = userDeposit + userReturnInvestment;
        }
    }
    //This operation will withdraw the balance from the user account
    function withdrawBalance() public {
        balance = 0;
        userDeposit = 0;
    }

}