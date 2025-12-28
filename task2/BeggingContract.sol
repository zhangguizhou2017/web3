// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract BeggingContract {
    mapping(address => uint256) public balances;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    // 定义事件
    event Received(address indexed Sender, uint Value);


    modifier onlyOwner() {
        require(msg.sender == owner, 'only the owner can call this function');
        _;
    }

    function donate(
        address from,
        uint256 amount
    ) private {
        require(from != address(0), 'address need validate');
        require(amount > 0, 'amount need > 0');

        balances[from] += amount;
    }

    // 接收ETH时自动调用并释放Received事件
    receive() external payable {
        donate(msg.sender, msg.value);
        emit Received(msg.sender, msg.value);
    }

    fallback() external payable {
        donate(msg.sender, msg.value);
        emit Received(msg.sender, msg.value);
    }

    function withdraw() external onlyOwner returns(bool) {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, 'No funds to withdraw');

        (bool success, ) = payable(owner).call{value: contractBalance}("");
        require(success, 'Transfer failed');

        return true;
    } 

    function getDonation (
        address account
    ) external view returns(uint256) {
        require(account != address(0), 'account need validate');
        return balances[account];
    }
}