// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract DiplomaToken is ERC20, AccessControl {

    address public owner;
    uint public exchangeRate = 100; // 1 ether = 100 tokens

    constructor() ERC20("Diploma", "DIP") {
        owner = msg.sender;
        _mint(msg.sender, 1000000 * 10 ** decimals());
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function purchaseTokens() external payable {
        require(msg.value > 0, "Ether sent must be greater than 0");
        uint amount = msg.value * exchangeRate;
        _mint(msg.sender, amount);
        payable(owner).transfer(address(this).balance);
    }

    function transfer(address sender, address receiver, uint amount) public {
        require(balanceOf(sender) >= amount, "You don't have enough token");    
        _transfer(sender, receiver, amount);
    }
}