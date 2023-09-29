import { ethers } from "hardhat";

async function main() {
  const Battles = await ethers.deployContract("BattleNft", []);

  await Battles.waitForDeployment();

  console.log(`BattlesBft deployed to ${Battles.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
