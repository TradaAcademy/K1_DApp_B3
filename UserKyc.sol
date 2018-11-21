pragma solidity 0.4.24;

contract UserKyc{
    address public admin;
    struct User{
        address userAddr;
        string userName;
        string userEmail;
    }
    
    mapping (address => User) charityList;
    event AddUser(address indexed _userAddress, string _userName, string _userEmail);
    
    constructor(){
        admin = msg.sender;
    }
    
    function transferAdmin(address _adminAddr) public {
        require(msg.sender == admin);
        admin = _adminAddr;
        //require, assert
    }
   
     function addUser(address _userAddress, string _userName, string _userEmail){
        require(msg.sender == admin);
        charityList[_userAddress] = User(_userAddress, _userName, _userEmail);
        emit AddUser(_userAddress, _userName, _userEmail);
    }
    
    function isUserKyced(address _userAddress) constant public returns(bool){
        return charityList[_userAddress].userAddr == _userAddress;
        // 0x0, "", 0, default value 
        //optimatize
    }
    
    function removeUser(address _userAddres){
        require(msg.sender == admin);
        charityList[_userAddres] = User(0x0,"","");
    }
}
