# BattleNft Solidity Smart Contract

![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [How to Use](#how-to-use)

## Introduction

Welcome to the BattleNft Solidity Smart Contract! This contract allows you to create and manage unique battle NFTs (Non-Fungible Tokens) on the Polygon Mumbai testnet. Each NFT represents a warrior with various attributes like levels, life, speed, and strength.

You can mint new NFTs, view their attributes, and train them to increase their levels. This contract is designed for educational purposes and showcases how to create and interact with ERC-721 NFTs on the Ethereum blockchain.

Verified Contract on Polygon Mumbai: [View Contract Code](https://mumbai.polygonscan.com/address/0x10450837fB6e3e19018E559C18E415187a25Ec53#code)

### Features

#### `mint()`

Mint a new battle NFT and assign it to the caller.

#### `train(uint256 tokenId)`

Train an existing NFT to increase its levels, life, speed, and strength.

#### `generateCharacter(uint256 tokenId)`

Generate an SVG image representing the NFT with its attributes.

### Data Structures

- `BattlesNfts`: Struct to store NFT attributes such as levels, life, speed, and strength.

### External Dependencies

- OpenZeppelin Contracts: Importing ERC721URIStorage, Counters, Strings, and Base64 from OpenZeppelin Contracts.

### How to Use

1. Mint a new NFT using the `mint()` function.
2. View the attributes and SVG image of your NFT.
3. Train your NFT using the `train(uint256 tokenId)` function to increase its attributes.
