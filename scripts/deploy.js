// This script is used to deploy the Chainrity contract to the local blockchain
const { ethers } = require("hardhat");

async function main() {
    // Get the Chainrity contract to deploy
    const Chainrity = await ethers.getContractFactory("Chainrity");

    // Start deployment
    const chainrity = await Chainrity.deploy();
    await chainrity.deployed();

    console.log("Chainrity deployed to:", chainrity.address);
    console.log("Transaction hash:", chainrity.deployTransaction.hash);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });