pragma solidity ^0.6.2;

import "@openzeppelin/contracts/presets/ERC20PresetMinterPauser.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/GSN/Context.sol";

contract XpieToken is Context, ERC20PresetMinterPauser {

    using SafeMath for uint256;

    string _tokenName = "LibertyPie";
    string _tokenSymbol = "XPIE";
    uint8 _tokenDecimal = 8;
    uint256 _tokenInitialSupply = uint256(10000000000); //10b

    constructor() public ERC20PresetMinterPauser(_tokenName,_tokenSymbol) {
        _setupDecimals(_tokenDecimal);
        uint _tokenTotalSupply = _tokenInitialSupply.mul(10 ** uint256(_tokenDecimal));
        _mint(_owner, _tokenTotalSupply);
    }

}