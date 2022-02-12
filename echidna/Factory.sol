// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.11;

import "../contracts/TWFactory.sol";
import "../contracts/drop/DropERC721.sol";
import "./Address.sol";

contract EchidnaFactory is EchidnaAddress {
    TWFactory public factory;
    TWFee public fee;

    constructor() {
        factory = new TWFactory(TRUSTED_FORWARDER);
        fee = new TWFee(TRUSTED_FORWARDER, address(factory));
        factory.addModuleImplementation(bytes32("DropERC721"), address(new DropERC721(address(fee))));
    }

    function deployProxy(bytes32 _moduleType, bytes memory _data) external returns (address) {
        return factory.deployProxy(_moduleType, _data);
    }
}