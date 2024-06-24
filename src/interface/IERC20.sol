// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

interface IERC20 {
    // 转账事件
    event Transfer(address indexed from, address indexed to, uint256 value);
    // 授权事件
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    // 1.获取余额
    function balanceOf(address account) external view returns (uint256);

    // 2.获取代币总供应量
    function totalSupply() external view returns (uint256);

    // 3.授权函数
    function approve(address spender, uint256 amount) external returns (bool);

    // 4.获取授权额度函数
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    // 5.转账函数
    function transfer(address to, uint256 amount) external returns (bool);

    // 6.授权转账函数
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}
