//SPDX-License-Identifier: MIT

pragma solidity ^0.8.2; 

/**
 * @title iamhectorsvcoin
 * @dev hectorsvill
 */

contract BEP20Token {
    mapping (address => uint256) private _balances;    
    address private _owner;
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSuply;

    event Transfer(address indexed from, address indexed to, uint value);

    constructor() {
        _name = "iamhectorsvcoin";
        _symbol = "hsvc";
        _decimals = 16;
        _totalSuply = 1000000 ** 10 * 16;
        _balances[msg.sender] = _totalSuply;
        _owner =  msg.sender;
    }

    function owner() public view returns (address) {
        return _owner;
    } 

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSuply() public view returns (uint256) {
        return _totalSuply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transferFrom(address from, address to, uint value) public returns (bool) {
        require(balanceOf(from) >= value, 'balance too low');
        _balances[to] += value;
        _balances[from] -= value;
        emit Transfer(from, to, value);
        return true;
    }
}