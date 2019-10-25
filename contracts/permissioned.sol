pragma solidity 0.5.12;


contract Permissioned {

    constructor() public {
        authorized[msg.sender] = true;
        owner = msg.sender;
        emit AddAuthorized(msg.sender, msg.sender);
    }

    event ChangeOwner(
        address indexed _owner,
        address _newOwner
    );

    event AddAuthorized(
        address indexed _owner,
        address _authorized
    );

    event RemoveAuthorized(
        address indexed _owner,
        address _authorized
    );

    mapping(address => bool) public authorized;
    address public owner;

    modifier onlyOwner() {
        require(owner == msg.sender, "The sender is not the owner.");
        _;
    }

    modifier onlyAuthorized() {
        require(authorized[msg.sender], "The sender is not authorized.");
        _;
    }

    function addAuthorized(address _authorized) public onlyOwner {
        require(!authorized[_authorized], "The user is already authorized.");
        authorized[_authorized] = true;
        emit AddAuthorized(msg.sender, _authorized);
    }

    function removeAuthorized(address _authorized) public onlyOwner {
        require(
            owner != _authorized,
            "The owner cannot be deauthorized."
        );
        require(authorized[_authorized], "The user is not authorized.");
        authorized[_authorized] = false;
        emit RemoveAuthorized(msg.sender, _authorized);
    }

    function transferOwnership(address _authorized) public onlyOwner {
        require(owner != _authorized, "The new owner is the same.");
        authorized[_authorized] = true;
        owner = _authorized;
        emit ChangeOwner(owner, _authorized);
    }
}