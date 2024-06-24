// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {ERC20} from "../src/erc20/ERC20.sol";

contract DeployERC20 is Script {
    ERC20 erc20;

    function run() public returns (ERC20) {
        vm.startBroadcast();
        erc20 = new ERC20("white59", "W");
        vm.stopBroadcast();
        return erc20;
    }
}
