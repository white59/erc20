// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Test} from "forge-std/Test.sol";
import {ERC20} from "../src/erc20/ERC20.sol";
import {DeployERC20} from "../script/DeployERC20.s.sol";

contract ERC20Test is Test {
    DeployERC20 deploy;
    ERC20 erc20;

    function setUp() public {
        deploy = new DeployERC20();
        erc20 = deploy.run();
    }

    /**
     * 测试铸币
     */
    function test_mintSuccess() public {
        erc20.mint(100);
        assertEq(erc20.balanceOf(address(this)), 100);
    }

    /**
     * 测试转账成功
     */
    function test_transferSuccess() public {
        erc20.mint(100);
        erc20.transfer(address(1), 100);
        assertEq(erc20.balanceOf(address(this)), 0);
        assertEq(erc20.balanceOf(address(1)), 100);
    }
}
