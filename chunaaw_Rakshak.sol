// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

contract voting {
    address public head;  // head can only see the votes
    address[] public candidates;

    mapping(address => uint) public voterlist;
    mapping(address => uint16)  votereceived;
    address public winner;
    uint public totalvotes;

    uint private secretCode; // store the secret code

    constructor(uint _secretCode) {
        head = msg.sender; // who will supervise the voting
        secretCode = _secretCode; // secret code set during contract deployment
    }

    enum votingstatus {notstarted, ongoing, completed}
    votingstatus public status;

    // Function for enum
    function setstatus(uint _secretCode) public onlychair requireSecretCode(_secretCode)  {
        if (status != votingstatus.ongoing) {
            status = votingstatus.ongoing;
        } else if (status != votingstatus.completed) {
            status = votingstatus.completed;
        }
    }

    modifier onlychair {
        require(msg.sender == head, "not done by chair");
        _;
    }

    modifier requireSecretCode(uint _secretCode) {
        require(_secretCode == secretCode, "Invalid secret code");
        _;
    }

    function register(address _candidate, uint _secretCode) public onlychair requireSecretCode(_secretCode) {
        candidates.push(_candidate);
    }

    function Vote(address _voter, address _candidate) public {
        require(_voter == msg.sender,"Proxy voting is not allowed");
        require(status == votingstatus.ongoing, "The election is complete or not started");
        require(voterlist[_voter] == 0, "Already voted");
        require(Validate(_candidate));
        voterlist[_voter] = 1;
        votereceived[_candidate] = votereceived[_candidate] + 1; // to increase the number of votes for a candidate
    }

    function Validate(address _candidate) public view returns (bool) {
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i] == _candidate) {
                return true;
            }
        }
        return false;
    }

    function countVote(address _candidate) public view returns (uint) {
        require(Validate(_candidate));
        uint count = votereceived[_candidate];
        return count;
    }

    function result(uint _secretCode) public onlychair requireSecretCode(_secretCode) {
        require(status == votingstatus.completed, "The election is not complete");
        for (uint i = 0; i < candidates.length; i++) {
            if (votereceived[candidates[i]] > totalvotes) {
                totalvotes = votereceived[candidates[i]];
                winner = candidates[i];
            }
        }
    }
}
