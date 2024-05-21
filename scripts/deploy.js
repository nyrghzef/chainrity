const { ethers } = require("hardhat");

async function main() {
    //Get the chairity contract to deploy
    const Chairity = await ethers.getContractFactory("Chairity");

    //start deployment
    const chainrity = await Chairity.deploy();
    console.log("Chairity deployed to:", chairity.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });