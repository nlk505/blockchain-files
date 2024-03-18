// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract votingsystem {
    
    //defining neccessary variables
    address public chair;
    address public voters;
    uint winningvote;
    uint winningindex;
    uint ind;

    //enum for voting status
    enum votingstatus {notstarted,ongoing,completed}
    votingstatus public status;

   //function for enum
    function setstatus() onlychair public{
        if(status != votingstatus.ongoing){
            status = votingstatus.ongoing;
        }
        else if(status != votingstatus.completed){
             status = votingstatus.completed;
        }
    
 } 
    //creating a structure for voters

    struct voter{
        address voterID;
        address candidateID;
    }
    //creating array for storing voterids
    voter[] voterlist;

    //creating a mapping to keep the track of votes by voters
     mapping (address => uint) public votecounter;
    //function to add voters and their prefered candidates
    function addvoter(address _voterID,address _candidateID) public{
        voterlist.push(voter(_voterID,_candidateID));
        votecounter[_voterID]=0;
    }
    //checking index of the voterid in voterlist array
    function index(address _voterid) public returns(bool){
        for (uint i ; i <voterlist.length; i++) 
        {   
            if (_voterid == voterlist[i].voterID) {
                ind = i;
            }
        }
        return true;
    }

    //creating a constructor which will store the chair address
    constructor() {
        chair = msg.sender; 
    }
    
    //defining an array which will store all address of every candidates
    address[] public candidates;

    //creating a mapping candidate address to number of votes gained by them
    mapping(address => uint) public votesGained;

    //creating a modifier
    modifier onlychair{
        require(msg.sender == chair, "not done by chair");
        _;
    }
    
    //creating candidate list
    function createcandidatelist(address _candidate) onlychair public{
        candidates.push(_candidate);
    }
   
    //function for voting
    function voting(address _voterID) public{
        //the function will only run after the following conditions are satisfied
        require(index(voterlist[ind].voterID),"index not correct");
        require(status == votingstatus.ongoing,"The election is complete");
        require(votecounter[_voterID] == 0," already voted");
        votecounter[_voterID] += 1;

        votesGained[voterlist[ind].candidateID] = votesGained[voterlist[ind].candidateID] + 1;
    }  

  
    //function to saw the winer
    function ressults() public returns(string  memory,address,string memory,uint,string memory){
         
         //condition
        require(status == votingstatus.completed,"The election is complete");

        for(uint i = 0;i < candidates.length; i++){
        if(votesGained[candidates[i]] > winningvote ){
            winningvote = votesGained[candidates[i]];
            winningindex = i;
        }}
        return ("the candidate",candidates[winningindex], "won by",winningvote,"votes");
    }
 
    }
    




    
