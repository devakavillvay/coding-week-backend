import { ethers } from "hardhat";

async function main() {
    const VillvayCert = await ethers.getContractFactory("VillvayCerts");
    const villvayCert = await VillvayCert.deploy();

    await villvayCert.deployed();

    console.log(`contract sucessfully deployed to ${villvayCert.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
