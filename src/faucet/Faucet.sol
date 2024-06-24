// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {IERC20} from "../interface/IERC20.sol";

/**
 * @title 代币水龙头合约
 * @author white59
 * @notice
 */
contract Faucet {
    // 合约地址
    address public tokenContract;
    // 代币领取时间
    mapping(address => uint256) public requestAddress;
    // 每次领取的代币数量
    uint256 constant tokenAmount = 1;

    // 定义转账事件
    event Faucet_Transfer(address indexed to, uint256 value);

    constructor(address _tokenContract) {
        tokenContract = _tokenContract;
    }

    /**
     * 领取代币，
     * 每个地址24小时领取一次
     */
    function requestToken() public {
        // 验证是否已经领取过代币
        require(
            block.timestamp - requestAddress[msg.sender] <= 1 days,
            "You have already requested tokens, please wait for 24 hours."
        );
        // 验证合约地址是否正确
        require(
            tokenContract != address(0),
            "Token contract address is not set."
        );
        // 进行转账
        IERC20(tokenContract).transfer(msg.sender, tokenAmount);
        requestAddress[msg.sender] = block.timestamp;
        emit Faucet_Transfer(msg.sender, tokenAmount);
    }
}
