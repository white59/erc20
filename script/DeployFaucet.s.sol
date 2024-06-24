// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Faucet} from "../src/faucet/Faucet.sol";
import {ERC20} from "../src/erc20/ERC20.sol";
import {Script} from "forge-std/Script.sol";
import {DeployERC20} from "./DeployERC20.s.sol";

/**
 * @title 部署水龙头合约
 * @author white59
 * @notice
 */
contract DeployFaucet is Script {
    Faucet public faucet;
    ERC20 erc20;

    function run() public returns (ERC20, Faucet) {
        vm.startBroadcast();
        // 部署 ERC20 合约
        // DeployERC20 deploy = new DeployERC20();
        erc20 = new ERC20("WETH", "WETH");
        // 部署Faucet合约，传入ERC20合约地址
        faucet = new Faucet(address(erc20));
        vm.stopBroadcast();
        return (erc20, faucet);
    }
}
