//SPDX-License-Identifier: MIT

pragma solidity ^0.8.2; 

import "./ownable.sol";
import "./context.sol";

/**
 * @title BEP20Token - iamhectorsv Token
 * @dev A BEP20 Token for the Binances Smart Chain
 */

contract iamhectorsv is Ownable, Context {
    mapping (address => uint256) internal _balances;    
    address private _owner;
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSuply;

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    constructor() {
        _name = "iamhectorsv";
        _symbol = "hsv";
        _decimals = 18;
        _totalSuply = 5 * 10**uint256(_decimals);
        _balances[msg.sender] = _totalSuply;
        _owner =  msg.sender;
    }

    function getOwner() external view returns (address) {
        return _owner;
    } 

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function decimals() external view returns (uint) {
        return _decimals;
    }

    function totalSuply() external view returns (uint256) {
        return _totalSuply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transferFrom(address from, address to, uint value) external returns (bool) {
        require(_balances[from] >= value, 'balance too low');
        _balances[to] += value;
        _balances[from] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    function mint(uint256 amount) public onlyOwner returns (bool) {
        _mint(_msgSender(), amount);
        return true;
    }

    // mint token amount
    function _mint(address account, uint256 amount) internal {
        require(account != (address(0)), "BEP20: mint to the zero address");

        amount = _amountToToken(amount);
        _totalSuply = SafeMath.add(_totalSuply, amount);
        _balances[account] = SafeMath.add(_balances[account], amount);
        emit Transfer(address(0), account, amount);
    }

    function _amountToToken(uint256 amount) internal pure returns (uint256) {
        return amount * 10**18;
    }
}

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
}
