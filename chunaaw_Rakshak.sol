// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 <0.9.0;

contract voting
{
    address public head;  //head can only see the votes
    address[] public candidates;

    mapping(address => uint ) public voterlist;

    mapping(address =>uint16) public votereceived;
    address public winner;
    uint public totalvotes;

    constructor()
    {
        head=msg.sender; //who will supervise the voting
    }
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
     modifier onlychair{
        require(msg.sender == head, "not done by chair");
        _;
    }    

    function register(address _candidate) public
    {
        require(msg.sender==head);
        candidates.push(_candidate);
    }
    function Vote(address _voter,address _candidate) public
    {
        require(status == votingstatus.ongoing,"The election is complete or not started");
        require(voterlist[_voter]==0, "Already voted");
        require(Validate(_candidate));
         voterlist[_voter]=1;
        votereceived[_candidate]=votereceived[_candidate]+1; //to inc the number of votes for a candidate

    }
    function Validate(address _candidate) public view returns(bool) //to check if candidate is registered
    {
        for(uint i=0;i<candidates.length;i++)
        {
            if(candidates[i]==_candidate)
            {
                return true;
            }
        }
         return false;
    }
    function countVote(address _candidate) public view returns(uint)
    {
        require(Validate(_candidate));
        uint count=votereceived[_candidate];
        return count;

    }
    function result() public  
    {
        require(status == votingstatus.completed,"The election is not complete");
        require(msg.sender==head);
        for(uint i=0;i<candidates.length;i++)
        {
            if(votereceived[candidates[i]]> totalvotes)
            {
                totalvotes=votereceived[candidates[i]];
                winner=candidates[i];
            }
        }
        


    }
}