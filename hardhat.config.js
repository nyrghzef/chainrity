require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require("@chainlink/hardhat-chainlink");
require('dotenv').config();


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  paths: {
    sources: "./contracts"
  },
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      forking: {
        url: "https://sepolia.infura.io/v3/27231dfa77724bada6829c319a868ebf", // replace with your node's URL
      },
    },
    
  },
  solidity: {
    version: "0.8.24",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
};