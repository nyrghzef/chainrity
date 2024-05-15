// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.19;

import "@chainlink/contracts/src/v0.8/KeeperCompatibleInterface.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract DonationPlatform is KeeperCompatibleInterface {

    // Donation struct to hold details about each donation
    struct Donation {
        address donor;
        address payable recipient;
        uint256 amount;
        uint256 timestamp;
        bool isRecurring;
    }

    // Mapping to store donations indexed by donation ID
    mapping(uint256 => Donation) public donations;

    // Variable to store next donation ID
    uint256 public nextDonationId;

    // Chainlink Price Feed address for reference currency (e.g., USD)
    address public priceFeedAddress;

    // Minimum donation amount in Wei
    uint256 public minimumDonation;

    // Donation created event
    event DonationCreated(uint256 donationId, address donor, address recipient, uint256 amount, uint256 timestamp, bool isRecurring);

    constructor(address _priceFeedAddress, uint256 _minimumDonation) {
        priceFeedAddress = _priceFeedAddress;
        minimumDonation = _minimumDonation;
        nextDonationId = 1;
    }

    // Function to donate to a recipient with optional recurring donations
    function donate(address payable _recipient, uint256 _amount, bool _isRecurring) public payable {
        require(_amount >= minimumDonation, "Donation amount must be greater than or equal to minimum donation");
        donations[nextDonationId] = Donation(msg.sender, _recipient, _amount, block.timestamp, _isRecurring);
        nextDonationId++;
        emit DonationCreated(nextDonationId - 1, msg.sender, _recipient, _amount, block.timestamp, _isRecurring);
        // Transfer the donation amount to the recipient
        _recipient.transfer(msg.value);
    }

    // Function to check if upkeep is needed (for automatic recurring donations)
    function checkUpkeep(bytes calldata checkData) external view override returns (bool upkeepNeeded, bytes memory performData) {
        // we can replace the logic to check for upcoming recurring donations
        // This function checks for donations marked recurring after 1 day from donation timestamp
        upkeepNeeded = upcomingRecurringDonation();
        performData = ""; 
    }
    // Function to perform upkeep (automatic recurring donations)
    function performUpkeep(bytes calldata performData) external override {
        // Logic to process automatic recurring donations based on checkUpkeep results
        if (upcomingRecurringDonation()) {
            // Call donate function again for the recurring donation
           
            // we need to calculate the new donation amount based on the original amount
           
        }
    }

    // Helper function to check for upcoming recurring donations
    function upcomingRecurringDonation() private view returns (bool) {
        // Iterate through donations and check for upcoming recurring ones based on timestamp
        // We can change the logic
        for (uint256 i = 1; i < nextDonationId; i++) {
            Donation memory donation = donations[i];
            if (donation.isRecurring && block.timestamp - donation.timestamp >= 1 days) {
                return true;
            }
        }
        return false;
    }

    // Function to get minimum donation amount in reference currency (e.g., USD) using Chainlink Price Feed
    function getMinimumDonationInUSD() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(priceFeedAddress);
        (,int256 answer,,) = priceFeed.latestRoundData();
        // Convert minimumDonation in Wei to reference currency using price feed data
        // additional logic needed for conversion based on price feed decimals etc.
        return minimumDonation * uint256(answer);
    }
}
