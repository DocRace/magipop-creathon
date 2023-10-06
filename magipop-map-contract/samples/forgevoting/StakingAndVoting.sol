pragma solidity ^0.8.0;

contract StakingAndVoting {
    struct Vote {
        address voter;
        uint256 stake;
    }

    mapping(address => uint256) public stakes;
    mapping(uint256 => Vote[]) public votes;

    function stake(uint256 _amount) public {
        stakes[msg.sender] += _amount;
    }

    function vote(uint256 _proposalId) public {
        require(stakes[msg.sender] > 0, "Must stake BTC before voting");
        votes[_proposalId].push(Vote(msg.sender, stakes[msg.sender]));
    }
}