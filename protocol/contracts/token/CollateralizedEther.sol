/*

    Copyright 2020 Kollateral LLC.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

*/

pragma solidity ^0.5.0;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "./CollateralizedToken.sol";
import "../common/utils/ExternalCaller.sol";

contract CollateralizedEther is CollateralizedToken, ExternalCaller {
    using SafeMath for uint256;

    constructor()
    public
    CollateralizedToken(address(1))
    { }

    function mint() external payable returns (bool)
    {
        return mintInternal(msg.value);
    }

    function transferUnderlying(address to, uint256 amount)
    internal
    returns (bool)
    {
        require(address(this).balance >= amount, "KEther: not enough ether balance");
        externalTransfer(to, amount);
        return true;
    }

    function isUnderlyingEther() public view returns (bool) {
        return true;
    }

    function totalReserve() public view returns (uint256)
    {
        return address(this).balance;
    }

    function () external payable { }
}
