// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {IERC20} from "../interface/IERC20.sol";

contract ERC20 is IERC20 {
    // 获取余额
    mapping(address => uint256) public balanceOf;

    // 总发行量
    uint256 public totalSupply;

    // 授权额度
    mapping(address => mapping(address => uint256)) public allowance;

    // 代币名称
    string public name;
    // 代币符号
    string public symbol;

    // 构造函数，初始化代币名称，代币符号，代币总供给量
    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    /**
     * 转账
     * @param _to 接收者
     * @param _value 金额
     */
    function transfer(address _to, uint256 _value) external returns (bool) {
        // 获取发送者地址
        address _from = msg.sender;
        // 获取发送者余额
        uint256 senderBalance = balanceOf[_from];
        // 验证发送者余额大于转账金额
        require(senderBalance >= _value, "sender balance is not enough");
        // 转账
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        // 记录日志
        emit Transfer(_from, _to, _value);
        return true;
    }

    /**
     * 授权
     * @param _spender 授权地址
     * @param _value 授权额度
     */
    function approve(address _spender, uint256 _value) external returns (bool) {
        // 获取发送者地址
        address _from = msg.sender;
        // 验证授权额度
        require(balanceOf[_from] >= _value, "balance is not enough");
        // 获取授权额度
        uint256 approveValue = allowance[_from][_spender];
        require(
            approveValue + _value >= balanceOf[_from],
            "total approve is not enough"
        );
        // 授权
        allowance[_from][_spender] = approveValue + _value;
        // 记录日志
        emit Approval(_from, _spender, _value);
        return true;
    }

    /**
     * 授权转账
     * @param _from 转账人
     * @param _to 被转账人
     * @param _value 转账金额
     */
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool) {
        // 验证余额大于转账余额
        require(balanceOf[_from] >= _value, "balance is not enough");
        // 减余额
        balanceOf[_from] -= _value;
        // 减授权
        allowance[_from][msg.sender] -= _value;
        // 加金额
        balanceOf[_to] += _value;
        // 记录日志
        emit Transfer(_from, _to, _value);
        return true;
    }

    /**
     * 铸币
     * @param amount 铸造数量
     */
    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    /**
     * 销毁代币
     * @param amount 数量
     */
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
