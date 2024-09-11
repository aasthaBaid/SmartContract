// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract VotingSystem {
    uint256 public max_vote_size = 280; // Placeholder for maximum vote size, similar to max_tweet_size

    struct Candidate {
        uint256 id;
        string name;
        uint256 votes;
    }

    struct Voter {
        bool hasVoted;
        uint256 candidateId;
    }

    mapping(uint256 => Candidate) public candidates;
    mapping(address => Voter) public voters;

    uint256 public candidateCount;
    address public owner;

    constructor(string[] memory candidateNames) {
        owner = msg.sender;

        for (uint256 i = 0; i < candidateNames.length; i++) {
            candidates[i] = Candidate(i, candidateNames[i], 0);
        }
        candidateCount = candidateNames.length;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "you are not that guy pal");
        _;
    }

    // Function to vote for a candidate
    function vote(uint256 candidateId) public {
        require(!voters[msg.sender].hasVoted, "You have already voted");
        require(candidateId < candidateCount, "Invalid candidate");

        voters[msg.sender] = Voter(true, candidateId);
        candidates[candidateId].votes++;
    }

    // Function to get votes for a specific candidate
    function getCandidateVotes(uint256 candidateId) public view returns (uint256) {
        require(candidateId < candidateCount, "Invalid candidate");
        return candidates[candidateId].votes;
    }

    // Function to get all candidates
    function getCandidates() public view returns (Candidate[] memory) {
        Candidate[] memory result = new Candidate[](candidateCount);
        for (uint256 i = 0; i < candidateCount; i++) {
            result[i] = candidates[i];
        }
        return result;
    }
}
