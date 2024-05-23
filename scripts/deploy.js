// // This script is used to deploy the Chainrity contract to the local blockchain
// const { ethers } = require("hardhat");

// async function main() {
//     // Get the Chainrity contract to deploy
//     const Chainrity = await ethers.getContractFactory("chainrity");

//     // Start deployment
//     const chainrity = await Chainrity.deploy();
//     await chainrity.deploy();

//     console.log("Chainrity deployed to:", chainrity.address);
//     console.log("Transaction hash:", chainrity.deployTransaction.hash);
// }

// main()
//     .then(() => process.exit(0))
//     .catch((error) => {
//         console.error(error);
//         process.exit(1);
//     });

// This script is used to deploy the DonationPlatform contract to the local blockchain
const BigNumber = require('ethers').BigNumber;
const minimumDonationInEther = 0.1;


async function main() {
    // Get the DonationPlatform contract to deploy
    const DonationPlatform = await ethers.getContractFactory("DonationPlatform");
   


    const priceFeedAddress = "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419"; // replace with your price feed address
    const minimumDonation = hre.ethers.utils.parseEther(minimumDonationInEther.toString());
    ; // 0.1 ETH

    // Start deployment, replace with your constructor arguments if any
    const donationPlatform = await DonationPlatform.deploy(priceFeedAddress, minimumDonation);
    await donationPlatform.deployed();

    console.log("DonationPlatform deployed to:", donationPlatform.address);
    console.log("Transaction hash:", donationPlatform.deployTransaction.hash);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });