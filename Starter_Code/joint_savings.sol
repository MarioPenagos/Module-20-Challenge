pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    // Variables to hold the two payable addresses for the joint savings account
    address payable accountOne;
    address payable accountTwo;

    // Public variables to track the last account that withdrew and the amount withdrawn
    address public lastToWithdraw;
    uint public lastWithdrawAmount;

    // Public variable to keep track of the contract balance
    uint public contractBalance;

    // Define a function named `withdraw` that will accept two arguments
    function withdraw(uint amount, address payable recipient) public {
        // Check if the recipient is one of the authorized accounts
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        // Check if the contract has sufficient balance for the withdrawal
        require(address(this).balance >= amount, "Insufficient funds!");

        // Update the lastToWithdraw if the current recipient is different
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Perform the transfer to the recipient
        recipient.transfer(amount);

        // Update the last withdrawal amount
        lastWithdrawAmount = amount;

        // Update the contract balance
        contractBalance = address(this).balance;
    }

    // Define a public payable function named `deposit`
    function deposit() public payable {
        // Update the contract balance
        contractBalance = address(this).balance;
    }

    // Define a public function named `setAccounts` that receives two payable addresses
    function setAccounts(address payable account1, address payable account2) public {
        // Assign the input addresses to accountOne and accountTwo
        accountOne = account1;
        accountTwo = account2;
    }

    // Fallback function to receive Ether
    function() external payable {
        // Update the contract balance
        contractBalance = address(this).balance;
    }
}
