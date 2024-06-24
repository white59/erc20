// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Test} from "../forge-std/Test.sol";
import {DeployFaucet} from "../script/DeployFaucet.s.sol";
import {Faucet} from "../src/faucet/Faucet.sol";
import {ERC20} from "./ERC20.t.sol";

/**
 * @title 水龙头测试
 * @author white59
 * @notice
 */
contract FaucetTest is Test {
    DeployFaucet deployer;
    Faucet faucet;
    ERC20 erc20;

    function setUp() public {
        deployer = new DeployFaucet();
        (erc20, faucet) = deployer.run();
    }

    function test_requestToken() public {
        // 1.铸币
        erc20.mint(100 ether);
        // 2.从ERC20地址转移代币给Faucet地址
        erc20.transfer(address(faucet), 100 ether);
        // 3.领取代币
        faucet.requestToken();
        // 4.断言
        assertEq(erc20.balanceOf(address(this)), 1);
    }
}
