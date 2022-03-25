//SPDX-License-Identifier: MIT

pragma solidity ^0.8.2; 

import "./ownable.sol";
import "./context.sol";

/**
 * @title BEP20Token - iamhectorsv Token
 * @dev A BEP20 Token for the Binances Smart Chain
 */

contract BEP20 is Ownable {
    using SafeMath for uint256;
    mapping (address => uint256) internal _balances;    
    address private _owner;
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSuply;
    uint256 private _maxSuply;

    event Transfer(address indexed sender, address indexed recipient, uint amount);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event Mint(address indexed _minter, uint _amount);

    constructor(string memory _tokenName, string memory _tokenSymbol, uint _tokenMaxSuply) {
        _name = _tokenName;
        _symbol = _tokenSymbol;
        _decimals = 18;
        _maxSuply = _tokenMaxSuply;
        _totalSuply = _maxSuply * 10**uint256(_decimals);
        _balances[_msgSender()] = _totalSuply;
        _owner =  owner();

        emit Transfer(address(0), _msgSender(), _totalSuply);
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

    function transfer(address recipient, uint256 amount) external returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint amount) external returns (bool) {
        require(_msgSender() == sender);
        _transfer(sender, recipient, amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "BEP20: transfer from zero address");
        require(recipient != address(0), "BEP20: transfer from zero address");

        _balances[sender] = _balances[sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender , recipient, amount);
    }


    function mint(uint256 amount) public onlyOwner returns (bool) {
        _mint(_msgSender(), amount);
        return true;
    }

    // mint token amount
    function _mint(address account, uint256 amount) internal {
        require(account != (address(0)), "BEP20: mint to the zero address");

        amount = _amountToToken(amount);
        _totalSuply = _totalSuply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    function burn(uint256 amount) external onlyOwner {
        uint256 checkNewTotal = _totalSuply.sub(amount);
        require(checkNewTotal >= 42, "iamhectorsv: your burning too much");
        _burn(_msgSender(), amount);
    }

    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "BEP20: burn from the zero address");
        
        _totalSuply = _totalSuply.sub(amount);
        _balances[account] = _balances[account].sub(amount);
        emit Transfer(account, address(0), amount);
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

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtractioon overflow");
        uint256 c = a - b;
        return c;
    }
}
