pragma solidity ^0.8.0;

interface IZRC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract StakingAndVoting is IZRC20 {
    string public constant name = "ZetaToken";
    string public constant symbol = "ZTA";
    uint8 public constant decimals = 18;
    uint256 public _totalSupply = 1000000 * (10 ** uint256(decimals));
    
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
    
    constructor() {
        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);aa
    }
    
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(amount <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - amount;
        balances[recipient] = balances[recipient] + amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return allowed[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(amount <= balances[sender]);
        require(amount <= allowed[sender][msg.sender]);
        
        balances[sender] = balances[sender] - amount;
        allowed[sender][msg.sender] = allowed[sender][msg.sender] - amount;
        balances[recipient] = balances[recipient] + amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
    
    struct Vote {
        address voter;
        uint256 stake;
    }

    mapping(address => uint256) public stakes;
    mapping(uint256 => Vote[]) public votes;

    function stake(uint256 _amount) public {
        require(_amount <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - _amount;
        stakes[msg.sender] += _amount;
    }

    function vote(uint256 _proposalId) public {
        require(stakes[msg.sender] > 0, "Must stake before voting");
        votes[_proposalId].push(Vote(msg.sender, stakes[msg.sender]));
    }
}