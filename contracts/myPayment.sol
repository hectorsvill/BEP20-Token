// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
import "./ownable.sol";
import "./context.sol";

/**
 *  @dev The contract can receive eth and will record
 *  all transactios. The owner of the contract can
 *  withdraw funds at any time.
 */

contract MyPayment is Ownable, Context {
    mapping(address => uint) public addressToValue;
    
    struct Transaction {
        address payer;
        uint value;
        uint time;
    }

    Transaction[] public transactions;

    function addYourPayment() public payable {
        require(msg.value >= 1000);
        addressToValue[_msgSender()] += msg.value;
        transactions.push(Transaction(_msgSender(), msg.value, uint(block.timestamp)));
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withdrawBalanceFromContract() public onlyOwner {
        uint balance = getBalance();
        payable(owner()).transfer(balance);
    } 
} 