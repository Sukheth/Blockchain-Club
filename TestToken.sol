pragma solidity ^0.5.16;

contract TestToken{
	
	string public name = "Test Token";
	string public symbol = "TESTT";
	uint256 public totalSupply;

	event Transfer(
		address indexed _from,
		address indexed _to,
		uint _value
	);

	event Approval(
		address indexed _owner,
		address indexed _spender,
		uint _value
	);

	mapping(address => uint256) public balanceOf;
	mapping(address => mapping(address => uint256)) public allowance;

	constructor(uint256 _initialSupply) public {
		balanceOf[msg.sender] = _initialSupply;
		totalSupply = _initialSupply;
	}

	function transfer(address _to, uint256 value) public returns (bool success)	{
		require(balanceOf[msg.sender] >= _value);
		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;

		Transfer(msg.sender, _to, _value);

		return true;
	}

	function approval(address _spender, uint _value) public returns (bool success){
		allowance[msg.sender][_spender] = _value;
		approval(msg.sender, _spender, _value);
		return true;
	}

	function transferFrom(address _from, address _to, uint256 _value){
		require(balanceOf[_from] >= _value);
		require(allowance[_from][msg.sender] >= _value);
		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;
		allowance[_from][msg.sender] -= _value;

		Transfer(_from, _to, _value);
		return true;
	}
}