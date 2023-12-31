// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract BattleNft is ERC721URIStorage {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct BattlesNfts {
        uint256 levels;
        uint256 speed;
        uint256 strength;
        uint256 life;
    }

    mapping(uint256 => BattlesNfts) public tokenIdtoBattleNft;

    constructor() ERC721("Battles", "BTLS") {}

    function generateCharacter(
        uint256 tokenId
    ) public view returns (string memory) {
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            "<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>",
            '<rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Warrior",
            "</text>",
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Levels: ",
            getLevels(tokenId),
            "Life: ",
            getLife(tokenId),
            "Speed: ",
            getSpeed(tokenId),
            "Strength: ",
            getStrength(tokenId),
            "</text>",
            "</svg>"
        );
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(svg)
                )
            );
    }

    function random(uint number) internal view returns (uint) {
        return
            uint(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        block.prevrandao,
                        msg.sender
                    )
                )
            ) % number;
    }

    function getLevels(uint256 tokenId) internal view returns (string memory) {
        uint256 levels = tokenIdtoBattleNft[tokenId].levels;
        return levels.toString();
    }

    function getLife(uint256 tokenId) internal view returns (string memory) {
        uint256 life = tokenIdtoBattleNft[tokenId].life;
        return life.toString();
    }

    function getSpeed(uint256 tokenId) internal view returns (string memory) {
        uint256 speed = tokenIdtoBattleNft[tokenId].speed;
        return speed.toString();
    }

    function getStrength(
        uint256 tokenId
    ) internal view returns (string memory) {
        uint256 strength = tokenIdtoBattleNft[tokenId].strength;
        return strength.toString();
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "Battles #',
            tokenId.toString(),
            '",',
            '"description": "Battles on chain",',
            '"image": "',
            generateCharacter(tokenId),
            '"',
            "}"
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    function mint() public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        tokenIdtoBattleNft[newItemId].levels = 0;
        tokenIdtoBattleNft[newItemId].life = random(newItemId);
        tokenIdtoBattleNft[newItemId].speed = random(newItemId);
        tokenIdtoBattleNft[newItemId].strength = random(newItemId);
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function train(uint256 tokenId) public {
        require(_exists(tokenId), "Please use an existing token");
        require(
            ownerOf(tokenId) == msg.sender,
            "You must own this token to train it"
        );
        tokenIdtoBattleNft[tokenId].levels += 1;
        tokenIdtoBattleNft[tokenId].life += 1;
        tokenIdtoBattleNft[tokenId].speed += 10;
        tokenIdtoBattleNft[tokenId].strength += 12;
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}
